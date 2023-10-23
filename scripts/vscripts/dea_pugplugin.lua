----------------------------------------------------------
-- A Counter-Strike: 2 Server Pug plugin written in LUA --
----------------------------------------------------------
-- Written by @DEAFPS_ -----------------------------------
----------------------------------------------------------

require "libs.timers"
require "dea_pugplugin.pug_utils"
require "dea_pugplugin.whitelist"
require "dea_pugplugin.banlist"
require "dea_pugplugin.pug_cfg"

roundStarted = false
currentMvmntSettings = "VNL"
connectedPlayers = {}

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
	
	if dmInWarmup == true then
		SendToServerConsole("mp_randomspawn 1")
		SendToServerConsole("mp_teammates_are_enemies 1")
	end
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
		
		if dmInWarmup == true then
			SendToServerConsole("mp_randomspawn 1")
			SendToServerConsole("mp_teammates_are_enemies 1")
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
			
			if dmInWarmup == true then
				SendToServerConsole("mp_randomspawn 0")
				SendToServerConsole("mp_teammates_are_enemies 0")
			end
			
			HC_PrintChatAll_pug("{white}" .. reason .. "{green} Movement Settings: [" .. currentMvmntSettings .. "]")
		end
		})
	end
end	

Convars:RegisterCommand("startpug", function()
	local user = Convars:GetCommandClient()
	
	if (roundStarted == false) and checkPlayerPawnForAdminStatus(user) then
		StartPug("[Admin " .. GetPlayerNameByPawn(user) .. "]")
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

praccEnabled = false

Convars:RegisterCommand( "pracc" , function (_, msg)
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) then
		if msg == "1" and praccEnabled == false then 
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Starting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Starting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Starting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Commands:")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " savenade mynade - saves a nade lineup with a given name!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " loadnade mynade - loads a nade lineup")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. ' importnade "code" - imports a nade from a nade code')
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " pracchelp - prints these commands in chat")
			praccEnabled = true
			roundStarted = true
			if kzsettings == true then
				mvmntSettings("kz")
			else 
				mvmntSettings("vnl")
			end
			
			if dmInWarmup == true then
				SendToServerConsole("mp_randomspawn 0")
				SendToServerConsole("mp_teammates_are_enemies 0")
			end
			
			setPraccSettings()
		end
		
		if msg == "0" and praccEnabled == true then
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Exiting Pracc mode!")
			praccEnabled = false
			roundStarted = false
			StartWarmup()
		end
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "savenade" , function (_, msg)
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		
		addNadeData(user, msg, user:GetAbsOrigin(), user:EyeAngles())
		
		local formattedOrigin = string.format("%.2f %.2f %.2f", user:GetAbsOrigin().x, user:GetAbsOrigin().y, user:GetAbsOrigin().z)
		local formattedAngle = string.format("%.2f %.2f %.2f", user:EyeAngles().x, user:EyeAngles().y, user:EyeAngles().z)
		
		ScriptPrintMessageChatAll(' \x05' .. tostring(GetPlayerNameByPawn(user)) .. ' saved a Nade! \x01 "' .. tostring(msg) .. ' ' .. formattedOrigin .. ' ' .. formattedAngle ..'"')
		
		
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "loadnade" , function (_, msg)
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		
		local retrievedNadeData = GetSavedNadeByPawnAndID(user, msg)
		user:SetAbsOrigin(retrievedNadeData.location)
		user:SetAngles(retrievedNadeData.angle.x, retrievedNadeData.angle.y, retrievedNadeData.angle.z)
		
		local formattedOrigin = string.format("%.2f %.2f %.2f", retrievedNadeData.location.x, retrievedNadeData.location.y, retrievedNadeData.location.z)
		local formattedAngle = string.format("%.2f %.2f %.2f", retrievedNadeData.angle.x, retrievedNadeData.angle.y, retrievedNadeData.angle.z)
		
		ScriptPrintMessageChatAll(' \x05' .. tostring(GetPlayerNameByPawn(user)) .. ' loaded a Nade! \x01 "' .. tostring(msg) .. ' ' .. formattedOrigin .. ' ' .. formattedAngle ..'"')
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "importnade" , function (_, msg)
    local user = Convars:GetCommandClient()
	local importString = tostring(msg)
	print(importString)
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		
		local nadeID, location, angle = parseNadeString(importString)
		
		user:SetAbsOrigin(location)
		user:SetAngles(angle.x, angle.y, angle.z)
		
		ScriptPrintMessageChatAll(" \x05" .. tostring(GetPlayerNameByPawn(user)) .. ' loaded a imported Nade! \x01 "' .. tostring(importString) .. '"')
		
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "pracchelp" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Commands:")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " savenade mynade - saves a nade lineup with a given name!")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " loadnade mynade - loads a nade lineup")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. ' importnade "mynade 200 2500 100 -25 -140 0.00" - imports a nade from a nade code')
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " pracchelp - prints these commands in chat")
		
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "adminhelp" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " Commands:")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " adminsay hello - prints a message in chat with a admin nametag")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " startpug - starts the pug")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. ' pausepug - pauses the pug')
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " unpausepug - unpauses the pug")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " restartpug - compleatly restarts the pug")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " scramble - shuffles teams")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " rewarmup - restarts warmup phase")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " pugkick id - kicks the player")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " unpausepug - unpauses the pug")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " changemap de_dust2 - changes map")
		ScriptPrintMessageChatAll(" \x01 [ADMIN] \x10" .. " adminhelp - prints these commands in chat")
	end
end, nil , FCVAR_PROTECTED)

playersThatVoted = {}
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
		admin = checkAdmin(tostring(event.networkid), event),
		savedNades = {}
	}
	connectedPlayers[event.userid] = playerData
end

function OnPlayerSpawned(event)
    
	PrintWaitingforPlayers(event)
	
	local userid = event.userid
    local playerData = connectedPlayers[userid]
    if playerData then
        playerData.playerpawn = UserIdPawnToPlayerPawn(event.userid_pawn)
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
