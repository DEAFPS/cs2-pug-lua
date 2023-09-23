--SHITTY PUG PLUGIN BY DEAFPS
-- HC_ functions by NickFox007

require "libs.timers"
require "whitelist"
require "pug_cfg"

roundStarted = false
currentMvmntSettings = "VNL"

local adminPlayers = {
	--admins/constantly whitelisted
	"[U:1:146535711]", --dea
	"[U:1:214857343]", --mezel
	"[U:1:83116821]", --malek
	"[U:1:166331469]", --kuba
	"[U:1:55900622]", --tamas
}

function HC_ReplaceColorCodes(text)
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

function HC_PrintChatAll(text)		
	ScriptPrintMessageChatAll(" " .. HC_ReplaceColorCodes(chatPrefix .. text))
end

function checkWL(event)
    local steamId = tostring(event.networkid)
	local username = tostring(event.name)

    if tableContains(allowedPlayers, steamId) or tableContains(adminPlayers, steamId) then
        print("[Whitelist] " .. username .. " is allowed on this server")
    else
		print("[Whitelist] " .. username .. " not on whitelist, kicking...")
		SendToServerConsole("kickid " .. event.userid .. " You have been kicked from this server!")
    end  
end

function tableContains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

function mvmntSettings(setting)
	if setting == "kz" then
		SendToServerConsole("sv_accelerate 6.5")
		SendToServerConsole("sv_accelerate_use_weapon_speed 0")
		SendToServerConsole("sv_airaccelerate 100.0")
		SendToServerConsole("sv_air_max_wishspeed 30.0")
		SendToServerConsole("sv_enablebunnyhopping 1")
		SendToServerConsole("sv_friction 5.0")
		SendToServerConsole("sv_gravity 800.0")
		SendToServerConsole("sv_jump_impulse 301.993377")
		SendToServerConsole("sv_ladder_scale_speed 1.0")
		SendToServerConsole("sv_ledge_mantle_helper 0.0")
		SendToServerConsole("sv_maxspeed 320.0")
		SendToServerConsole("sv_maxvelocity 2000.0")
		SendToServerConsole("sv_staminajumpcost 0.0")
		SendToServerConsole("sv_staminalandcost 0.0")
		SendToServerConsole("sv_staminamax 0.0")
		SendToServerConsole("sv_staminarecoveryrate 0.0")
		SendToServerConsole("sv_standable_normal 0.7")
		SendToServerConsole("sv_timebetweenducks 0.0")
		SendToServerConsole("sv_walkable_normal 0.7")
		SendToServerConsole("sv_wateraccelerate 10.0")
		SendToServerConsole("sv_water_movespeed_multiplier 0.8")
		SendToServerConsole("sv_water_swim_mode  0.0")
		SendToServerConsole("sv_weapon_encumbrance_per_item 0.0")
		SendToServerConsole("sv_weapon_encumbrance_scale 0.0")
		currentMvmntSettings = "KZ"
	end
	
	if not setting == "vnl" then
		SendToServerConsole("sv_accelerate 5.5")
		SendToServerConsole("sv_accelerate_use_weapon_speed 1")
		SendToServerConsole("sv_airaccelerate 12.0")
		SendToServerConsole("sv_air_max_wishspeed 30.0")
		SendToServerConsole("sv_enablebunnyhopping 1")
		SendToServerConsole("sv_friction 5.2")
		SendToServerConsole("sv_gravity 800.0")
		SendToServerConsole("sv_jump_impulse 301.993377")
		SendToServerConsole("sv_ladder_scale_speed 0.78")
		SendToServerConsole("sv_ledge_mantle_helper 0.0")
		SendToServerConsole("sv_maxspeed 320.0")
		SendToServerConsole("sv_maxvelocity 3500.0")
		SendToServerConsole("sv_staminajumpcost 0.08")
		SendToServerConsole("sv_staminalandcost 0.05")
		SendToServerConsole("sv_staminamax 80.0")
		SendToServerConsole("sv_staminarecoveryrate 60.0")
		SendToServerConsole("sv_standable_normal 0.7")
		SendToServerConsole("sv_timebetweenducks 0.4")
		SendToServerConsole("sv_walkable_normal 0.7")
		SendToServerConsole("sv_wateraccelerate 10.0")
		SendToServerConsole("sv_water_movespeed_multiplier 0.8")
		SendToServerConsole("sv_water_swim_mode  0.0")
		SendToServerConsole("sv_weapon_encumbrance_per_item 0.85")
		SendToServerConsole("sv_weapon_encumbrance_scale 0.0")
		currentMvmntSettings = "VNL"
	end
	
