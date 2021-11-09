#!/bin/sh
# Given a line in a LYTEX file, finds the corresponding line ...
# ... in TEX file associated with the LYTEX file, and vice versa

# The algorithm works the same in either direction, so I use ...
# ... the idea of "source" and "target" file rather than ...
# ... "LYTEX" or "TEX" file. Thus...

# Input:  line in source file; paths to source and target file
# Output: line in target file corresponding to line in source file

# Arguments:
# Argument 1: line in source file
# Argument 2: full path to source file
# Argument 3: full path to target file

_VERBOSE=0
while getopts "v" option
do
  case ${option} in
    v) _VERBOSE=1
      ;;
  esac
done

function log() {
    if [ ${_VERBOSE} -eq 1 ]
    then
        echo "$@"
    fi
}

log "${1}"
log "${2}"
log "${3}"

# rename arguments for semantics only
source_line="${1}"
source_file="${2}"
target_file="${3}"

START="%<LILY_START>"
END="%<LILY_END>"


# initialize variables for parsing source file
# --------------------------------------------- #
line_counter=0  # counts number of lines read in source file
in_context=0  # boolean 0(1) if line in source file is outside(inside) LilyPond 
source_starts_passed=0  # counts the number of %<LILY_START> comments passed in source file before reaching source_line
source_ends_passed=0  # counts the number of %<LILY_END> comments passed in source file before reaching source_line
lines_since_last_end=0  # count lines in source file passed since last %<LILY_END> comment passed in source file
# --------------------------------------------- #


# BEGIN READING SOURCE FILE
# --------------------------------------------- #
while read line  # read through source file line by line
do
  if [ ${line_counter} -eq ${source_line} ]  # exit upon reaching source_line
  then
    break
  fi

  if [ "${line}" = "${START}" ]   # if line begins a LilyPond context
  then
    in_context=1
    source_starts_passed=$((${source_starts_passed}+1))
    lines_since_last_end=0
  elif [ "${line}" = "${END}" ]   # if line ends a LilyPond context
  then
    in_context=0
    source_ends_passed=$((${source_ends_passed}+1))
  else                            # if line does not begin with "%<LILY>"
    if [ ${in_context} -ne 1 ]  # if line is outside LilyPond context
    then
      lines_since_last_end=$((${lines_since_last_end}+1))
    fi
  fi
  line_counter=$((${line_counter}+1))

done < ${source_file}
# --------------------------------------------- #
# END READING SOURCE FILE


log "STARTs passed: ${source_starts_passed}"
log "ENDs passed: ${source_ends_passed}"
log "Lines since last END: ${lines_since_last_end}"
log ""
log "In context at exit? ${in_context}"
log "Line counter at exit: ${line_counter}"


if [ ${source_starts_passed} -eq 0 ]
then
  log "Returning target line ${lines_since_last_end}"
  echo ${lines_since_last_end}
  exit 0
fi


# initialize variables for parsing target file
# --------------------------------------------- #
line_counter=0  # reset line_counter to count lines in target file
target_starts_passed=0  # counts the number of %<LILY_START> comments passed in target file
target_ends_passed=0  # counts the number of %<LILY_END> comments passed in target file
# --------------------------------------------- #


# BEGIN READING TARGET FILE
# --------------------------------------------- #
if [ ${in_context} -eq 1 ]  # if source_line is inside LilyPond context
then
  while read line  # read through target file line by line
  do
    if [ "${line}" = "${START}" ]   # if line begins a LilyPond context
    then
      target_starts_passed=$((${target_starts_passed}+1))
      if [ ${target_starts_passed} -eq ${source_starts_passed} ]  # return case
      then
        log "Returning target line $((${line_counter}+1))"
        echo $((${line_counter}+1))
        exit 0
      fi
    fi
    line_counter=$((${line_counter}+1))
  done < ${target_file}

else  # if source_line is outside LilyPond context
  while read line  # read through target file line by line
  do
    if [ "${line}" = "${END}" ]   # line ends a LilyPond context
    then
      target_ends_passed=$((${target_ends_passed}+1))
      if [ ${target_ends_passed} -eq ${source_ends_passed} ]
      then
        log "Returning target line $((${line_counter}+${lines_since_last_end}+1))"
        echo $((${line_counter}+${lines_since_last_end}+1))
        exit 0
      fi
    fi
    line_counter=$((${line_counter}+1))
  done < ${target_file}
fi
# --------------------------------------------- #
# END READING TARGET FILE

# safety case---should never be reached
echo 0
exit 1
