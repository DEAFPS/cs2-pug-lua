----------------------------------------------------------
-- A Counter-Strike: 2 Server Pug plugin written in LUA --
----------------------------------------------------------
-- Written by @DEAFPS_ -----------------------------------
----------------------------------------------------------

function HC_ReplaceColorCodes_pug(text)
	text = string.gsub(text, "{white}", "\x01")
	text = string.gsub(text, "{darkred}", "\x02")
	text = string.gsub(text, "{purple}", "\x03")
	text = string.gsub(text, "{darkgreen}", "\x04")
	text = string.gsub(text, "{lightgreen}", "\x05")
	text = string.gsub(text, "{green}", "\x06")
	text = string.gsub(text, "{red}", "\x07")
	text = string.gsub(text, "{lightgray}", "\x08")
	text = string.gsub(text, "{yellow}", "\x09")
	text = string.gsub(text, "{orange}", "\x10")
	text = string.gsub(text, "{darkgray}", "\x0A")
	text = string.gsub(text, "{blue}", "\x0B")
	text = string.gsub(text, "{darkblue}", "\x0C")
	text = string.gsub(text, "{gray}", "\x0D")
	text = string.gsub(text, "{darkpurple}", "\x0E")
	text = string.gsub(text, "{lightred}", "\x0F")
	return text
end

function HC_PrintChatAll_pug(text)		
	ScriptPrintMessageChatAll(" " .. HC_ReplaceColorCodes_pug(chatPrefix .. text))
end

function tableContains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

function checkBanlist(event)
	local steamId = tostring(event.networkid)
	local username = tostring(event.name)
	
	if tableContains(bannedPlayers, steamId) then
		print("[Banlist] " .. username .. " isnt allowed on this server")
		SendToServerConsole("kickid " .. event.userid .. " You have been banned!")
	end
end

function checkWL(event)
	local steamId = tostring(event.networkid)
	local username = tostring(event.name)

	if tableContains(allowedPlayers, steamId) or tableContains(adminPlayers, steamId) then
		print("[Whitelist] " .. username .. " is allowed on this server")
	else
		print("[Whitelist] " .. username .. " not on whitelist, kicking...")
		SendToServerConsole("kickid " .. event.userid .. " You are not on the whitelist!")
	end  
end

function UserIdPawnToPlayerPawn(useridPawn)
    return EntIndexToHScript(bit.band(useridPawn, 16383))
end

function GetPlayerNameByID(userid)
    local playerData = connectedPlayers[userid]
    if playerData then
        return playerData.name
    else
        return "756e6b6e6f776e"
    end
end

function GetPlayerPawnByID(userid)
    local playerData = connectedPlayers[userid]
    if playerData then
        return playerData.playerpawn
    else
        return "unknown"
    end
end

function GetPlayerNameByPawn(playerpawn)
    for _, playerData in pairs(connectedPlayers) do
        if playerData.playerpawn == playerpawn then
            return tostring(playerData.name)
        end
    end
    return "unknown"
end

function GetUserIDByPawn(playerpawn)
    for _, playerData in pairs(connectedPlayers) do
        if playerData.playerpawn == playerpawn then
            return tonumber(playerData.userid)
        end
    end
    return "unknown"
end

function GetTempNadeDataByPawn(playerpawn)
    for _, playerData in pairs(connectedPlayers) do
        if playerData.playerpawn == playerpawn then
            return playerData.tempNadeName, playerData.tempNadeDesc, playerData.tempNadeType
        end
    end
    return "unknown"
end

