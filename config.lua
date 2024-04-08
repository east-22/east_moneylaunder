-- This isnt a good script and it needs improvements i know. Just something i made fast.

Config = {}

Config.WebhookName = 'Logs' -- webhook link in server.lua - line 38!

Config.useProp = true -- want to use the washing machine prop? 
Config.prop = "prop_washer_01" -- change the prop if you want
Config.propCoords = vector3(-95.8535, -967.7227, 20.2768) -- where will the prop spawn
Config.propHeading = 340.2192 -- heading of the prop (when copying the coords in tx, look the other way around where you really want it to head)

Config.Coords = vector3(1122.3910, -3194.4019, -40.3980) -- coords to the text Drawnotif
Config.Radius = 1 -- How far will the notification show

Config.washtime = 10000 -- adjust how ever you like, default 10sec
Config.Tax = 0.5 -- how much will the player get back 0.5 = 50%

Config.Progresslabel = 'Waiting for the money to wash...'
Config.animdict = 'amb@world_human_hang_out_street@Female_arm_side@idle_a'
Config.animclip = 'idle_a'

-- Change if english isnt the language you want to use (some notifications need to be changed in the client.lua and server.lua)
-- Because this is an old script ive made, i didnt use locales back then.
Config.notif1 = 'Max amount to wash: '
Config.notif2 = 'Started laundering dirty money!'
Config.notif3 = 'Laundered money and you got: '
Config.notif4 = 'Money laundering failed'
Config.Drawnotif = "Press [~g~E~w~] to launder money"

Config.teleportIn = vector3(871.1696, -1621.8110, 30.3353)
Config.teleportOut = vector3(1138.0182, -3199.0830, -39.6657)



-- if you have any questions, add me on discord: east_22

