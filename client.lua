isLoggedIn = true
PlayerJob = {}

local onDuty = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "tequilala" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

Citizen.CreateThread(function()
    Tequilala = AddBlipForCoord(-562.50, 285.63, 82.18)
    SetBlipSprite (Tequilala, 93)
    SetBlipDisplay(Tequilala, 4)
    SetBlipScale  (Tequilala, 0.8)
    SetBlipAsShortRange(Tequilala, true)
    SetBlipColour(Tequilala, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Tequi-la-la")
    EndTextCommandSetBlipName(Tequilala)
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
        SetVehicleNumberPlateText(veh, "TEQUILA")
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

RegisterNetEvent("qb-tequilala:Duty")
AddEventHandler("qb-tequilala:Duty", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("qb-tequilala:Tray1")
AddEventHandler("qb-tequilala:Tray1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "pickuptequilala")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "pickuptequilala", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-tequilala:Storage")
AddEventHandler("qb-tequilala:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "tequilalastash")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "tequilalastash", {
        maxweight = 250000,
        slots = 40,
    })
end)

RegisterNetEvent("qb-tequilala:Storage2")
AddEventHandler("qb-tequilala:Storage2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "tequilalastash2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "tequilalastash2", {
        maxweight = 250000,
        slots = 40,
    })
end)

-- qb target --

Citizen.CreateThread(function()
    

    exports['qb-target']:AddBoxZone("TequilalaDuty", vector3(-564.37, 278.34, 83.14), 1, 1.2, {
        name = "TequilalaDuty",
        heading = 32,
        debugPoly = false,
        minZ=83.0,
        maxZ=84.0,
    }, {
        options = {
            {  
                event = "qb-tequilala:Duty",
                icon = "far fa-clipboard",
                label = "Clock On/Off",
                job = "tequilala",
            },
        },
        distance = 1.5
    })

    exports['qb-target']:AddBoxZone("tequilala_tray_1", vector3(-561.03, 286.61, 81.93), 1.05, 1.0, {
        name = "tequilala_tray_1",
        heading = 35.0,
        debugPoly = false,
        minZ=81.0,
        maxZ=83.3,
    }, {
        options = {
            {
                event = "qb-tequilala:Tray1",
                icon = "far fa-clipboard",
                label = "Pick Up Order",
            },
        },
        distance = 1.5
    })


        exports['qb-target']:AddBoxZone("tequilalafridge", vector3(-563.06, 285.82, 82.40), 1.6, 1, {
            name="tequilalafridge",
            heading=35,
            debugPoly=false,
            minZ=81.0,
            maxZ=83.6,
        }, {
                options = {
                    {
                        event = "nh-context:TequilalaMenu",
                        icon = "fas fa-laptop",
                        label = "Buy Items Or Check Storage!",
                        job = "tequilala",
                    },
                },
                distance = 1.5
            })

        exports['qb-target']:AddBoxZone("tequilalastorage", vector3(-561.67, 289.85, 82.18), 4.6, 1.2, {
            name="tequilalastorage",
            heading=34,
            debugPoly=false,
            minZ=81.0,
            maxZ=83.8,
        }, {
                options = {
                    {
                        event = "qb-tequilala:Storage",
                        icon = "fas fa-box",
                        label = "Storage",
                        job = "tequilala",
                    },
                },
                distance = 1.5
            })


        exports['qb-target']:AddBoxZone("Tequilala_register_1", vector3(-563.05, 287.44, 82.17), 0.5, 0.4, {
            name="Tequilala_register_1",
            debugPoly=false,
            heading=125,
            minZ=82.0,
            maxZ=83.5,
        }, {
                options = {
                    {
                        event = "qb-tequilala:bill",
                        parms = "1",
                        icon = "fas fa-credit-card",
                        label = "Charge Customer",
                        job = "tequilala",
                    },
                },
                distance = 1.5
            })

end)


-- NH - Context --
RegisterNetEvent('nh-context:TequilalaMenu', function(data)
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 0,
            header = "| Fridge |",
            txt = "",
        },
        {
            id = 1,
            header = "• Order Items",
            txt = "Buy items from the shop!",
            params = {
                event = "qb-tequilala:shop"
            }
        },
        {
            id = 2,
            header = "• Open Fridge",
            txt = "See what you have in storage",
            params = {
                event = "qb-tequilala:Storage2"
            }
        },
        {
            id = 3,
            header = "Close (ESC)",
            txt = "",
        },
    })
end)


-- Register Stuff --
RegisterNetEvent("qb-tequilala:bill")
AddEventHandler("qb-tequilala:bill", function()
    local bill = exports["nh-keyboard"]:KeyboardInput({
        header = "Create Receipt",
        rows = {
            {
                id = 0,
                txt = "PayPal Number"
            },
            {
                id = 1,
                txt = "Amount"
            }
        }
    })
    if bill ~= nil then
        if bill[1].input == nil or bill[2].input == nil then 
            return 
        end
        TriggerServerEvent("qb-tequilala:bill:player", bill[1].input, bill[2].input)
    end
end)



RegisterNetEvent("qb-tequilala:shop")
AddEventHandler("qb-tequilala:shop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "tequilala", Config.Items)
end)

-- GUI For Garage

Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}



Menu = {}
Menu.GUI = {}
Menu.buttonCount = 0
Menu.selection = 0
Menu.hidden = true
MenuTitle = "Menu"

