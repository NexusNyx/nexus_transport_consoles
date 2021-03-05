include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	cam.Start3D2D(self:GetPos(), Angle( 0, RenderAngles().y - 90, 90 ), 0.1)
		draw.SimpleText("LAAT Transport", "NTC_LAATText", 0,-4000, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	cam.End3D2D()
end

function ENT:DrawTranslucent(flags)
	self:Draw( flags )
end