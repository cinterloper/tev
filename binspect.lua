_G._ENV=nil
_G.error_message = nil
terralib.includepath = terralib.includepath..";./ext/TCP-eventbus-client-C/include/;/opt/terra-Linux-x86_64-332a506/include/"
package.path = package.path .. ';./ext/LuLPeg/?.lua;./ext/?.lua'
local JSON = (loadfile "ext/JSON.lua")() -- one-time load of the routines
local jp = require "jsonpath"
require "tbase"
local argparse = require "argparse"

local parser = argparse("binspect", "low level reflection utility")
parser:argument("input", "Input file.")
parser:option("-o --output", "Output directory.", "generated/")
parser:option("-m --member", "inspect member named ")
parser:option("-I --include", "Include locations."):count("*")

local args = parser:parse()

print_r(args)

local C = terralib.includec(args["input"])




if args["member"] then
     try = pcall(function()
        print(JSON:encode_pretty(C[args["member"]]:gettype().parameters))
      end)
      if not try then
        print_r(C[args["member"]]:gettype().parameters)
      end
else
  for i,j in pairs(C) do
    if terralib.type(j) == "terrafunction" then
      print(i)

        try = pcall(function()
          print(JSON:encode_pretty(j:gettype().parameters))
        end)
        if not try then
          print_r(j:gettype().parameters)
        end

    end
  --  print(print(terralib.type(j) ))
  end
--print_r(C.eventbus_register:gettype().parameters)
end