end

function StartWarmup()
	SendToServerConsole("bot_kick")
	SendToServerConsole("mp_warmuptime " .. warmupTime)
	
	if kzsettingsinwarmup then
		mvmntSettings("kz")
	else 
		mvmntSettings("vnl")
	end
	
end

function RestartWarmup()
	SendToServerConsole("mp_warmup_start")
	HC_PrintChatAll("{green} Restarting Warmup...")
	HC_PrintChatAll("{green} Restarting Warmup...")
	HC_PrintChatAll("{green} Restarting Warmup...")
	HC_PrintChatAll("{green} Restarting Warmup...")
	HC_PrintChatAll("{green} Restarting Warmup...")
	HC_PrintChatAll("{green} Restarting Warmup...")
	HC_PrintChatAll("{green} Restarting Warmup...")
	HC_PrintChatAll("{green} Restarting Warmup...")
	
	if kzsettingsinwarmup == "kz" then
		mvmntSettings("kz")
	else 
		mvmntSettings("vnl")
	end
	
	roundStarted = false
end

function StartPug()
	SendToServerConsole("mp_warmup_end")
	HC_PrintChatAll("{green} Starting Pug...")
	HC_PrintChatAll("{green} Starting Pug...")
	HC_PrintChatAll("{green} Starting Pug...")
	HC_PrintChatAll("{green} Starting Pug...")
	HC_PrintChatAll("{green} Starting Pug...")
	HC_PrintChatAll("{green} Starting Pug...")
	HC_PrintChatAll("{green} Starting Pug...")
	HC_PrintChatAll("{green} Starting Pug...")
	
	if kzsettings == "kz" then
		mvmntSettings("kz")
	else 
		mvmntSettings("vnl")
	end
	
	roundStarted = true
end

function ScrambleTeams()
    SendToServerConsole("mp_scrambleteams")
    HC_PrintChatAll("{green} Scrambling Teams...")
	HC_PrintChatAll("{green} Scrambling Teams...")
	HC_PrintChatAll("{green} Scrambling Teams...")
	HC_PrintChatAll("{green} Scrambling Teams...")
	HC_PrintChatAll("{green} Scrambling Teams...")
	HC_PrintChatAll("{green} Scrambling Teams...")
	HC_PrintChatAll("{green} Scrambling Teams...")
	HC_PrintChatAll("{green} Scrambling Teams...")
end

function RestartPug()
    SendToServerConsole("mp_restartgame 1")
    HC_PrintChatAll("{green} Restarting Pug...")
	HC_PrintChatAll("{green} Restarting Pug...")
	HC_PrintChatAll("{green} Restarting Pug...")
	HC_PrintChatAll("{green} Restarting Pug...")
	HC_PrintChatAll("{green} Restarting Pug...")
	HC_PrintChatAll("{green} Restarting Pug...")
	HC_PrintChatAll("{green} Restarting Pug...")
	HC_PrintChatAll("{green} Restarting Pug...")
end


function PrintWaitingforPlayers(event)
	
	if not warmupTimerStarted then
		warmupTimerStarted = true
		Timers:CreateTimer("warmup_timer", {
				callback = function()
					if not roundStarted then
						HC_PrintChatAll("{green} Waiting for players")
					end
					return 3
				end,
		})
	end
	
end


Convars:RegisterCommand( "startpug", StartPug, "starts the pug", FCVAR_RELEASE )
Convars:RegisterCommand( "scramble", ScrambleTeams, "scrambles the teams randomly", FCVAR_RELEASE )
Convars:RegisterCommand( "restartpug", RestartPug, "restarts the pug", FCVAR_RELEASE )
Convars:RegisterCommand( "rewarmup", RestartWarmup, "restarts the warmup", FCVAR_RELEASE )

StartWarmup()

function Whitelist()
	if enableWhitelist then
		ListenToGameEvent("player_connect", checkWL, nil)
	end
end

ListenToGameEvent("player_spawn", PrintWaitingforPlayers, nil)

Whitelist()

print("[DEAFPS PUG] Plugin loaded!")