function mvmntSettings(setting)
	if setting == "kz" then
		SendToServerConsole("sv_cheats 1")
		SendToServerConsole("sv_accelerate 6.5")
		SendToServerConsole("sv_accelerate_use_weapon_speed 0")
		SendToServerConsole("sv_airaccelerate 100.0")
		SendToServerConsole("sv_air_max_wishspeed 30.0")
		SendToServerConsole("sv_enablebunnyhopping 1")
		SendToServerConsole("sv_friction 5.0")
		SendToServerConsole("sv_gravity 800.0")
		SendToServerConsole("sv_jump_impulse 301.993377")
		SendToServerConsole("sv_ladder_scale_speed 1.0")
		SendToServerConsole("sv_maxspeed 320.0")
		SendToServerConsole("sv_maxvelocity 2000.0")
		SendToServerConsole("sv_staminajumpcost 0.0")
		SendToServerConsole("sv_staminalandcost 0.0")
		SendToServerConsole("sv_staminamax 0.0")
		SendToServerConsole("sv_staminarecoveryrate 0.0")
		SendToServerConsole("sv_standable_normal 0.7")
		SendToServerConsole("sv_timebetweenducks 0.0")
		SendToServerConsole("sv_wateraccelerate 10.0")
		SendToServerConsole("sv_cheats 0")
		currentMvmntSettings = "KZ"
	end
	
	if setting == "vnl" then
		SendToServerConsole("sv_cheats 1")
		SendToServerConsole("sv_accelerate 5.5")
		SendToServerConsole("sv_accelerate_use_weapon_speed 1")
		SendToServerConsole("sv_airaccelerate 12.0")
		SendToServerConsole("sv_air_max_wishspeed 30.0")
		SendToServerConsole("sv_enablebunnyhopping 0")
		SendToServerConsole("sv_friction 5.2")
		SendToServerConsole("sv_gravity 800.0")
		SendToServerConsole("sv_jump_impulse 301.993377")
		SendToServerConsole("sv_ladder_scale_speed 0.78")
		SendToServerConsole("sv_maxspeed 320.0")
		SendToServerConsole("sv_maxvelocity 3500.0")
		SendToServerConsole("sv_staminajumpcost 0.08")
		SendToServerConsole("sv_staminalandcost 0.05")
		SendToServerConsole("sv_staminamax 80.0")
		SendToServerConsole("sv_staminarecoveryrate 60.0")
		SendToServerConsole("sv_timebetweenducks 0.4")
		SendToServerConsole("sv_wateraccelerate 10.0")
		SendToServerConsole("sv_cheats 0")
		currentMvmntSettings = "VNL"
	end
	
end

function setGeneralSettings()
	SendToServerConsole("bot_kick")
	SendToServerConsole("mp_ignore_round_win_conditions 0")
	SendToServerConsole("mp_limitteams " .. teamSize )
	SendToServerConsole("mp_team_timeout_max " .. timeoutsPerTeam )
	SendToServerConsole("mp_team_timeout_time " .. timeoutDuration )
	SendToServerConsole("mp_randomspawn 0")
	SendToServerConsole("mp_teammates_are_enemies 0")
	
	SendToServerConsole("mp_respawn_on_death_t 0")
	SendToServerConsole("mp_respawn_on_death_ct 0")
	SendToServerConsole("mp_autoteambalance 1")
	SendToServerConsole("mp_timelimit 0")
	SendToServerConsole("mp_roundtime 1.920000")
	SendToServerConsole("mp_roundtime_hostage 1.920000")
	SendToServerConsole("mp_roundtime_defuse 1.920000")
	SendToServerConsole("mp_freezetime 15")
	SendToServerConsole("mp_halftime 1")
	SendToServerConsole("mp_halftime_duration 15")
	SendToServerConsole("mp_match_end_restart 0")
	SendToServerConsole("mp_match_restart_delay 25")
	SendToServerConsole("mp_round_restart_delay 7")
	SendToServerConsole("mp_maxrounds 24")
	SendToServerConsole("ammo_grenade_limit_total 4")
	SendToServerConsole("sv_infinite_ammo 0")
	SendToServerConsole("mp_maxmoney 16000")
	SendToServerConsole("mp_startmoney 800")
	SendToServerConsole("mp_buytime 20")
	SendToServerConsole("mp_buy_anywhere 0")
	SendToServerConsole("mp_drop_knife_enable 0")
	SendToServerConsole("mp_drop_grenade_enable 1")
	SendToServerConsole("mp_anyone_can_pickup_c4 0")
	SendToServerConsole("sv_grenade_trajectory_prac_pipreview 0")
	SendToServerConsole('mp_t_default_grenades 0')
	SendToServerConsole('mp_ct_default_grenades 0')
	SendToServerConsole("mp_restartgame 1")
	SendToServerConsole("sv_cheats 0")
	
	if useCustomCFG == true then
		SendToServerConsole("exec " .. customCFG )
	end
end