function Menu.addButton(name, func,args,extra,damages,bodydamages,fuel)

	local yoffset = 0.25
	local xoffset = 0.3
	local xmin = 0.0
	local xmax = 0.15
	local ymin = 0.03
	local ymax = 0.03
	Menu.GUI[Menu.buttonCount+1] = {}
	if extra ~= nil then
		Menu.GUI[Menu.buttonCount+1]["extra"] = extra
	end
	if damages ~= nil then
		Menu.GUI[Menu.buttonCount+1]["damages"] = damages
		Menu.GUI[Menu.buttonCount+1]["bodydamages"] = bodydamages
		Menu.GUI[Menu.buttonCount+1]["fuel"] = fuel
	end


	Menu.GUI[Menu.buttonCount+1]["name"] = name
	Menu.GUI[Menu.buttonCount+1]["func"] = func
	Menu.GUI[Menu.buttonCount+1]["args"] = args
	Menu.GUI[Menu.buttonCount+1]["active"] = false
	Menu.GUI[Menu.buttonCount+1]["xmin"] = xmin
	Menu.GUI[Menu.buttonCount+1]["ymin"] = ymin * (Menu.buttonCount + 0.01) +yoffset
	Menu.GUI[Menu.buttonCount+1]["xmax"] = xmax 
	Menu.GUI[Menu.buttonCount+1]["ymax"] = ymax 
	Menu.buttonCount = Menu.buttonCount+1
end


function Menu.updateSelection() 
	if IsControlJustPressed(1, Keys["DOWN"]) then 
		if(Menu.selection < Menu.buttonCount -1 ) then
			Menu.selection = Menu.selection +1
		else
			Menu.selection = 0
		end		
		PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	elseif IsControlJustPressed(1, Keys["TOP"]) then
		if(Menu.selection > 0)then
			Menu.selection = Menu.selection -1
		else
			Menu.selection = Menu.buttonCount-1
		end	
		PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	elseif IsControlJustPressed(1, 215) then
		MenuCallFunction(Menu.GUI[Menu.selection +1]["func"], Menu.GUI[Menu.selection +1]["args"])
		PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	end
	local iterator = 0
	for id, settings in ipairs(Menu.GUI) do
		Menu.GUI[id]["active"] = false
		if(iterator == Menu.selection ) then
			Menu.GUI[iterator +1]["active"] = true
		end
		iterator = iterator +1
	end
end

function Menu.renderGUI()
	if not Menu.hidden then
		Menu.renderButtons()
		Menu.updateSelection()
	end
end

function Menu.renderBox(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
	DrawRect(0.7, yMin,0.15, yMax-0.002, color1, color2, color3, color4);
end

function Menu.renderButtons()
	
		local yoffset = 0.5
		local xoffset = 0

		
		
	for id, settings in pairs(Menu.GUI) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GetScreenResolution(0, 0)
		
		boxColor = {38,38,38,199}
		local movetext = 0.0
		if(settings["extra"] == "Garage") then
			boxColor = {44,100,44,200}
		elseif (settings["extra"] == "Impounded") then
			boxColor = {77, 8, 8,155}
		end

		if(settings["active"]) then
			boxColor = {31, 116, 207,155}
		end


		if settings["extra"] ~= nil then

			SetTextFont(4)

			SetTextScale(0.34, 0.34)
			SetTextColour(255, 255, 255, 255)
			SetTextEntry("STRING") 
			AddTextComponentString(settings["name"])
			DrawText(0.63, (settings["ymin"] - 0.012 )) 

			SetTextFont(4)
			SetTextScale(0.26, 0.26)
			SetTextColour(255, 255, 255, 255)
			SetTextEntry("STRING") 
			AddTextComponentString(settings["extra"])
			DrawText(0.730 + movetext, (settings["ymin"] - 0.011 )) 


			SetTextFont(4)
			SetTextScale(0.28, 0.28)
			SetTextColour(11, 11, 11, 255)
			SetTextEntry("STRING") 
			AddTextComponentString(settings["damages"])
			DrawText(0.778, (settings["ymin"] - 0.012 )) 

			SetTextFont(4)
			SetTextScale(0.28, 0.28)
			SetTextColour(11, 11, 11, 255)
			SetTextEntry("STRING") 
			AddTextComponentString(settings["bodydamages"])
			DrawText(0.815, (settings["ymin"] - 0.012 ))  

			SetTextFont(4)
			SetTextScale(0.28, 0.28)
			SetTextColour(11, 11, 11, 255)
			SetTextEntry("STRING") 
			AddTextComponentString(settings["fuel"])
			DrawText(0.854, (settings["ymin"] - 0.012 )) 

			

			DrawRect(0.832, settings["ymin"], 0.11, settings["ymax"]-0.002, 255,255,255,199)
		else
			SetTextFont(4)
			SetTextScale(0.31, 0.31)
			SetTextColour(255, 255, 255, 255)
			SetTextCentre(true)
			SetTextEntry("STRING") 
			AddTextComponentString(settings["name"])
			DrawText(0.7, (settings["ymin"] - 0.012 )) 

		end




		Menu.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"], settings["ymax"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])


	 end     
end

--------------------------------------------------------------------------------------------------------------------

function ClearMenu()
	--Menu = {}
	Menu.GUI = {}
	Menu.buttonCount = 0
	Menu.selection = 0
end

function MenuCallFunction(fnc, arg)
	_G[fnc](arg)
end
