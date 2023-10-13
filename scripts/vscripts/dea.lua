----------------------------------------------------------
-- A Counter-Strike: 2 Server Pug plugin written in LUA --
----------------------------------------------------------
-- Written by @DEAFPS_ -----------------------------------
----------------------------------------------------------

require "libs.timers"
require "whitelist"
require "banlist"
require "pug_cfg"

roundStarted = false
currentMvmntSettings = "VNL"
local connectedPlayers = {}
local activeAdmins = {}

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
	
	if useCustomCFG == true then
		SendToServerConsole("exec " .. customCFG )
	end
end

function StartWarmup()
	SendToServerConsole("mp_warmup_start")
	setGeneralSettings()
	
	if warmupEndless == true then
		SendToServerConsole("mp_warmup_pausetimer 1")
	end
	
	SendToServerConsole("mp_warmuptime " .. warmupTime)
	
	if kzsettingsinwarmup == true then
		mvmntSettings("kz")
	end
	
	if kzsettingsinwarmup == false then
		mvmntSettings("vnl")
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

Convars:RegisterCommand("rewarmup", function()
	local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) then
	
		SendToServerConsole("mp_warmup_start")
		setGeneralSettings()
		
		if warmupEndless == true then
			SendToServerConsole("mp_warmup_pausetimer 1")
		end
		
		SendToServerConsole("mp_warmuptime " .. warmupTime)
		
		HC_PrintChatAll_pug("{green} Restarting Warmup...")
		HC_PrintChatAll_pug("{green} Restarting Warmup...")
		HC_PrintChatAll_pug("{green} Restarting Warmup...")
		HC_PrintChatAll_pug("{green} Restarting Warmup...")
		HC_PrintChatAll_pug("{green} Restarting Warmup...")
		HC_PrintChatAll_pug("{green} Restarting Warmup...")
		HC_PrintChatAll_pug("{green} Restarting Warmup...")
		HC_PrintChatAll_pug("{green} Restarting Warmup...")
		
		if kzsettingsinwarmup == true then
			mvmntSettings("kz")
		end
		
		if kzsettingsinwarmup == false then
			mvmntSettings("vnl")
		end
		
		roundStarted = false
	end
end, nil, 0)

function StartPug(reason)
	
	if (roundStarted == false) then
	
		seconds = 10
		roundStarted = true
		
		Timers:CreateTimer("startingpug_timer", {
						callback = function()
							HC_PrintChatAll_pug("{white}" .. reason .. " {green} Starting Pug in: " .. seconds)
							seconds = seconds - 1
							if seconds == 0 then
								Timers:RemoveTimer(startingpug_timer)
							end
							return 1.0
						end,
		})
		
		Timers:CreateTimer({
		useGameTime = false,
		endTime = 10,
		callback = function()
			SendToServerConsole("mp_warmup_end")
			setGeneralSettings()
			HC_PrintChatAll_pug("{green} Starting Pug...")
			HC_PrintChatAll_pug("{green} Starting Pug...")
			HC_PrintChatAll_pug("{green} Starting Pug...")
			HC_PrintChatAll_pug("{green} Starting Pug...")
			HC_PrintChatAll_pug("{green} Starting Pug...")
			HC_PrintChatAll_pug("{green} Starting Pug...")
			HC_PrintChatAll_pug("{green} Starting Pug...")
			
		
			if kzsettings == true then
				mvmntSettings("kz")
			else 
				mvmntSettings("vnl")
			end
			
			HC_PrintChatAll_pug("{white}" .. reason .. "{green} Movement Settings: [" .. currentMvmntSettings .. "]")
		end
		})
	end
end	

Convars:RegisterCommand("startpug", function()
	local user = Convars:GetCommandClient()
	print(user)
	
	if (roundStarted == false) and checkPlayerPawnForAdminStatus(user) then
		StartPug("[Admin]")
	end
end, nil, 0)

