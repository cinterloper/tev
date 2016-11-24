
_G.io_loop_instance = nil
_G.rc = nil
_G.r = nil
_G.TURBO_STATIC_MAX = nil
_G.TURBO_SOCKET_BUFFER_SZ = nil
_G.SIGCHLD = nil
_G.SIGIO = nil
_G.__TURBO_USE_LUASOCKET__ = false
_G.TURBO_SSL = false
local turbo = require "turbo"

terralib.includepath = terralib.includepath..";./TCP-eventbus-client-C/include/;/opt/terra-Linux-x86_64-332a506/include/"

local C = terralib.includecstring([[
#include "vertx.h"
#include "parson.h"

]])



for key,value in pairs(C) do
  print(key)
end
