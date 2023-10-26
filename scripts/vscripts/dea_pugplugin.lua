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
        local userid = tostring(id)
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

Convars:RegisterCommand( "pracc" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) then
		if praccEnabled == false then 
			printPraccHelp()
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
		elseif praccEnabled == true then
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x03" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x03" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x03" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x03" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x03" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x03" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x03" .. " Exiting Pracc mode!")
			ScriptPrintMessageChatAll(" \x01 [ADMIN] \x03" .. " Exiting Pracc mode!")
			praccEnabled = false
			roundStarted = false
			StartWarmup()
		end
	end
end, nil , FCVAR_PROTECTED)


Convars:RegisterCommand( "savenade" , function (_, msg, ntype, desc)
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		
		local playerData = connectedPlayers[GetUserIDByPawn(user)]
		
		connectedPlayers[GetUserIDByPawn(user)].isSavingNades = true
		connectedPlayers[GetUserIDByPawn(user)].tempNadeName = msg 
		connectedPlayers[GetUserIDByPawn(user)].tempNadeDesc = desc
		connectedPlayers[GetUserIDByPawn(user)].tempNadeType = ntype

		
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
		
		
		local timer_sec = 640
			
		if Timers:TimerExists(savingNadeInfoTimer) then
			Timers:RemoveTimer("savingNadeInfoTimer")
		end
		
		Timers:CreateTimer("savingNadeInfoTimer", {
			callback = function()
				if timer_sec <= 0 then
					Timers:RemoveTimer("savingNadeInfoTimer")
				else
					FireGameEvent("show_survival_respawn_status", {["loc_token"] = "<font color=\"yellow\">First lineup your nade and then press [MOUSE3] to save a lineup!</font>", ["duration"] = 10, ["userid"] = GetUserIDByPawn(user)})
					timer_sec = timer_sec - 1
				end
				return 0.015625
			end,
		})

	end
end, nil , FCVAR_PROTECTED)

function savingNade(event)

	if connectedPlayers[GetUserIDByPawn(GetPlayerPawnByID(event.userid))].isSavingNades == true then
		local user = GetPlayerPawnByID(event.userid)
		
		local indicatorXYZvec = Vector(event.x, event.y, event.z)
		local nadeName, nadeDesc, nadeType = GetTempNadeDataByPawn(user)
		
		addNadeData(user, nadeName, nadeType, nadeDesc, user:GetLocalOrigin(), user:EyeAngles(), indicatorXYZvec)
		
		local formattedOrigin = string.format("%.2f %.2f %.2f", user:GetAbsOrigin().x, user:GetAbsOrigin().y, user:GetAbsOrigin().z)
		local formattedAngle = string.format("%.2f %.2f %.2f", user:EyeAngles().x, user:EyeAngles().y, user:EyeAngles().z)
		
		local formattedIndicator = string.format("%.2f %.2f %.2f", indicatorXYZvec.x, indicatorXYZvec.y, indicatorXYZvec.z)

		
		ScriptPrintMessageChatAll(' \x05' .. tostring(GetPlayerNameByPawn(user)) .. ' saved a Nade! \x01 "' .. tostring(nadeName) .. ' ' .. formattedOrigin .. ' ' .. formattedAngle .. ' ' .. formattedIndicator .. '"')
		
		connectedPlayers[GetUserIDByPawn(user)].isSavingNades = false
		
		print('"' .. tostring(nadeName) .. ' ' .. formattedOrigin .. ' ' .. formattedAngle .. ' ' .. formattedIndicator .. '"')
		--print("A new nade saved")
		
		makeNadeAngIndicator(user, indicatorXYZvec, user:EyeAngles())
		
		sendClientCMD("play sounds/ui/item_drop.vsnd", user)
	else
		return
	end
end

