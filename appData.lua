-----------------------------------------------------------------------------------------
--
-- appData.lua
--
-----------------------------------------------------------------------------------------

print("[[appData]] loaded...")


appData = {}
local json = require('json')

local initData = require "appDataInit"
local appGlobalData = initData.appGlobalData
local stateDefault = initData.stateDefault
local stateData

-- Forward References
local doesFileExist





----------------------------
-- appData functions
----------------------------

function appData.init()
	appData.globals = appGlobalData
	appData.state = appData:fetchState()
	return appData
end

function appData:saveState ()
	if appData.state then
		print("[[appData]] saveState()")
		local saveData = json.encode(appData.state)
		local path = system.pathForFile( "appState.txt", system.DocumentsDirectory )
		local file = io.open(path, "w")
		file:write( saveData )
		io.close(file)
		file = nil
		return true
	else 
		return false
	end
end

function appData:fetchState ()
	local savedData = stateDefault
	if doesFileExist("appState.txt", system.DocumentsDirectory) then
		local path = system.pathForFile("appState.txt", system.DocumentsDirectory)
		local file = io.open(path, "r")
		savedData = json.decode(file:read( "*a" ))
		io.close(file)
		file = nil
		print("[[appData]] fetchState() Fetching data...")
		if type(savedData) ~= "table" then
			savedData = stateDefault
			print("[[appData]] fetchState() Wrong datatype or corrupted data, returning default data")
		end
	else
		print("[[appData]] fetchState() No file found, returning default data")
	end
	return savedData
end


function appData:getGlobal (key)
	if appData.globals[key] then 
		return appData.globals[key]
	else 
		return nil
	end
end

function appData:getState (key, isNumeric)
  if appData.state[key] then 
    print("[[appData]] Getting state " .. key)
    return appData.state[key]
  elseif stateDefault[key] then
    print("[[appData]] State " .. key .. " not found, returning default value")
    return stateDefault[key]
  else
    print("[[appData]] State " .. key .. " or default value not found, returning empty string/number")
    if isNumeric then
      return 0
    else
      return ""
    end
  end
end

function appData:setState(key, val, saveState)
	saveState = saveState or false
	appData.state[key] = val
	print("[[appData]] State changed")
	if saveState then
		appData:saveState()
	end
end

function appData:resetState()
	appData.state = initData.stateDefault
	appData:saveState()
end



----------------------------
-- Some other functions
----------------------------

function doesFileExist( fname, path )

    local results = false

    local filePath = system.pathForFile( fname, path )

    --filePath will be 'nil' if file doesn't exist and the path is 'system.ResourceDirectory'
    if ( filePath ) then
        filePath = io.open( filePath, "r" )
    end

    if ( filePath ) then
        print( "File found: " .. fname )
        --clean up file handles
        filePath:close()
        results = true
    else
        print( "[[appData]] File does not exist: " .. fname )
    end

    return results
end