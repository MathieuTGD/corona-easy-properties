-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

require "appData"
data = appData.new()

print("version: " .. data:getGlobal("version"))


-- Fetching and setting a state variable
print("App Run Count (before): " .. data:getState("appRunCount"))
data:setState("appRunCount", data:getState("appRunCount")+1, true)
print("App Run Count (after): " .. data:getState("appRunCount"))


-- Adding a new variable to State which was not defined in the state default
print("New Var (before): " .. data:getState("newVar"))
data:setState("newVar", "somthing new " .. math.random(1000), true)
print("New Var(after): " .. data:getState("newVar")) 