Convars:RegisterCommand("scramble", function()
	local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) then
		setGeneralSettings()
		SendToServerConsole("mp_scrambleteams")
		HC_PrintChatAll_pug("{green} Scrambling Teams...")
		HC_PrintChatAll_pug("{green} Scrambling Teams...")
		HC_PrintChatAll_pug("{green} Scrambling Teams...")
		HC_PrintChatAll_pug("{green} Scrambling Teams...")
		HC_PrintChatAll_pug("{green} Scrambling Teams...")
		HC_PrintChatAll_pug("{green} Scrambling Teams...")
		HC_PrintChatAll_pug("{green} Scrambling Teams...")
		HC_PrintChatAll_pug("{green} Scrambling Teams...")
	end
end, nil, 0)

Convars:RegisterCommand("pausepug", function()
	local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) then
		SendToServerConsole("mp_pause_match")
		HC_PrintChatAll_pug("{green} Pausing Pug...")
		HC_PrintChatAll_pug("{green} Pausing Pug...")
		HC_PrintChatAll_pug("{green} Pausing Pug...")
		HC_PrintChatAll_pug("{green} Pausing Pug...")
		HC_PrintChatAll_pug("{green} Pausing Pug...")
		HC_PrintChatAll_pug("{green} Pausing Pug...")
		HC_PrintChatAll_pug("{green} Pausing Pug...")
		HC_PrintChatAll_pug("{green} Pausing Pug...")
	end
end, nil, 0)

Convars:RegisterCommand("unpausepug", function()
	local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) then
		SendToServerConsole("mp_unpause_match")
		HC_PrintChatAll_pug("{green} Unpausing Pug...")
		HC_PrintChatAll_pug("{green} Unpausing Pug...")
		HC_PrintChatAll_pug("{green} Unpausing Pug...")
		HC_PrintChatAll_pug("{green} Unpausing Pug...")
		HC_PrintChatAll_pug("{green} Unpausing Pug...")
		HC_PrintChatAll_pug("{green} Unpausing Pug...")
		HC_PrintChatAll_pug("{green} Unpausing Pug...")
		HC_PrintChatAll_pug("{green} Unpausing Pug...")
	end
end, nil, 0)

Convars:RegisterCommand("restartpug", function()
	local user = Convars:GetCommandClient()
	if checkPlayerPawnForAdminStatus(user) then
		if kzsettings == true then
				mvmntSettings("kz")
			else 
				mvmntSettings("vnl")
		end
		
		SendToServerConsole("mp_restartgame 1")
		setGeneralSettings()
		HC_PrintChatAll_pug("{green} Restarting Pug...")
		HC_PrintChatAll_pug("{green} Restarting Pug...")
		HC_PrintChatAll_pug("{green} Restarting Pug...")
		HC_PrintChatAll_pug("{green} Restarting Pug...")
		HC_PrintChatAll_pug("{green} Restarting Pug...")
		HC_PrintChatAll_pug("{green} Restarting Pug...")
		HC_PrintChatAll_pug("{green} Restarting Pug...")
		HC_PrintChatAll_pug("{green} Movement Settings: [" .. currentMvmntSettings .. "]")
	end
end, nil, 0)

function KickAllPlayers()
    for userid, _ in pairs(connectedPlayers) do
        SendToServerConsole("kickid " .. userid .. " server is changing map, please reconnect")
    end
end

Convars:RegisterCommand("changemap", function (_, map)
	local mmap = tostring (map) or  30
	local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) then
	
		seconds = 10
		roundStarted = true
		Timers:CreateTimer("startingpug_timer", {
						callback = function()
							HC_PrintChatAll_pug("{green} Changing Map in: " .. seconds)
							seconds = seconds - 1
							if seconds == 0 then
								Timers:RemoveTimer(startingpug_timer)
							end
							return 1.0
						end,
		})

		if autokickOnMapChange == true then
			Timers:CreateTimer({
			useGameTime = false,
			endTime = 10,
			callback = function()
				KickAllPlayers()
					
			end
			})
		end
				
		Timers:CreateTimer({
		useGameTime = false,
		endTime = 15,
		callback = function()
			SendToServerConsole("map " .. mmap)
				
		end
		})
	end
