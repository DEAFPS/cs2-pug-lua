----------------------------------------------------------
-- A Counter-Strike: 2 Server Pug plugin written in LUA --
----------------------------------------------------------
-- Written by @DEAFPS_ -----------------------------------
----------------------------------------------------------

chatPrefix = "{red} [DEAFPS PUG] "      --appears before every plugin related chat msg
warmupEndless = true
warmupTime = "234124235"                --default is infinite
waitingForPlayerMsgInterval = 2		--how long the delay in seconds should be between sending "waiting for players" chat msgs

enableWhitelist = true                  --if whitelist shall be on or off
kzsettingsinwarmup = true               --whacky kz settings in warmup only
kzsettings = false                      --whacky kz settings globally
teamSize = 5                            --amount of players per team
votingEnabled = true                    --if players are able to vote to start the pug

timeoutsPerTeam = 3                     --amount of timeout votes allowed per team
timeoutDuration = 30                    --timeout duration

dmInWarmup = false				--FFA instead of regular warmup

useCustomCFG = false 			-- if a custom cfg should be used

customCFG = "crazywhackysettings.cfg" 	-- place your custom cfg into the cfg folder and put name here.
					-- make sure to not use mp_restartgame since that is being handled by the plugin already

loadPraccNades = true

adminPlayers = {			--admins/constantly whitelisted, same as with the whitelist table use a SteamID3
	"[U:1:146535711]", --admin example
	"[U:0:00000000]", --admin example
}
