_G._ENV=nil
_G.error_message = nil
terralib.includepath = terralib.includepath..";./ext/TCP-eventbus-client-C/include/;/opt/terra-Linux-x86_64-332a506/include/"
package.path = package.path .. ';./ext/LuLPeg/?.lua;./ext/?.lua'
local JSON = (loadfile "ext/JSON.lua")() -- one-time load of the routines
local jp = require "jsonpath"

local argparse = require "argparse"

local parser = argparse("script", "An example.")
parser:argument("input", "Input file.")
parser:option("-o --output", "Output file.", "a.out")
parser:option("-I --include", "Include locations."):count("*")

local args = parser:parse()
print(args) 


print(args[1])

local C = terralib.includecstring([[
#include "vertx.h"
#include "parson.h"

]])
function print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end
--for i,j in pairs(C) do
--  if terralib.type(j) == "terrafunction" then
--    print(i)
--    print(JSON:encode_pretty(j:gettype().parameters))
--  end
--  print(print(terralib.type(j) ))
--end
print_r(C.eventbus_register:gettype().parameters)
