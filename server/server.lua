------------------------------------------------------------------------------------------
-- Start the laundering
------------------------------------------------------------------------------------------

RegisterServerEvent('startWashing')
AddEventHandler('startWashing', function(amountToWash)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerIdentifier = GetPlayerIdentifier(_source)
    local playerId = _source

    if xPlayer.getAccount('black_money').money < amountToWash then
      TriggerClientEvent('esx:showNotification', _source, Config.notif4)
        return
    end

    TriggerClientEvent('progressbar', _source, Config.washtime)
    Citizen.Wait(Config.washtime + 1000)
    local CashAfterTax = amountToWash * Config.Tax

    xPlayer.removeAccountMoney('black_money', amountToWash)
    xPlayer.addMoney(CashAfterTax)

    --TriggerClientEvent('moneyWashCompleted', _source)
    TriggerClientEvent('esx:showNotification', _source, Config.notif3..CashAfterTax..'€')
    TriggerServerEvent('DiscordLog', amountToWash)
end)


-----------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------
RegisterNetEvent('start')
AddEventHandler('start', function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local blackMoney = xPlayer.getAccount('black_money').money
  TriggerClientEvent('inputmenui', _source, blackMoney)
end)
------------------------------------------------------------------------------------------
-- send discord webhook log 
------------------------------------------------------------------------------------------
RegisterServerEvent('DiscordLog')
AddEventHandler('DiscordLog', function(amountToWash)
	
  local xPlayer = ESX.GetPlayerFromId(source)
  local id = xPlayer.getIdentifier()
  local logs = 'YOURWEBHOOK HERE'
  local name = xPlayer.getName()
  local DATE = os.date(" %H:%M %d.%m.%y")
  local connect = {
	{
		["color"] = "8663711",
		["title"] = "Money launder",
		["description"] = "".. name .. "\n IDENTIFIER: [" .. id .. "] \n" .. "Laundered money: " .. amountToWash .. "" .. "\nTime: ".. DATE .. "",
		["footer"] = {
		["text"] = "Server name here", -- add your server name
		},
	}
}

PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = Config.WebhookName, embeds = connect}), { ['Content-Type'] = 'application/json' })
end)
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------