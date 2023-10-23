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

function addNadeData(playerpawn, nadeID, ntype, desc, locationVector, angleVector)
	for _, playerData in pairs(connectedPlayers) do
        if playerData.playerpawn == playerpawn then
            playerData.savedNades[nadeID] = {
                location = locationVector,
                angle = angleVector,
				description = desc,
				nadeType =  ntype
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

function addNadeDataFromString(playerpawn, s, nType, desc, importToAll)
    -- Split the string by spaces
    local parts = {}
    for part in string.gmatch(s, "%S+") do
        table.insert(parts, part)
    end

    -- Ensure there are 7 parts: nadeID, x, y, z, pitch, yaw, roll
    if #parts ~= 7 then
        return false, "Invalid string format"
    end

    local nadeID = parts[1]
    local location = Vector(tonumber(parts[2]), tonumber(parts[3]), tonumber(parts[4]))
    local angle = Vector(tonumber(parts[5]), tonumber(parts[6]), tonumber(parts[7]))

    if importToAll then
        -- Import to every player in connectedPlayers
        for _, playerData in pairs(connectedPlayers) do
            playerData.savedNades[nadeID] = {
                location = location,
                angle = angle,
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
                    angle = angle
                }
                return nadeID, location, angle
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

            -- Iterate over saved nades and print details of those that match the nadeType
            for nadeID, nadeData in pairs(playerData.savedNades) do
                if nadeData.nadeType == nadeTypeFilter then
                    local desc = nadeData.description
					local nType = nadeData.nadeType
					ScriptPrintMessageChatAll(" \x01---------------------------------------------------------------------------------")
					ScriptPrintMessageChatAll(" \x05 Type: " .. nType)
					ScriptPrintMessageChatAll(" \x0D Command: \x06loadnade " .. nadeID)
					ScriptPrintMessageChatAll(" \x10" .. desc)
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

