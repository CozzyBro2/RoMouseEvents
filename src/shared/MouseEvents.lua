local module = {}

local events_enabled = true
-- // Controls if the custom events are enabled
-- // See #Configuration in README.md for details


local global_config = {
	--// The configuration all config tables inherit and can overwrite
	--// See #Configuration in README.md for details

	allowMultiple = false,
	watchPosition = false,

}

local inputs = game:GetService('UserInputService')
local active = {}

local function MakeSignal()
	-- // Wrapper func for use with custom signals, etc
	-- // See #Configuration in README.md for details

	return Instance.new('BindableEvent')
end

local function GetEvent(signal)
	-- // Returns the event property in-case of BindableEvents or equivalents
	-- // And just the signal for everyone else

	return signal.Event or signal
end

local function GetConfig(options)
	-- // Merge given config with global config

	local info = {}
	options = options or {}

	for key, value in pairs(global_config) do
		info[key] = options[key] or value
	end

	return info
end

local function LeaveAll()
	-- // Fire leave for every active gui
	-- // Used when 'allowMultiple' is falsy

	for _, info in pairs(active) do
		if info.entered then
			info.leave:Fire()
		end
	end
end

local function Validate(object)
	-- // Ensures the input is a supported type
	-- // You can add support for other inputs here

	local input = object.UserInputType

	return input == Enum.UserInputType.MouseMovement or input == Enum.UserInputType.Touch
end

function module.Listen(gui, options)
	-- // Return mouse events given a GuiObject and an optional config

	if not events_enabled then
		-- // Abort and return stock events

		return gui.MouseEnter, gui.MouseLeave
	end

	local info = GetConfig(options)
	local connections = {}

	local enter = MakeSignal()
	local leave = MakeSignal()

	local function Enter()
		if info.entered then return end

		if not info.allowMultiple then
			LeaveAll()
		end

		info.entered = true
		enter:Fire()
	end

	local function Leave()
		if not info.entered then return end
		info.entered = false

		leave:Fire()
	end

	local function Began(object)
		if Validate(object) then
			Enter()
		end
	end

	local function Ended(object)
		if Validate(object) then
			Leave()
		end
	end

	local function Moved()
		local position = inputs:GetMouseLocation()

		local distance = (Vector2.new(position.X, position.Y) - gui.AbsolutePosition)
		local colliding = distance.Magnitude <= gui.AbsoluteSize.Magnitude / 2

		if colliding then
			Enter()
		else
			Leave()
		end
	end

	if info.watchPosition then
		connections.moved = gui:GetPropertyChangedSignal('AbsolutePosition'):Connect(Moved)
	end

	connections.began = gui.InputBegan:Connect(Began)
	connections.ended = gui.InputEnded:Connect(Ended)

	info.enter = enter
	info.leave = leave

	info.connections = connections
	active[gui] = info

	return GetEvent(enter), GetEvent(leave)
end

function module.Release(gui)
	-- // Cleanup and stop mouse events for a given GuiObject

	local info = active[gui]

	if info then
		info.enter:Destroy()
		info.leave:Destroy()

		for _, connection in pairs(info.connections) do
			connection:Disconnect()
		end
	end
end

return module