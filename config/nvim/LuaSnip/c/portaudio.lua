local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
{
  -- Callback function
  s({trig = "pacb", snippetType="autosnippet"},
    fmta(
      [[
      static int PaCallback(const void* inputStream, void* outputStream,
                                  unsigned long frames,
                                  const PaStreamCallbackTimeInfo* timeInfo,
                                  PaStreamCallbackFlags statusFlags,
                                  void* userData ) {
          <>
      }
      ]],
      { 
        i(0),
      }
    ),
    { condition = line_begin }
  ),
  -- StreamFinished function
  s({trig = "pasf", snippetType="autosnippet"},
    fmt(
      [[
      static void PaStreamFinished(void* userData) {{
          PaUserData* data = (PaUserData*) userData;
          printf("Stream completed: %s\n", data->message);
      }}
      ]],
      { }
    ),
    { condition = line_begin }
  ),
    -- error label and jump target
  s({trig = "pael", snippetType="autosnippet"},
    fmt(
      [[
      error:
          Pa_Terminate();
          fprintf(stderr, "An error occurred while using the PortAudio stream\n" );
          fprintf(stderr, "Error number: %d\n", err );
          fprintf(stderr, "Error message: %s\n", Pa_GetErrorText(err));
          return err;
      ]],
        { }
      ),
      { condition = line_begin }
    ),
    -- PaStreamParameters
    s({trig = "pasp", snippetType="autosnippet"},
      fmt(
        [[
        PaStreamParameters {};
        ]],
        { i(1, "params") }
      ),
      { condition = line_begin }
    ),
    -- PaStream
    s({trig = "pastt", snippetType="autosnippet"},
      fmt(
        [[
        PaStream* {};
        ]],
        { i(1, "stream") }
      ),
      { condition = line_begin }
    ),
    -- PaError
    s({trig = "paerr", snippetType="autosnippet"},
      fmt(
        [[
        PaError {};
        ]],
        { i(1, "err") }
      ),
      { condition = line_begin }
    ),
    -- PaUserData
    s({trig = "paud", snippetType="autosnippet"},
      fmt(
        [[
        PaUserData
        ]],
        {}
      )
    ),
    -- Pa_Initialize()
    s({trig = "paini", snippetType="autosnippet"},
      fmt(
        [[
        err = Pa_Initialize();
        if(err != paNoError) goto error;
        ]],
        { }
      ),
      { condition = line_begin }
    ),
    -- Query output devices
    s({trig = "paqod", snippetType="autosnippet"},
      fmt(
        [[
        params.device = Pa_GetDefaultOutputDevice();
        if (params.device == paNoDevice) {{
            fprintf(stderr,"Error: No default output device.\n");
            goto error;
        }}
        ]],
        { }
      ),
      { condition = line_begin }
    ),
    -- Pa_OpenStream() (open output stream)
    s({trig = "paoos", snippetType="autosnippet"},
      fmt(
        [[
        err = Pa_OpenStream(
                  &stream,
                  NULL,
                  &params,
                  {},
                  {},
                  paNoFlag,
                  PaCallback,
                  &data );
        if( err != paNoError ) goto error;
        ]],
        { i(1, "FS"), i(2, "BUF_SIZE") }
      ),
      { condition = line_begin }
    ),
    -- Pa_SetStreamFinishedCallback()
    s({trig = "passfc", snippetType="autosnippet"},
      fmt(
        [[
        err = Pa_SetStreamFinishedCallback(stream, &PaStreamFinished);
        if( err != paNoError ) goto error;
        ]],
        {}
      ),
      { condition = line_begin }
    ),
    -- Pa_StartStream()
    s({trig = "pastart", snippetType="autosnippet"},
      fmt(
        [[
        err = Pa_StartStream(stream);
        if(err != paNoError) goto error;
        ]],
        {}
      ),
      { condition = line_begin }
    ),
    -- Pa_StopStream()
    s({trig = "pastop", snippetType="autosnippet"},
      fmt(
        [[
        err = Pa_StopStream(stream);
        if(err != paNoError) goto error;
        ]],
        {}
      ),
      { condition = line_begin }
    ),
    -- Pa_CloseStream()
    s({trig = "paclose", snippetType="autosnippet"},
      fmt(
        [[
        err = Pa_CloseStream(stream);
        if(err != paNoError) goto error;
        ]],
        {}
      ),
      { condition = line_begin }
    ),
    -- Pa_Terminate()
    s({trig = "paterm", snippetType="autosnippet"},
      fmt(
        [[
        Pa_Terminate();
        ]],
        {}
      ),
      { condition = line_begin }
    ),
    -- Pa_Sleep()
    s({trig = "pasleep", snippetType="autosnippet"},
      fmt(
        [[
        Pa_Sleep({});
        ]],
        { i(1, "sleepms") }
      ),
      { condition = line_begin }
    ),
    -- Params: channelCount
    s({trig = "papcc", snippetType="autosnippet"},
      fmt(
        [[
        params.channelCount = {};
        ]],
        { i(1, "CHANNELS") }
      ),
      { condition = line_begin }
    ),
    -- Params: sampleFormat
    s({trig = "papsf", snippetType="autosnippet"},
      fmt(
        [[
        params.sampleFormat = {};
        ]],
        { i(1, "paFloat32") }
      ),
      { condition = line_begin }
    ),
    -- Params: suggestedLatency
    s({trig = "papsl", snippetType="autosnippet"},
      fmt(
        [[
        params.suggestedLatency = Pa_GetDeviceInfo(params.device)->defaultLowOutputLatency;
        ]],
        {}
      ),
      { condition = line_begin }
    ),
  }