function setPraccSettings()
	SendToServerConsole("bot_kick")
	SendToServerConsole("mp_ignore_round_win_conditions 0")
	SendToServerConsole("mp_limitteams " .. teamSize )
	SendToServerConsole("mp_team_timeout_max " .. timeoutsPerTeam )
	SendToServerConsole("mp_team_timeout_time " .. timeoutDuration )
	SendToServerConsole("mp_randomspawn 0")
	SendToServerConsole("mp_teammates_are_enemies 0")
	
	SendToServerConsole("mp_warmup_end")
	SendToServerConsole("sv_cheats 1")
	SendToServerConsole("mp_respawn_on_death_t 1")
	SendToServerConsole("mp_respawn_on_death_ct 1")
	SendToServerConsole("mp_autoteambalance 0")
	SendToServerConsole("mp_timelimit 0")
	SendToServerConsole("mp_roundtime 60")
	SendToServerConsole("mp_roundtime_hostage 60")
	SendToServerConsole("mp_roundtime_defuse 60")
	SendToServerConsole("mp_freezetime 0")
	SendToServerConsole("mp_halftime 0")
	SendToServerConsole("mp_halftime_duration 0")
	SendToServerConsole("mp_match_end_restart 1")
	SendToServerConsole("mp_match_restart_delay 3")
	SendToServerConsole("mp_round_restart_delay 1")
	SendToServerConsole("mp_maxrounds 9999")
	SendToServerConsole("ammo_grenade_limit_total 5")
	SendToServerConsole("sv_infinite_ammo 1")
	SendToServerConsole("mp_maxmoney 60000")
	SendToServerConsole("mp_startmoney 60000")
	SendToServerConsole("mp_buytime 9999")
	SendToServerConsole("mp_buy_anywhere 1")
	SendToServerConsole("mp_drop_knife_enable 1")
	SendToServerConsole("mp_drop_grenade_enable 1")
	SendToServerConsole("mp_anyone_can_pickup_c4 1")
	SendToServerConsole('mp_ct_default_grenades "weapon_incgrenade weapon_hegrenade weapon_flashbang weapon_smokegrenade"')
	SendToServerConsole('mp_t_default_grenades "weapon_incgrenade weapon_hegrenade weapon_flashbang weapon_smokegrenade"')
	SendToServerConsole("mp_restartgame 1")
	SendToServerConsole("sv_grenade_trajectory_prac_pipreview 1")
	
	if loadPraccNades == true then
		SendToServerConsole("exec dea_pugplugin_praccnades")
	end
end

function printPraccHelp()
	ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
	ScriptPrintMessageChatAll(" \x03" .. "Commands:")
	ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
	ScriptPrintMessageChatAll(" \x03" .. 'savenade "mynade" "type" "description"')
	ScriptPrintMessageChatAll(" \x0D" .. 'Saves a nade lineup with the given name, description and type')
	ScriptPrintMessageChatAll(" \x0D" .. 'Valid types: smoke, he, falsh, molly')
	ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
	ScriptPrintMessageChatAll(" \x03" .. "loadnade mynade")
	ScriptPrintMessageChatAll(" \x0D" .. "Loads a nade lineup")
	ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
	ScriptPrintMessageChatAll(" \x03" .. 'importnade "code"')
	ScriptPrintMessageChatAll(" \x0D" .. 'Imports a nade from a nade code')
	ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
	ScriptPrintMessageChatAll(" \x03" .. "allsmoke")
	ScriptPrintMessageChatAll(" \x0D" .. "Shows all saved smokes")
	ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
	ScriptPrintMessageChatAll(" \x03" .. "allmolly")
	ScriptPrintMessageChatAll(" \x0D" .. "Shows all saved molotovs")
	ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
	ScriptPrintMessageChatAll(" \x03" .. "allhe")
	ScriptPrintMessageChatAll(" \x0D" .. "Shows all saved HE nades")
	ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
	ScriptPrintMessageChatAll(" \x03" .. "allflash")
	ScriptPrintMessageChatAll(" \x0D" .. "Shows all saved flashes")
	ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
	ScriptPrintMessageChatAll(" \x03" .. "pracchelp")
	ScriptPrintMessageChatAll(" \x0D" .. "Prints these commands in chat")
	ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
	ScriptPrintMessageChatAll(" \x03" .. "godmode")
	ScriptPrintMessageChatAll(" \x0D" .. "Enables God Mode")
	ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
end

function printAdminHelp()
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. " Commands:")
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. " adminsay hello - prints a message in chat with a admin nametag")
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. " startpug - starts the pug")
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. ' pausepug - pauses the pug')
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. " unpausepug - unpauses the pug")
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. " restartpug - compleatly restarts the pug")
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. " scramble - shuffles teams")
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. " rewarmup - restarts warmup phase")
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. " pugkick id - kicks the player")
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. " unpausepug - unpauses the pug")
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. " changemap de_dust2 - changes map")
	ScriptPrintMessageChatAll(" \x01 [ADMIN] \x0B" .. " adminhelp - prints these commands in chat")
