------------------------------------------------------------------------------------------
-- THIS SCRIPT IS MADE BY EAST_22
------------------------------------------------------------------------------------------
-- DO NOT SHARE/SELL THIS SCRIPT
------------------------------------------------------------------------------------------
ESX = exports["es_extended"]:getSharedObject()
------------------------------------------------------------------------------------------
--                    DRAWING THE TEXT AND OPENING INPUT/DIALOG MENU
------------------------------------------------------------------------------------------
function OpenMenu()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, Config.Coords.x, Config.Coords.y, Config.Coords.z, true)
        local markerIn = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, Config.teleportIn.x, Config.teleportIn.y, Config.teleportIn.z, true)
        local markerOut = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, Config.teleportOut.x, Config.teleportOut.y, Config.teleportOut.z, true)
        if distance <= Config.Radius then
            DrawText3D(Config.Coords.x, Config.Coords.y, Config.Coords.z, TranslateCap('Drawnotfi'))
            if IsControlJustPressed(1, 51) then
                TriggerServerEvent('start')
            end
        end
        if markerOut <= 1.5 then
            DrawText3D(Config.teleportOut.x, Config.teleportOut.y, Config.teleportOut.z, TranslateCap('Teleportout'))
            if IsControlJustPressed(1, 51) then 
                DoScreenFadeOut(1000)
                Citizen.Wait(1000)-- DO NOT TOUCH THESE, FADE WONT WORK WITHOUT AND ALSO WONT LOOK SMOOTH
                SetEntityCoords(playerPed, Config.teleportIn)
                Citizen.Wait(1000)
                DoScreenFadeIn(1000)
                Citizen.Wait(1000)
            end
        elseif markerIn <= 1.5 then
            DrawText3D(Config.teleportIn.x, Config.teleportIn.y, Config.teleportIn.z, TranslateCap('Teleportin'))
            if IsControlJustPressed(1, 51) then 
                DoScreenFadeOut(1000)
                Citizen.Wait(1000)
                SetEntityCoords(playerPed, 1138.0182, -3199.0830, -38.6657)
                Citizen.Wait(1000)
                DoScreenFadeIn(1000)
                Citizen.Wait(1000)
            end
        end
    end
end

Citizen.CreateThread(OpenMenu)
------------------------------------------------------------------------------------------
--                                  INPUT/DIALOG MENU
------------------------------------------------------------------------------------------
RegisterNetEvent('inputmenui')
AddEventHandler('inputmenui', function(blackMoney)
    inputmenu(blackMoney)
end)

function inputmenu(blackMoney)
    local input = {
        {label = TranslateCap('notif1'), value = '', type = 'text'}
    }

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'inputmoney', {
        title       = TranslateCap('notif1') .. blackMoney, 
        align       = 'center',
        elements = input
    }, function(data, menu)
        if data.value and tonumber(data.value) then
            local inputText = tonumber(data.value)
            if inputText > 0 then
                TriggerServerEvent('startWashing', inputText)
                TriggerServerEvent('DiscordLog', inputText)
                menu.close()
            else
                ESX.ShowNotification(TranslateCap('Invalidamount'), "error", 3000)
            end
        else
            ESX.ShowNotification(TranslateCap('Invalidinput'), "error", 3000)
        end
    end, function(data, menu)
        menu.close()
    end)
end
------------------------------------------------------------------------------------------
--                                      ANIMATION
------------------------------------------------------------------------------------------
RegisterNetEvent('progressbar')
AddEventHandler('progressbar', function(duration)
    if lib.progressCircle({
        duration = 1000,
        label = TranslateCap('Moneyin'),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'random@domestic',
            clip = 'pickup_low'
        } 
    }) then ESX.ShowNotification(TranslateCap('notif2'), "info", 3000) -- notify the player that money washing is started
    end
    if lib.progressCircle({
        duration = Config.washtime,
        label = TranslateCap('MoneyProgress'),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = Config.animdict,
            clip = Config.animclip
        } 
    }) then return
    end
end)
------------------------------------------------------------------------------------------
--                                  PROP SPAWNING
------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    if Config.useProp then
        RequestModel(GetHashKey(Config.prop))

        while not HasModelLoaded(GetHashKey(Config.prop)) do
            Wait(500)
        end
        local prop = CreateObject(GetHashKey(Config.prop), Config.propCoords.x, Config.propCoords.y, Config.propCoords.z, true, false, false)
        SetEntityHeading(prop, Config.propHeading)
        SetEntityHasGravity(prop, false)
        SetEntityCollision(prop, true, false)
        FreezeEntityPosition(prop, true)
    end
end)
------------------------------------------------------------------------------------------
--                                  DRAW THE TEXT
------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)

    if onScreen then
        local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 450
        DrawRect(_x,_y+0.0125, 0.012+ factor, 0.03, 0, 0, 0, 90)
    end
end
------------------------------------------------------------------------------------------
--                                      THE END
------------------------------------------------------------------------------------------