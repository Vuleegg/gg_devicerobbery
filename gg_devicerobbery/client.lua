ESX = exports['es_extended']:getSharedObject()
local register = RegisterNetEvent 
local handler = AddEventHandler 
local callserver = TriggerServerEvent 
local callclient = TriggerEvent

--░██████╗░░██████╗░  ██████╗░███████╗░██████╗░█████╗░██╗░░░██╗██████╗░░█████╗░███████╗░██████╗
--██╔════╝░██╔════╝░  ██╔══██╗██╔════╝██╔════╝██╔══██╗██║░░░██║██╔══██╗██╔══██╗██╔════╝██╔════╝
--██║░░██╗░██║░░██╗░  ██████╔╝█████╗░░╚█████╗░██║░░██║██║░░░██║██████╔╝██║░░╚═╝█████╗░░╚█████╗░
--██║░░╚██╗██║░░╚██╗  ██╔══██╗██╔══╝░░░╚═══██╗██║░░██║██║░░░██║██╔══██╗██║░░██╗██╔══╝░░░╚═══██╗
--╚██████╔╝╚██████╔╝  ██║░░██║███████╗██████╔╝╚█████╔╝╚██████╔╝██║░░██║╚█████╔╝███████╗██████╔╝
--░╚═════╝░░╚═════╝░  ╚═╝░░╚═╝╚══════╝╚═════╝░░╚════╝░░╚═════╝░╚═╝░░╚═╝░╚════╝░╚══════╝╚═════╝░

AddEventHandler("onResourceStop", function(res)
  if GetCurrentResourceName() == res then
    for k, v in pairs(Config.Settings) do
      exports.qtarget:RemoveZone(v.name)
    end
  end 
end)


--[POLYZONE]

CreateThread(function()
   for k, v in pairs(Config.Start) do
    exports.qtarget:AddBoxZone("startmission", v.coords, 0.85, 0.65, {
      name="startmission",
      heading=70.0,
      debugPoly=Config.Debug,
      minZ=v.coords.z -1,
      maxZ=v.coords.z +2,
      }, {
        options = {
          {
            event = "gg:missionstart",
            label = "Start robbery",
          },
        },
        distance = 3.5
    })
  end
end)


register("gg:tables", function()
  Citizen.CreateThread(function()
      for k, v in pairs(Config.Settings)do 
        vektor = vec3(v.coords)
        exports.qtarget:AddBoxZone(v.name, v.coords, 1.0, 3.0, {
          name=v.name,
          heading=70.0,
          debugPoly=Config.Debug,
          minZ=vektor.z -1.7,
          maxZ=vektor.z +2,
          }, {
            options = {
              {
                event = "gg:servercheck",
                label = "Pick device",
              },
            },
            distance = 1
        })
      end
    end)
end)

CreateThread(function()
  for k, v in pairs(Config.Sell)do 
    exports.qtarget:AddBoxZone("sell", v.coords, 0.85, 0.65, {
      name="sell",
      heading=11.0,
      debugPoly=Config.Debug,
      minZ=v.coords.z -1,
      maxZ=v.coords.z +2,
      }, {
        options = {
          {
            event = "gg:callingserver",
            label = "Sell devices",
          },
        },
        distance = 4.5
    })
  end
end)


register("gg:missionstart", function()
  ESX.TriggerServerCallback('gg:devicerobbery', function(CopsConnected)
  if CopsConnected >= Config.Neededpolice then
   missionstarted()
 
  else
    ESX.ShowNotification(Config.Locale["neededpolice"]["message"],Config.Locale["neededpolice"]["type"])
    end
  end)
end)

register("gg:servercheck", function() --calling server event for check and playing anim
  callserver("gg:check")
end)

