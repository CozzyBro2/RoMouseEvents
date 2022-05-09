--!strict

local module = {}

local events_enabled = true
--[[

	Set to 'false' to disable all custom behavior
	and fallback to the default roblox events.

	A case where this may be useful would be if roblox ever improves
	the stock events; rendering this module obsolete.

]]

-- The configuration all config tables inherit and can overwrite.
local global_config = {

	allowMultiple = false,
	--[[
		Whether the event can fire on another gui while a different gui is still entered.

		Recommended: false
		Default: false
	]]

}

local function MakeSignal()
	--[[
		Wrapper that you can modify to use a different signal.
		NOTE: Custom signal must be syntactically identical to bindable events
	]]
	return Instance.new('BindableEvent')
end

function module.Listen(gui, info)

end

return module