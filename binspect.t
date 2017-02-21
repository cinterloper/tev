_G._ENV=nil
_G.error_message = nil
terralib.includepath = terralib.includepath..";./ext/TCP-eventbus-client-C/include/;/opt/terra-Linux-x86_64-332a506/include/"package.path = package.path .. ';./ext/LuLPeg/?.lua;./ext/?.lua'
local JSON = (loadfile "ext/JSON.lua")() -- one-time load of the routines
local jp = require "jsonpath"
require "tbase"
local argparse = require "argparse"

local parser = argparse("binspect", "low level reflection utility")
parser:argument("input", "Input file.")
parser:option("-o --output", "Output directory.", "generated/")
parser:option("-m --member", "inspect member named ")
parser:option("-d --dump", "dump member named ")
parser:option("-I --include", "Include locations."):count("*")

local args = parser:parse()


--print_r(args)

local C = terralib.includec(args["input"])


function f_lookup( name ) 
        local output = {}
        local wrapper = {}
        output["returntype"] = {}
        output["args"] = {}
        local _type = C[name]:gettype()
        local _params = _type.parameters
        for i,j in pairs(_params) do
          output.args[i]={}
--          print(" position " .. i)
--          print("name")
--          print(j.name)
          output.args[i].name=j.name
          output.args[i].typename=j.type.name
 --         print("parm")
          if j.type.returntype then
--            print("function pointer?")
          output.args[i].fnptr=true
          end
--          print_r(j)
        end

        output.returntype.name=_type.returntype.name
        if _type.returntype.type then
          output.returntype.typename=_type.returntype.type.name
          if _type.returntype.type.returntype then
            output.returntype.fncptr=true
          end

        end
        wrapper[name]=output
        print(JSON:encode(wrapper))
end


if args["member"] then
  f_lookup(args["member"])
elseif args["dump"] then
  print_r(C[args["dump"]])
else
  for i,j in pairs(C) do
    if terralib.type(j) == "terrafunction" then
      print(i)
      f_lookup(i)
    end
  --  print(print(terralib.type(j) ))
  end
--print_r(C.eventbus_register:gettype().parameters)
end