--[BLIPS]
Citizen.CreateThread(function()
    for k, v in pairs(Config.Blipsettings)do
      if Config.Blip == true then 
        Config.Blip = AddBlipForCoord(v.blipcoords)

      SetBlipSprite (Config.Blip, v.id)
      SetBlipDisplay(Config.Blip, 4)
      SetBlipScale  (Config.Blip, 0.8)
      SetBlipColour (Config.Blip, v.color)
      SetBlipAsShortRange(Config.Blip, true)

      BeginTextCommandSetBlipName('STRING')
      AddTextComponentSubstringPlayerName(v.blipname)
      EndTextCommandSetBlipName(Config.Blip)
    end
  end
end)




Citizen.CreateThread(function()
  for k, v in pairs(Config.Sell)do
RequestModel(GetHashKey('a_m_m_og_boss_01'))
while not HasModelLoaded(GetHashKey('a_m_m_og_boss_01')) do
Wait(1)
end
PostaviPeda = CreatePed(4, 'a_m_m_og_boss_01', v.coords , v.heading, false, true)
FreezeEntityPosition(PostaviPeda, true) 
SetEntityInvincible(PostaviPeda, true)
SetBlockingOfNonTemporaryEvents(PostaviPeda, true)
	end
end)

--[TIME FOR ROBBERY]
function missionstarted()
    local sound =  GetSoundId()
  --- local time = GetClockHours()
    --if time > 20 or time < 1 then
    callclient("gg:tables")
    callclient("gg:markers")
    PlaySoundFromCoord(sound, "VEHICLES_HORNS_AMBULANCE_WARNING", ped)
    ESX.ShowNotification(Config.Locale["missionstart"]["message"],Config.Locale["missionstart"]["type"])
    ESX.ShowNotification(Config.Locale["robberytime"]["message"],Config.Locale["robberytime"]["type"])
    Wait(Config.RobberyTime)
    for k, v in pairs(Config.Settings) do
    exports.qtarget:RemoveZone(v.name)
    ESX.ShowNotification(Config.Locale["finish"]["message"],Config.Locale["finish"]["type"])
    StopSound(sound)
    callclient("gg:offmarkers1")
    end
end



  local location1 = false
  local location2 = false
  local location3 = false
  local location4 = false
  local location5 = false
  local location6 = false
  local location7 = false
  local location8 = false
  local location9 = false

register("gg:markers", function()
  while true do
    Wait(0)
    if location1 == false  then
    DrawMarker(2, 149.1028, -227.237, 55.373 + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 100, true, true, 2, nil, nil, false)
    end
    if location2 == false then
    DrawMarker(2, 152.7091, -228.887, 55.609 + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 100, true, true, 2, nil, nil, false)
    end
    if location3 == false  then
    DrawMarker(2, 155.9101, -230.007, 55.396 + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 100, true, true, 2, nil, nil, false)
    end
    if location4 == false  then
    DrawMarker(2, 157.8217, -225.564, 55.373 + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 100, true, true, 2, nil, nil, false)
    end
    if location5 == false  then
    DrawMarker(2, 154.7259, -224.037, 55.373 + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 100, true, true, 2, nil, nil, false)
    end
    if location6 == false  then
    DrawMarker(2, 151.3875, -223.021, 55.372 + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 100, true, true, 2, nil, nil, false)
    end
    if location7 == false  then
    DrawMarker(2, 147.699996, -221.199996, 55.700000 + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 100, true, true, 2, nil, nil, false)
    end
    if location8 == false  then
    DrawMarker(2, 145.9705, -225.838, 55.373 + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 100, true, true, 2, nil, nil, false)
    end
  end
end)