Convars:RegisterCommand( "loadnade" , function (_, msg)
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		
		local retrievedNadeData = GetSavedNadeByPawnAndID(user, msg)
		
		if retrievedNadeData == nil then
			ScriptPrintMessageChatAll(' \x07' .. tostring(GetPlayerNameByPawn(user)) .. '>> ERROR NO SUCH SAVED NADE')
			return
		end
		
		user:SetLocalOrigin(retrievedNadeData.location + Vector(0, 0, 5)) --adding 5 for z coordinate as workaround for player being spawned slightly in the ground
		user:SetAngles(retrievedNadeData.angle.x, retrievedNadeData.angle.y, retrievedNadeData.angle.z)
		
		local formattedOrigin = string.format("%.2f %.2f %.2f", retrievedNadeData.location.x, retrievedNadeData.location.y, retrievedNadeData.location.z)
		local formattedAngle = string.format("%.2f %.2f %.2f", retrievedNadeData.angle.x, retrievedNadeData.angle.y, retrievedNadeData.angle.z)
		local formattedIndicator = " "
		
		if retrievedNadeData.indicator ~= nil then
			formattedIndicator = string.format("%.2f %.2f %.2f", retrievedNadeData.indicator.x, retrievedNadeData.indicator.y, retrievedNadeData.indicator.z)
		end
		
		if retrievedNadeData.nadeType ~= nil then
			ScriptPrintMessageChatAll(' \x05' .. tostring(GetPlayerNameByPawn(user)) .. ' loaded a ' .. retrievedNadeData.nadeType)
		else
			ScriptPrintMessageChatAll(' \x05' .. tostring(GetPlayerNameByPawn(user)) .. ' loaded a nade')
		end
		
		if retrievedNadeData.nadeType == "smoke" then
			sendClientCMD("slot8", user)
		end
		
		if retrievedNadeData.nadeType == "molly" then
			sendClientCMD("slot10", user)
		end
		
		if retrievedNadeData.nadeType == "he" then
			sendClientCMD("slot6", user)
		end
		
		if retrievedNadeData.nadeType == "flash" then
			sendClientCMD("slot7", user)
		end
		
		if retrievedNadeData.description ~= nil then
			ScriptPrintMessageChatAll(' \x05' .. retrievedNadeData.description)
			
			local timer_sec = 320
			
			if Timers:TimerExists(nade_desc_timer) then
				Timers:RemoveTimer("nade_desc_timer")
			end
			
			Timers:CreateTimer("nade_desc_timer", {
				callback = function()
					if timer_sec <= 0 then
						Timers:RemoveTimer("nade_desc_timer")
					else
						FireGameEvent("show_survival_respawn_status", {["loc_token"] = "<font color=\"yellow\">" .. retrievedNadeData.description .."</font>", ["duration"] = 10, ["userid"] = GetUserIDByPawn(user)})
						timer_sec = timer_sec - 1
					end
					return 0.015625
				end,
			})
			
			
		end
		ScriptPrintMessageChatAll(' \x01 "' .. tostring(msg) .. ' ' .. formattedOrigin .. ' ' .. formattedAngle ..' ' .. formattedIndicator .. '"')
		
		makeNadeAngIndicator(user, retrievedNadeData.indicator, retrievedNadeData.angle)
		
		sendClientCMD("play sounds/buttons/blip1.vsnd", user)
		
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "importnade" , function (_, msg)
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		local importString = tostring(msg)
		local nadeID, location, angle = addNadeDataFromString(user, importString, false)
		
		user:SetAbsOrigin(location)
		user:SetAngles(angle.x, angle.y, angle.z)
		
		ScriptPrintMessageChatAll(" \x05" .. tostring(GetPlayerNameByPawn(user)) .. ' loaded a imported Nade! \x01 "' .. tostring(importString) .. '"')
		
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "initnades" , function (_, map, nType, desc, code)
	local user = Convars:GetCommandClient()
	
	if user == nil and praccEnabled == true and GetMapName() == map then
		local importString = tostring(code)
		if desc ~= nil then
			addNadeDataFromString(nil, importString, nType, desc, true)
		else
			addNadeDataFromString(nil, importString, " ", " ", true)
		end
	end	
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "allsmoke" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		printNadesForPlayer(user, "smoke")
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "allmolly" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		printNadesForPlayer(user, "molly")
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "allhe" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		printNadesForPlayer(user, "he")
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "allflash" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		printNadesForPlayer(user, "flash")
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "killsmoke" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		DoEntFire("smokegrenade_projectile", "kill", nil, 0, nil, nil)
		DoEntFire("molotov_projectile", "kill", nil, 0, nil, nil)
		user:SetMaxHealth(thisClass.health)
		user:SetHealth(thisClass.health)
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "godmode" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		user:SetMaxHealth(2147483647)
		user:SetHealth(2147483647)
	end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "pracchelp" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		printPraccHelp()
	end
end, nil , FCVAR_PROTECTED)

local knifeCommands = {
    bayonet = "500",
    butterfly = "515",
    karambit = "507",
    m9 = "508",
    skeleton = "525",
    talon = "523",
    classic = "503",
    stiletto = "522",
    flip = "505",
    ursus = "519",
    paracord = "517",
    survival = "518",
    huntsman = "509",
    falchion = "512",
    bowie = "514",
    daggers = "516",
    gut = "506",
    navaja = "520"
}

Convars:RegisterCommand("knife", function(_, knife)
    if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
	
		local command = knifeCommands[knife]
		if command then
			SendToServerConsole("subclass_change " .. command .. " weapon_knife")
		end
	end
end, nil, FCVAR_PROTECTED)

Convars:RegisterCommand( "adminhelp" , function ()
    local user = Convars:GetCommandClient()
	
	if checkPlayerPawnForAdminStatus(user) and praccEnabled == true then
		printAdminHelp()
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
		else
			return
		end
	end
	
end

function PlayerVotes(event)
		
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
		savedNades = {},
		isSavingNades = false,
		tempNadeName = " ",
		tempNadeDesc = " ",
		tempNadeType = " "
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

function OnPlayerPing(event)
	
	if roundStarted == false and votingEnabled == true then
		PlayerVotes(event)
	end
	
	if checkPlayerPawnForAdminStatus(GetPlayerPawnByID(event.userid)) and praccEnabled == true then
		savingNade(event)
	end
end

function OnPlayerDisconnect(event)
	removeFromVoted(event.userid)
	connectedPlayers[event.userid] = nil
end

StartWarmup()

ListenToGameEvent("player_connect", OnPlayerConnect, nil)
ListenToGameEvent("player_spawn", OnPlayerSpawned, nil)
ListenToGameEvent("player_ping", OnPlayerPing, nil)
ListenToGameEvent("player_disconnect", OnPlayerDisconnect, nil)

print("[DEAFPS PUG] Plugin loaded!")
