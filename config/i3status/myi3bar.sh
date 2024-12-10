# Source: https://en.jeffprod.com/blog/2020/create-your-own-i3-sway-status-bar/
# See also original source code at https://en.jeffprod.com/blog/2020/create-your-own-i3-sway-status-bar/

# --------------------------------------------- #
# Send the header so that i3bar knows we want to use JSON:
echo '{ "version": 1 }'

# Begin the endless array.
echo '['

# We send an empty first array of blocks to make the loop simpler:
echo '[]'

# Now send blocks with information forever:
while :;
do
  echo ",["
  echo "{\"name\":\"id_time\",\"background\":\"#546E7A\",\"full_text\":\"$(date)\"}"
  echo "]"
  sleep 1
done
