AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

util.AddNetworkString("NTC_LAAT")

function ENT:Initialize()
	self:SetModel( "models/blu/laat.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	local phys = self:GetPhysicsObject()

	phys:Wake()
	self:EmitSound( "lfs/laat/loop.wav", 75 )
end


function ENT:OnRemove()
	self:StopSound( "lfs/laat/loop.wav" )
	-- local explosion = ents.Create( "env_explosion" ) -- The explosion entity
	-- explosion:SetPos( self:GetPos() ) -- Put the position of the explosion at the position of the entity
	-- explosion:Spawn() -- Spawn the explosion
	-- explosion:SetKeyValue( "iMagnitude", "500" ) -- the magnitude of the explosion
	-- explosion:Fire( "Explode", 0, 0 ) -- explode
end