end

function checkPlayerPawnForAdminStatus(playerPawnToCheck)
    for _, playerData in pairs(connectedPlayers) do
        if playerData.playerpawn == playerPawnToCheck then
            if playerData.admin == true then
                return true
            else
                return false
            end
        end
    end
    print("Player pawn not found")
end

function KickAllPlayers()
    for userid, _ in pairs(connectedPlayers) do
        SendToServerConsole("kickid " .. userid .. " server is changing map, please reconnect")
    end
end

function removeFromVoted(userid)
    for index, id in ipairs(playersThatVoted) do
        if id == userid then
            table.remove(playersThatVoted, index)
            return
        end
    end
end

function checkAdmin(steamid, event)
    if tableContains(adminPlayers, steamid) then
		print("admin connected: " .. tostring(event.name))
		return true
	else
		return false
	end
end

function switch(t)
    return t.case or function (self, value)
        local f = self[value] or self.default
        if f then
            if type(f) == "function" then
                f(value)
            else
                error("case " .. tostring(value) .. " is not a function")
            end
        end
    end
end

function intToIp(int)
	return bit.rshift(bit.band(int, 0xFF000000), 24) .. "." .. bit.rshift(bit.band(int, 0x00FF0000), 16) .. "." .. bit.rshift(bit.band(int, 0x0000FF00), 8) .. "." .. bit.band(int, 0x000000FF)
end

function sendClientCMD(cmd, user, delay)

	delayy = delay or 0.1
	
	local ClientCmd = Entities:FindByClassname(nil, "point_clientcommand")
	
	if ClientCmd == nil then
		ClientCmd = SpawnEntityFromTableSynchronous("point_clientcommand", { targetname = "vscript_clientcommand" })
	else
		--clientCmd already there
	end
	
	DoEntFireByInstanceHandle(ClientCmd, "command", cmd, 1, user, user)
end

function addNadeData(playerpawn, nadeID, ntype, desc, locationVector, angleVector, indicatorXYZ)
	for _, playerData in pairs(connectedPlayers) do
        if playerData.playerpawn == playerpawn then
            playerData.savedNades[nadeID] = {
                location = locationVector,
                angle = angleVector,
				description = desc,
				nadeType =  ntype,
				indicator = indicatorXYZ
            }
            return
        end
    end
    print("Player not found with pawn: ", playerpawn)
end


function GetSavedNadeByPawnAndID(playerpawn, nadeID)
    for _, playerData in pairs(connectedPlayers) do
        if playerData.playerpawn == playerpawn then
            return playerData.savedNades[nadeID]
        end
    end
    print("Player pawn or nadeID not found")
end

function GetSavedSavingNade(playerpawn)
    for _, playerData in pairs(connectedPlayers) do
        if playerData.playerpawn == playerpawn then
			print(playerData.isSavingNades)
            return playerData.isSavingNades
        end
    end
    print("Player pawn not found")
end

function addNadeDataFromString(playerpawn, s, nType, desc, importToAll)
    -- Split the string by spaces
    local parts = {}
    for part in string.gmatch(s, "%S+") do
        table.insert(parts, part)
    end

    -- Ensure there are 10 parts: nadeID, x, y, z, pitch, yaw, roll, x, y, z
    if #parts ~= 10 then
        return false, "Invalid string format"
    end

    local nadeID = parts[1]
    local location = Vector(tonumber(parts[2]), tonumber(parts[3]), tonumber(parts[4]))
    local angle = Vector(tonumber(parts[5]), tonumber(parts[6]), tonumber(parts[7]))
	local indic = Vector(tonumber(parts[8]), tonumber(parts[9]), tonumber(parts[10]))

    if importToAll then
        -- Import to every player in connectedPlayers
        for _, playerData in pairs(connectedPlayers) do
            playerData.savedNades[nadeID] = {
                location = location,
                angle = angle,
				indicator = indic,
				description = desc,
				nadeType =  nType
            }
        end
        return true
    else
        -- Find the player with the matching pawn in connectedPlayers
        for _, playerData in pairs(connectedPlayers) do
            if playerData.playerpawn == playerpawn then
                playerData.savedNades[nadeID] = {
                    location = location,
                    angle = angle,
					indicator = indic,
					description = desc,
					nadeType =  nType
                }
                return nadeID, location, angle, desc, nType
            end
        end
    end

    -- If we reach here, the player was not found (only applicable when importToAll is false)
    return false, "Player not found"
