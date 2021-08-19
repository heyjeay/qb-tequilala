isLoggedIn = false
local PlayerJob = {}


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == "tequilala" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["carspawn"].coords.x, Config.Locations["carspawn"].coords.y, Config.Locations["carspawn"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["carspawn"].coords.x, Config.Locations["carspawn"].coords.y, Config.Locations["carspawn"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["carspawn"].coords.x, Config.Locations["carspawn"].coords.y, Config.Locations["carspawn"].coords.z, true) < 1.5) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                            DrawText3Ds(Config.Locations["carspawn"].coords.x, Config.Locations["carspawn"].coords.y, Config.Locations["carspawn"].coords.z, "~g~E~w~ - Store Vehicle")
                        else
                            DrawText3Ds(Config.Locations["carspawn"].coords.x, Config.Locations["carspawn"].coords.y, Config.Locations["carspawn"].coords.z, "~g~E~w~ - Vehicles")
                        end
                        if IsControlJustReleased(0, Keys["E"]) then
                            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                            else
                                VehicleSpawn()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
                    end 
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == "tequilala" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, true) < 1.5) then
                            DrawText3Ds(Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, "~g~E~w~ - Stash ")
                        if IsControlJustReleased(0, Keys["E"]) then
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "tequilalastash", {
                                maxweight = 4000000,
                                slots = 500,
                            })
                            TriggerEvent("inventory:client:SetCurrentStash", "tequilalastash")
                        end
                    end
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == "tequilala" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, true) < 1.5) then
                            DrawText3Ds(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, "~g~E~w~ - Shop ")
                        if IsControlJustReleased(0, Keys["E"]) then
                            TriggerServerEvent("inventory:server:OpenInventory", "shop", "tequilala", Config.Items)
                        end
                    end
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

function VehicleSpawn()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicles", "VehicleList", nil)
    Menu.addButton("Close Menu", "closeMenuFull", nil) 
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["carspawn"].coords
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "Tequilala")
        local color = GetIsVehiclePrimaryColourCustom(veh)
        SetVehicleCustomPrimaryColour(veh, 0,0,0)
        SetVehicleCustomSecondaryColour(veh, 0,0,0)
        SetEntityHeading(veh, coords.h)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = GetVehicleNumberPlateText(veh)
    end, coords, true)
end

function VehicleList(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicles:"
    ClearMenu()
    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "TakeOutVehicle", k, "Garage", " Motor: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Back", "VehicleSpawn",nil)
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end

Citizen.CreateThread(function()
    while true do
        local inRange = false
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)

        for loc,_ in pairs(Config.Teleports) do
            for k, v in pairs(Config.Teleports[loc]) do
                local dist = GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true)

                if dist < 2 then
                    inRange = true
                    DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)

                    if dist < 1 then
                        DrawText3Ds(v.x, v.y, v.z, '~g~E~w~ Enter')
                        if IsControlJustReleased(0, 51) then
                            if k == 1 then
                                SetEntityCoords(ped, Config.Teleports[loc][2].x, Config.Teleports[loc][2].y, Config.Teleports[loc][2].z)
                            elseif k == 2 then
                                SetEntityCoords(ped, Config.Teleports[loc][1].x, Config.Teleports[loc][1].y, Config.Teleports[loc][1].z)
                            end
                            ResetTeleport()
                        end
                    end
                end
            end
        end

        if not inRange then
            Citizen.Wait(1000)
        end

        Citizen.Wait(3)
    end
end)

ResetTeleport = function()
    SetTimeout(1000, function()
        JustTeleported = false
    end)
end

-- Function for 3D text:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

-- Blip on map for Tequila-la-la Location:
Citizen.CreateThread(function()
	for k,v in ipairs(Config.tequilalaLocation)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, Config.tequilalaBlipSprite)
		SetBlipDisplay(blip, Config.tequilalaBlipDisplay)
		SetBlipScale  (blip, Config.tequilalaBlipScale)
		SetBlipColour (blip, Config.tequilalaBlipColour)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.tequilalaBlipNameOnMap)
		EndTextCommandSetBlipName(blip)
	end
end)

