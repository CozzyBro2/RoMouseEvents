local playerGui = game:GetService('Players').LocalPlayer.PlayerGui
local common = game:GetService('ReplicatedStorage').Common

local gui = playerGui:WaitForChild('ScreenGui')
local frame = gui:WaitForChild('Frame')

local mouseEvents = require(common.MouseEvents)

local enter, leave = mouseEvents.Listen(frame)

enter:Connect(function()
	print("hey i've entered")
end)

leave:Connect(function()
	print("hey i've left")
end)

task.wait(5)

--mouseEvents.Release(frame)