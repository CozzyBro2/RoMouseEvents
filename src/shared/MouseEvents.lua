--!strict

local module = {}

local events_enabled = true
-- // Controls if the custom events are enabled.
-- // See #Configuration in README.md for details.


local global_config = {
	--// The configuration all config tables inherit and can overwrite.
	--// See #Configuration in README.md for details.

	allowMultiple = false,

}

local function MakeEvent()
	-- // Wrapper func for use with custom signals, etc.
	-- // See #Configuration in README.md for details.

	return Instance.new('BindableEvent')
end

function module.Listen(gui, info)

end

return module