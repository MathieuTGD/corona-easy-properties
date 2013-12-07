-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

require "appData"
data = appData.init()

print("version: " .. data:getGlobal("version"))


-- Fetching and setting a state variable
print("App Run Count (before): " .. data:getState("appRunCount"))
data:setState("appRunCount", data:getState("appRunCount")+1, true)
print("App Run Count (after): " .. data:getState("appRunCount"))




local center = display.contentCenterX
local pos = 50

local txtVersion = display.newText("Version (Global): ".. data:getGlobal("version"), center, pos, "Arial", 20 )
pos = pos + 30
local txtAppCount = display.newText("App Launched ".. data:getState("appRunCount") .. " times", center, pos, "Arial", 20 )
pos = pos + 30
local txtRandom = display.newText("Last random number: ".. data:getState("newVar", true), center, pos, "Arial", 20 )








local function bt(text, x, y) 
	local g = display.newGroup()

	local txt = display.newText(text, 0, 0, "Arial", 20)
	local bg = display.newRoundedRect(0, 0, txt.width + 10, txt.height + 8, 10)
	bg:setFillColor(.3,.3,.3)

	g:insert(bg)
	g:insert(txt)

	g.x = x
	g.y = y
	return g
end

pos = pos + 50
local btRandom = bt("Random", center, pos)
local txtRandomSet = display.newText(" ", center + btRandom.width + 5, pos, "Arial", 20 )
local function btRandomTap ()
	local r = math.random(1000)
	print("Random (before): " .. data:getState("newVar"))
	data:setState("newVar", r, true)
	print("Random (after): " .. data:getState("newVar")) 
	txtRandomSet.text = r
end
btRandom:addEventListener("tap", btRandomTap)



pos = pos + 75
local btReset = bt("Reset", center, pos)
local txtReset = display.newText(" ", center + btReset.width + 5, pos, "Arial", 20 )
local function btResetTap ()
	data:resetState()
	txtReset.text = "Reset" 
end
btReset:addEventListener("tap", btResetTap)