register("gg:offmarkers", function()
  local ped = PlayerPedId()
   for k, v in pairs(Config.Settings) do
    print(GetEntityCoords(ped))
    if GetDistanceBetweenCoords(GetEntityCoords(ped), 149.1028, -227.237, 55.373 , true) <= 2.3 then 
      print('1')
      location1 = true 
      for k, v in pairs(Config.Settings) do
        exports.qtarget:RemoveZone( 'table1')
      end
    end 
    if GetDistanceBetweenCoords(GetEntityCoords(ped), 152.7091, -228.887, 55.609 , true) <= 2.3 then
      location2 = true
      for k, v in pairs(Config.Settings) do
        exports.qtarget:RemoveZone( 'table2')
      end
    end
    if GetDistanceBetweenCoords(GetEntityCoords(ped), 155.9101, -230.007, 55.396 , true) <= 2.3 then 
      location3 = true
      for k, v in pairs(Config.Settings) do
        exports.qtarget:RemoveZone( 'table3')
      end
    end
    if GetDistanceBetweenCoords(GetEntityCoords(ped), 157.8217, -225.564, 55.373 , true) <= 2.3 then
      location4 = true
      for k, v in pairs(Config.Settings) do
        exports.qtarget:RemoveZone( 'table4')
      end
    end
    if GetDistanceBetweenCoords(GetEntityCoords(ped), 154.7259, -224.037, 55.373 , true) <= 2.3 then
      location5 = true
      for k, v in pairs(Config.Settings) do
        exports.qtarget:RemoveZone( 'table5')
      end
    end
    if GetDistanceBetweenCoords(GetEntityCoords(ped), 151.3875, -223.021, 55.372 , true) <= 2.3 then
      location6 = true
      for k, v in pairs(Config.Settings) do
        exports.qtarget:RemoveZone( 'table6')
      end
    end
    if GetDistanceBetweenCoords(GetEntityCoords(ped), 147.699996, -221.199996, 55.700000 , true) <= 2.3 then
      location7 = true
      for k, v in pairs(Config.Settings) do
        exports.qtarget:RemoveZone( 'table7')
      end
    end
    if GetDistanceBetweenCoords(GetEntityCoords(ped), 145.9705, -225.838, 55.373 , true) <= 2.3 then
      location8 = true
      for k, v in pairs(Config.Settings) do
        exports.qtarget:RemoveZone( 'table8')
      end
    end
  end
end)
register("gg:offmarkers1", function()
  local ped = PlayerPedId()
   for k, v in pairs(Config.Settings) do
    if v.name == "table1" then 
      location1 = true 
    end 
    if v.name == "table2" then 
      location2 = true
    end
    if v.name == "table3" then 
      location3 = true
    end
    if v.name == "table4" then 
      location4 = true
    end
    if v.name == "table5" then 
      location5 = true
    end
    if v.name == "table6" then 
      location6 = true
    end
    if v.name == "table7" then 
      location7 = true
    end
    if v.name == "table8" then 
      location8 = true
    end
  end
end)


register("gg:callingserver", function()
  callserver("gg:sellitems")
end)
--[animation & system]
register("gg:animation")
handler("gg:animation", function()
  local ped = PlayerPedId()
  local loc = GetEntityCoords(ped)
  local rotplus = GetEntityHeading(ped)
  local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
  local bagscene = NetworkCreateSynchronisedScene(loc.x, loc.y, loc.z - 0.6, rotx, roty, rotz + rotplus, 2.0, false, false, 1065353216, 0, 1.3)
  local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), loc.x, loc.y, loc.z,  true,  true, false)
  local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(PlayerPedId()), GetEntityRotation(PlayerPedId()), 2, false, false, 1065353216, 0, 1.3)
  NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
  NetworkAddEntityToSynchronisedScene(trollyobj, bagscene, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
  NetworkStartSynchronisedScene(bagscene)
  if Config.Rprogres == true then  
  exports.rprogress:Custom({
    Duration = Config.Time,
    Label = "Robing...",
    DisableControls = {
      Mouse = false,
      Player = true,
      Vehicle = true
    }
  })
else
  lib.progressCircle({
		duration = Config.Time,
		label = "Robing...",
		useWhileDead = false,
		canCancel = true,
		disable = {
			move = true,
			car = true,
			combat = true,
		},
}) 
end
Wait(Config.Time)
TriggerEvent("gg:offmarkers")
DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
    SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
    callserver("gg:addingitems")
end)


