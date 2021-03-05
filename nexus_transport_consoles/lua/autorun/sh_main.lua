if CLIENT then
	surface.CreateFont( "NTC_Text", {
		font = "neuropol", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 30,
	} )

	net.Receive("NTC_Hyperspace", function()
		local Menu = vgui.Create("DFrame")
		Menu:SetTitle( "Hyperspace Console" )
		Menu:SetSize( 300,300 )
		Menu:Center()			
		Menu:MakePopup()

		local HyperspaceOptions = vgui.Create( "DComboBox", Menu )
		HyperspaceOptions:SetPos( 25, 30 )
		HyperspaceOptions:SetSize( 250, 20 )
		HyperspaceOptions:SetValue( "options" )
		for k,v in pairs(NTC.Planets) do
			HyperspaceOptions:AddChoice(v.name, v.map)
		end

		local Button = vgui.Create( "DButton", Menu )
		Button:SetText( "Enter Hyperspace" )
		Button:SetPos( 25, 250 )
		Button:SetSize( 250, 30 )
		Button.DoClick = function()
			for i, ply in ipairs( player.GetAll() ) do
				ply:PrintMessage( HUD_PRINTCENTER, "Hyperspace coordinates received, commencing jump, now." )
				surface.PlaySound("everfall/vehicles/v_wing/passbys/v-wing_bys_01.mp3")
				LocalPlayer():ScreenFade( SCREENFADE.OUT, color_white, 2, 1 )
			end

			local HyperspaceLoc = HyperspaceOptions:GetOptionData(HyperspaceOptions:GetSelectedID())
			timer.Simple(2, function()
				net.Start("NTC_Activate")
					net.WriteString(HyperspaceLoc)
				net.SendToServer()

			end)

		end

	end)

	net.Receive("NTC_LAAT", function()
		local LAATMenu = vgui.Create("DFrame")
		LAATMenu:SetTitle( "LAAT Controls" )
		LAATMenu:SetSize( 300,300 )
		LAATMenu:Center()			
		LAATMenu:MakePopup()

		local LAATOptions = vgui.Create( "DComboBox", LAATMenu )
		LAATOptions:SetPos( 25, 30 )
		LAATOptions:SetSize( 250, 20 )
		LAATOptions:SetValue( "options" )
		for k,v in pairs(NTC.Planets) do
			LAATOptions:AddChoice(v.name, v.map)
		end
		for k,v in pairs(NTC.Ships) do
			LAATOptions:AddChoice(v.name, v.map)
		end

		local LAATButton = vgui.Create( "DButton", LAATMenu )
		LAATButton:SetText( "Begin Extraction Timer" )
		LAATButton:SetPos( 25, 250 )
		LAATButton:SetSize( 250, 30 )
		LAATButton.DoClick = function()
			if timer.Exists("NTC_LAATTIMER") then
				timer.Destroy("NTC_LAATTIMER")
			end
			for i, ply in ipairs( player.GetAll() ) do
				ply:PrintMessage( HUD_PRINTCENTER, "LAAT Extraction is set, you have " .. NTC.LAATTimer / 60 .. " minute(s) to reach the extraction zone." )
				surface.PlaySound("everfall/equipment/jetpack/jumptrooper/out_of_fuel/jetpack_jumpcop_outoffuel_01.mp3")
				hook.Add("HUDPaint", "NTC_Timer", function()
					draw.SimpleText( math.floor(timer.TimeLeft( "NTC_LAATTIMER" )), "NTC_Text", 10,10 , Color(255, 255,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				end)
			end
			local LAATLoc = (LAATOptions:GetOptionData(LAATOptions:GetSelectedID()))
			timer.Create("NTC_LAATTIMER", NTC.LAATTimer, 1, function()
				for i, ply in ipairs( player.GetAll() ) do
					ply:PrintMessage( HUD_PRINTCENTER, "LAAT ready for dustoff.")
					hook.Remove("HUDPaint", "NTC_Timer")
					LocalPlayer():ScreenFade( SCREENFADE.OUT, color_black, 2, 1 )
				end
				timer.Simple(2, function()
					net.Start("NTC_Activate")
						net.WriteString(LAATLoc)
					net.SendToServer()
				end)

			end)
			-- timer.Simple(2, function()
			-- 	net.Start("NTC_Activate")
			-- 		net.WriteString(DComboBox:GetOptionData(DComboBox:GetSelectedID()))
			-- 	net.SendToServer()

			-- end)

		end

	end)
end

if SERVER then
	util.AddNetworkString("NTC_Hyperspace")
	util.AddNetworkString("NTC_Activate")

	net.Receive("NTC_Activate", function()
		RunConsoleCommand("changelevel", net.ReadString())
	end)

	-- hook.Add("PlayerInitialSpawn", "NTC_InitialTP", function(ply)
	-- 	for k,v in pairs(ents.GetAll()) do
	-- 		if v:GetClass() == "ntc_spawner" then
	-- 			ply:SetPos(v:GetPos())
	-- 		end
	-- 	end
	-- end)

	hook.Add("PlayerSpawn", "NTC_InitialTP", function(ply)
		for k,v in pairs(ents.GetAll()) do
			if v:GetClass() == "ntc_spawner" then
				ply:SetPos(v:GetPos())
			end
		end
	end)
end