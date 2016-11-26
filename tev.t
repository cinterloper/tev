_G.error_message = nil
local JSON = (loadfile "ext/JSON.lua")() 

function readAll(file)
    local f = io.open(file, "rb")
    local content = f:read("*all")
    f:close()
    return content
end

function keySet(tbl)
  local keyset ={}
  local n = 0
  for k,v in pairs(tbl) do
    n=n+1
    keyset[n]=k
  end
  return keyset
end

f = readAll("example-net.iowntheinter.kvdn.service.kvsvc.json")
d = JSON:decode(f)

terralib.includepath = terralib.includepath..";./ext/TCP-eventbus-client-C/include/;/opt/terra-Linux-x86_64-332a506/include/"

local C = terralib.includecstring([[
#include "vertx.h"
#include "parson.h"

]])

function gen_native_methods()
  local methods = {}
  for key,value in pairs(d) do
  --methods[key] = terra(env : &int8, [params])
  --var [ENV] = jvm.Env{env}
  --return declare.unwrap(f(wrapped))
    print(key)
  end
end

function gen_header() -- (nativeMethodTable?)
  local handle = io.popen("envtpl < header_templ.jinja")
  local result = handle:read("*a")
  handle:close()
  print(result)
end

--function save_shared_object()
  
--end

gen_native_methods()
gen_header()
--save_shared_object()
