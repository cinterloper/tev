

function loadClib(libname)
  terralib.
  return terralib.includec(libname)
end

local vx = loadClib("vertx.h")
local jp = loadClib("parson.h")
local uuid = loadClib("uuid.h")
local exports = {}
--there is only 1 channel per svc proxy
local struct handler {
  address : &rawstring,
  fn: ({&rawstring} -> {})
}
local 
local struct vxc {
  endpoint : rawstring

}
local struct jsonMessage_t {
  type: rawstring,
  address: rawstring,
  headers: *jp.JSON_value,
  replyAddress: rawstring,
  body: *jp.JSON_value
}

function make_rpc_caller(name,rfParams)
  local headers = {}
  headers.action=name
  local channel = rfParams["channel"]
  local j_headers = JSON:encode("headers")
  local terra f (data: rawstring, cb: ({rawstring} -> {}))
    vx.eventbus_send([channel],[channel],[headers],data)
    
  end
  return f
end

terra cb_dispatch( data : rawstring )
  var headers : rawstring = json_decode(data,"headers")
  var req_id : rawstring = json_decode(headers,"req_id")
  var cb : ({rawstring} -> {}) = 
end

local DRIVER_CHANNEL = terralib.global(driver_channel)
terra init_driver(configuration: rawstring)
  
  vx.setHost(vx.endpoint)
  vx.setPort(7000)
  vx.create_eventbus()
  vx.start_eventbus()

  vx.eventbus_register(DRIVER_CHANNEL,cb_dispatch)
end

local exports = {}
for i,j in pairs(interface_methods) do
  exports[i]=make_rpc_caller(j)
end

terralib.saveobj("terrabash.so","sharedlibrary",exports,{"-L ext/vertx-bus-c/build", "-lvertx", "-lparseon",  "-lpthread" } )


