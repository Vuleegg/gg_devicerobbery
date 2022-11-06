ESX = exports['es_extended']:getSharedObject()
local register = RegisterServerEvent 
local handler = AddEventHandler 
local callclient = TriggerClientEvent 
local CopsConnected  = 0

Citizen.CreateThread(function()
    print("[^1"..GetCurrentResourceName().."^7] Script loaded | version : 1.0.0")
end)



function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

ESX.RegisterServerCallback('gg:devicerobbery', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)

register("gg:sellitems")
handler("gg:sellitems", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    for k, v in pairs(Config.Sell) do
    local sell = xPlayer.getInventoryItem('stolen_pc').count and xPlayer.getInventoryItem('stolen_camera').count and  xPlayer.getInventoryItem('stolen_phone').count and xPlayer.getInventoryItem('stolen_tv').count 
    local distance = #(GetEntityCoords(GetPlayerPed(source)) - v.coords)
    local payout = 0 
    payout = v.price * sell

    if distance < 4.5 then
        if sell >= 1 then

            xPlayer.removeInventoryItem('stolen_pc', sell)
            xPlayer.removeInventoryItem('stolen_tv', sell)
            xPlayer.removeInventoryItem('stolen_phone', sell)
            xPlayer.removeInventoryItem('stolen_camera', sell)
            xPlayer.addInventoryItem("black_money", payout)
            TriggerClientEvent("esx:showNotification", source, Config.Locale["sellfinish"].message, Config.Locale["sellfinish"].type)
        else
            TriggerClientEvent("esx:showNotification", source, Config.Locale["missing"].message, Config.Locale["missing"].type)
        end    
    else
        DropPlayer(source, 'Cheating is rude')
    end
  end
end) 

register("gg:check", function()
  local xPlayer = ESX.GetPlayerFromId(source)
  local xPlayers = ESX.GetPlayers()
  if xPlayer.getInventoryItem("bag").count >= 1 then 
      callclient("gg:animation", source)
  else 
    TriggerClientEvent("esx:showNotification", source, Config.Locale["needbag"].message, Config.Locale["needbag"].type)
    TriggerClientEvent("esx:showNotification", xPlayers.source, Config.Locale["pdnotify"].message, Config.Locale["pdnotify"].type)
  end
  end)

register("gg:addingitems")
 handler("gg:addingitems", function()
  local xPlayer = ESX.GetPlayerFromId(source)
  Items = {
    "stolen_pc",
    "stolen_tv",
    "stolen_phone",
    'stolen_camera'
}
  
function RandomItem()
return Items[math.random(#Items)]
end

xPlayer.addInventoryItem(RandomItem(), math.random(1,6))
end)