end

function printNadesForPlayer(playerpawn, nadeTypeFilter)
    -- Find the player with the matching pawn in connectedPlayers
    for _, playerData in pairs(connectedPlayers) do
        if playerData.playerpawn == playerpawn then
            -- Check if the player has saved nades
            if not playerData.savedNades or next(playerData.savedNades) == nil then
                print("No nades saved for player:", playerData.name)
                return
            end

            local nadeFound = false  -- To track if at least one nade of the specified type is found

            -- Extract nade IDs and sort them
            local sortedNadeIDs = {}
            for nadeID in pairs(playerData.savedNades) do
                table.insert(sortedNadeIDs, nadeID)
            end
            table.sort(sortedNadeIDs)

            -- Iterate over sorted nade IDs and print details of those that match the nadeType
            for _, nadeID in ipairs(sortedNadeIDs) do
                local nadeData = playerData.savedNades[nadeID]
                if nadeData.nadeType == nadeTypeFilter then
                    local desc = nadeData.description
                    local nType = nadeData.nadeType
                    ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
                    ScriptPrintMessageChatAll(" \x05 Type: " .. nType)
					ScriptPrintMessageChatAll(" \x10" .. desc)
                    ScriptPrintMessageChatAll(" \x0D Command: \x06loadnade " .. nadeID)
                    nadeFound = true
                end
            end

            if not nadeFound then
                print("No nades of type", nadeTypeFilter, "found for player:", playerData.name)
            end

            return  -- Exit after printing nades for the specified player
        end
    end

    print("Player not found with pawn:", playerpawn)
end

function vectorToString(vecString)
	vectr = tostring(vecString)
    local x, y, z = vectr:match("%[(-?%d+%.?%d*)%s+(-?%d+%.?%d*)%s+(-?%d+%.?%d*)%]")
    if x and y and z then
        return x .. "  " .. y .. "  " .. z
    else
        return "Invalid vector format"
    end
end

function MoveVectorCloser(vector1, vector2, units)
    -- Get the direction from vector2 to vector1
    local direction = (vector1 - vector2):Normalized()
    
    -- Scale the direction by the desired units
    local moveVector = direction * units
    
    -- Get the new location for vector2
    local newVector2 = vector2 + moveVector
    
    return newVector2
end

nadeLocIndicator = nil


--function makeNadeLocIndicator(location)
--	
--	ang = Vector(0,0,0)
--	
--	nadeLocIndicator = Entities:FindByClassname(nil, "point_worldtext")
--
--    if nadeLocIndicator == nil then
--        nadeLocIndicator = SpawnEntityFromTableAsynchronous("point_worldtext", {
--            targetname = "vscript_nadeLocIndicator",
--            message = "O",
--            enabled = true,
--            fullbright = true,
--            color = Vector(255, 0, 0),
--            world_units_per_pixel = "0.015",
--			orientation = 1,
--			font_name = "1",
--            font_size = 100,
--            justify_horizontal = "1",
--            justify_vertical = "1",
--			origin = vectorToString(location),
--			angles = "0 0 0",
--			scales = "10.0 10.0 10.0",
--        }, nil, nil)
--		--print("new LocIndicator created")
--    else
--        nadeLocIndicator:SetLocalOrigin(location)
--	end                  
--end

function makeNadeAngIndicator(player, location, angs)
	
	if vectorToString(location) == "Invalid vector format" then
		return
	end
	
	
	local newLoc = MoveVectorCloser(player:GetLocalOrigin(), location, 1)
	local newAng = QAngle(angs.x + 90, angs.y, angs.z)
	
	if nadeLocIndicator == nil then
		nadeLocIndicator = SpawnEntityFromTableAsynchronous("point_worldtext", {
			targetname = "vscript_nadeLocIndicator",
			message = "O",
			enabled = true,
			fullbright = true,
			color = Vector(0, 255, 0),
			world_units_per_pixel = "0.015",
			orientation = 1,
			rainbow = true,
			font_name = "1",
			font_size = 50,
			justify_horizontal = "1",
			justify_vertical = "1",
			origin = vectorToString(newLoc),
			angles = vectorToString(newAng),
			scales = "10.0 10.0 10.0",
		}, nil, nil)
	else
		nadeLocIndicator:SetLocalOrigin(newLoc)
	end 
	--print("new AngIndicator created")
end
