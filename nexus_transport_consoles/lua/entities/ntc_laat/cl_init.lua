include("shared.lua")

surface.CreateFont( "NTC_LAATText", {
	font = "neuropol", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 250,
} )

function ENT:Draw()
	self:DrawModel()
	cam.Start3D2D(self:GetPos(), Angle( 0, RenderAngles().y - 90, 90 ), 0.1)
		draw.SimpleText("LAAT Extraction", "NTC_LAATText", 0,-4000, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	cam.End3D2D()
end

function ENT:DrawTranslucent(flags)
	self:Draw(flags)
end