end, nil, 0)

Convars:RegisterCommand( "pugkick" , function (_, id)
        local userid = tostring (id)
        local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) then
		SendToServerConsole("kickid " .. userid .. " kicked by server admin")
		print(userid .. " kicked from the server")
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "pugkickall" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) then
		KickAllPlayers()
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "adminsay" , function (_, msg)
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) then
		ScriptPrintMessageChatAll(" \x01 [ADMIN " .. GetPlayerNameByPawn(user) .. "] \x10" .. tostring(msg))
	end
end, nil , FCVAR_PROTECTED)

local playersThatVoted = {}

wfpDelay = 0

function PrintWaitingforPlayers(event)
	
	if not warmupTimerStarted then
		warmupTimerStarted = true
		if not Timers:TimerExists(warmup_timer) then
			Timers:CreateTimer("warmup_timer", {
					callback = function()
						if not roundStarted then		
							
							if wfpDelay == waitingForPlayerMsgInterval then
								HC_PrintChatAll_pug("{green} Waiting for players {lightgray}[Players ready: " .. #playersThatVoted .. "/" .. 2 * teamSize .. "]")
								wfpDelay = 0
							else
								wfpDelay = wfpDelay + 1
							end
								
							if votingEnabled then
								ScriptPrintMessageCenterAll("Waiting for players [Ready: " .. #playersThatVoted .. "/" .. 2 * teamSize .. "]     Use [MOUSE3] to ready up!")
							else
								ScriptPrintMessageCenterAll("Waiting for Admin to start the pug!")
							end
						end
						return 1
					end,
			})
		end
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

function PlayerVotes(event)
	if (roundStarted == false) and votingEnabled == true then
		
		local readyNeeded = 2 * teamSize
		
		if tableContains(playersThatVoted, event.userid) then
			removeFromVoted(event.userid)
			if autokickOnMapChange == true then
				HC_PrintChatAll_pug( " {lightgray}" .. tostring(GetPlayerNameByID(event.userid)) .. " is not ready! {green}Players voted: " .. #playersThatVoted)
			end
		elseif not tableContains(playersThatVoted, event.userid) then
			table.insert(playersThatVoted, event.userid)
			if autokickOnMapChange == true then
				HC_PrintChatAll_pug( " {lightgray}" .. tostring(GetPlayerNameByID(event.userid)) .. " is ready! {green}Players voted: " .. #playersThatVoted)
			end
		end
	
		if #playersThatVoted == readyNeeded then
			StartPug("[Ready]")
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

function OnPlayerConnect(event)
	if enableWhitelist == true then
		checkWL(event)
	end
	
	if enableWhitelist == false then
		checkBanlist(event)
	end
	
	local playerData = {
		name = event.name,
		userid = event.userid,
		networkid = event.networkid,
		address = event.address,
		playerpawn = " ",
		admin = checkAdmin(tostring(event.networkid), event)
	}
	connectedPlayers[event.userid] = playerData
end

function OnPlayerSpawned(event)
    
	PrintWaitingforPlayers(event)
	print("before conv " .. tostring(event.userid_pawn))
	
	local userid = event.userid
    local playerData = connectedPlayers[userid]
    if playerData then
        playerData.playerpawn = UserIdPawnToPlayerPawn(event.userid_pawn)
		print("after conv " .. tostring(playerData.playerpawn))
    end
	
end

function OnPlayerDisconnect(event)
	removeFromVoted(event.userid)
	connectedPlayers[event.userid] = nil
end

StartWarmup()

ListenToGameEvent("player_connect", OnPlayerConnect, nil)
ListenToGameEvent("player_spawn", OnPlayerSpawned, nil)
ListenToGameEvent("player_ping", PlayerVotes, nil)
ListenToGameEvent("player_disconnect", OnPlayerDisconnect, nil)

print("[DEAFPS PUG] Plugin loaded!")
