local module = {}

local global_config = {
	--// The configuration all config tables inherit and can overwrite
	--// See #Configuration in README.md for details

	eventsEnabled = true,

	allowMultiple = false,
	watchPosition = true,

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

local function Validate(object)
	-- // Ensures the input is a supported type
	-- // You can add support for other inputs here

	local input = object.UserInputType

	return input == Enum.UserInputType.MouseMovement or input == Enum.UserInputType.Touch
end

local function IsEntered(gui)
	--[[
		Likely inaccurate heuristic to tell if the mouse occupies the same space as the target gui
		Used to tell if the mouse is still focused on a gui even if the position changes, but the mouse doesn't
		Only used when 'watchPosition' is enabled
		See #Configuration in README.md for details
	--]]

	local position = inputs:GetMouseLocation()

	return (Vector2.new(position.X, position.Y) - gui.AbsolutePosition).Magnitude <= gui.AbsoluteSize.Magnitude
end

local function Left(info)
	-- // Fired whenever the input leaves the gui
	-- // Can only fire while the gui is considered entered

	if not info.entered then return end
	info.entered = false

	local moved = info.connections.moved

	if moved then
		moved:Disconnect()
	end

	info.leave:Fire()
end

local function LeaveAll()
	-- // Fire leave for every active gui
	-- // Used when 'allowMultiple' is falsy

	for _, info in pairs(active) do
		Left(info)
	end
end

local function Entered(info)
	-- // Fired whenever the input enters the gui
	-- // Can only fire while the gui isn't considered entered

	if info.entered then print('early') return end

	if not info.allowMultiple then
		LeaveAll()
	end

	if info.watchPosition then
		local gui = info.gui

		info.connections.moved = gui:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
			-- // Is the mouse still colliding with the gui?
			-- // If not, we should fire leave

			if not IsEntered(gui) then
				Left(info)
			end
		end)
	end

	info.entered = true
	info.enter:Fire()
end

function module.Listen(gui, options)
	-- // Return mouse events given a GuiObject and an optional config

	local info = GetConfig(options)

	if not info.eventsEnabled then
		-- // Abort and return stock events

		return gui.MouseEnter, gui.MouseLeave
	end

	local connections = {}

	local enter = MakeSignal()
	local leave = MakeSignal()

	local function Began(object)
		if Validate(object) then
			Entered(info)
		end
	end

	local function Ended(object)
		if Validate(object) then
			Left(info)
		end
	end

	connections.began = gui.InputBegan:Connect(Began)
	connections.ended = gui.InputEnded:Connect(Ended)

	info.enter = enter
	info.leave = leave

	info.connections = connections
	info.gui = gui

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