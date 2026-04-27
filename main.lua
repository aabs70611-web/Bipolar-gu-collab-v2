local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")

ScreenGui.Name = "bipolarkidd 2 collab gui v2🔥"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Size = UDim2.new(0, 480, 0, 420)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
MainFrame.BorderColor3 = Color3.fromRGB(255,255,0)
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "bipolarkidd 2 collab gui v2🔥"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 24
Title.Font = Enum.Font.Cartoon
Title.Parent = MainFrame

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0,35,0,35)
MinBtn.Position = UDim2.new(1,-40,0,2)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
MinBtn.BorderColor3 = Color3.fromRGB(255,255,0)
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.Parent = MainFrame

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,0,1,-40)
Content.Position = UDim2.new(0,0,0,40)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

local minimized = false
local originalSize = MainFrame.Size

MinBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	Content.Visible = not minimized
	MainFrame.Size = minimized and UDim2.new(0,480,0,40) or originalSize
	MinBtn.Text = minimized and "+" or "-"
end)

local function createBtn(text, index)
	local cols = 3
	local spacing = 10
	local w,h = 140,40

	local row = math.floor((index-1)/cols)
	local col = (index-1)%cols

	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,w,0,h)
	b.Position = UDim2.new(0,col*(w+spacing)+10,0,row*(h+spacing)+10)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(0,0,0)
	b.BorderColor3 = Color3.fromRGB(255,255,0)
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.Font = Enum.Font.Cartoon
	b.TextSize = 16
	b.Parent = Content
	return b
end

local part1 = createBtn("Particles 1",1)
local part2 = createBtn("Particles 2",2)
local decal1 = createBtn("Decal 1",3)
local decal2 = createBtn("Decal 2",4)
local sky1 = createBtn("Skybox 1",5)
local sky2 = createBtn("Skybox 2",6)
local music1 = createBtn("Music 1",7)
local music2 = createBtn("Music 2",8)
local music3 = createBtn("Music 3",9)
local discoBtn = createBtn("DISCO",10)
local jumpBtn = createBtn("Jumpscare",11)
local hintBtn = createBtn("Hint",12)
local msgBtn = createBtn("Mensaje",13)
local clearBtn = createBtn("Limpiar",14)
local part3 = createBtn("Particles 3",15)
local decal3 = createBtn("Decal 3",16)
local sky3 = createBtn("Skybox 3",17)
local jump2 = createBtn("Jumpscare 2",18)

local function particles(id)
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and not v:FindFirstChild("PART55") then
			local p = Instance.new("ParticleEmitter")
			p.Name = "PART55"
			p.Texture = "rbxassetid://"..id
			p.Rate = 12
			p.Lifetime = NumberRange.new(1,2)
			p.Speed = NumberRange.new(3,8)
			p.Rotation = NumberRange.new(0,360)
			p.RotSpeed = NumberRange.new(-200,200)
			p.SpreadAngle = Vector2.new(360,360)
			p.Parent = v
		end
	end
end

local function decalSpam(id)
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			for _,f in pairs(Enum.NormalId:GetEnumItems()) do
				local d = Instance.new("Decal")
				d.Texture = "rbxassetid://"..id
				d.Face = f
				d.Parent = v
			end
		end
	end
end

local function setSky(id)
	for _,v in pairs(game.Lighting:GetChildren()) do
		if v:IsA("Sky") then v:Destroy() end
	end
	local s = Instance.new("Sky")
	for _,f in pairs({"Bk","Dn","Ft","Lf","Rt","Up"}) do
		s["Skybox"..f] = "rbxassetid://"..id
	end
	s.Parent = game.Lighting
end

local sound
local function playMusic(id,vol,pitch)
	if sound then sound:Destroy() end
	sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://"..id
	sound.Volume = vol
	sound.PlaybackSpeed = pitch
	sound.Looped = true
	sound.Parent = game.SoundService
	sound:Play()
end

local discoOn = false
local function disco()
	discoOn = not discoOn
	if discoOn then
		task.spawn(function()
			while discoOn do
				local c = Color3.fromHSV(tick()%5/5,1,1)
				game.Lighting.Ambient = c
				game.Lighting.FogColor = c
				task.wait(0.1)
			end
		end)
	end
end

local function jumpscare()
	local sg = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	local img = Instance.new("ImageLabel", sg)
	img.Size = UDim2.new(1,0,1,0)
	img.Image = "rbxassetid://118428386739629"
	task.wait(5)
	sg:Destroy()
end

local function showHint()
	local h = Instance.new("Hint")
	h.Text = "SORRY KIDS YOU GAME IS HACKED BY TEAMBIPOLARKIDD2 😎🔥"
	h.Parent = workspace
	task.wait(5)
	h:Destroy()
end

local function showMessage()
	local m = Instance.new("Message")
	m.Text = "YOU GAME IS HACKED BY TEAMBIPOLARKIDD2 😎🔥"
	m.Parent = workspace
	task.wait(5)
	m:Destroy()
end

local function clear()
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Decal") or v:IsA("ParticleEmitter") then
			v:Destroy()
		end
	end
end

part1.MouseButton1Click:Connect(function() particles("97396656261103") end)
part2.MouseButton1Click:Connect(function() particles("75398237741766") end)
part3.MouseButton1Click:Connect(function() particles("88263075878326") end)

decal1.MouseButton1Click:Connect(function() decalSpam("97396656261103") end)
decal2.MouseButton1Click:Connect(function() decalSpam("75398237741766") end)
decal3.MouseButton1Click:Connect(function() decalSpam("88263075878326") end)

sky1.MouseButton1Click:Connect(function() setSky("138862536890100") end)
sky2.MouseButton1Click:Connect(function() setSky("93558419111236") end)
sky3.MouseButton1Click:Connect(function() setSky("116447394970442") end)

music1.MouseButton1Click:Connect(function() playMusic("1846368080",3,1) end)
music2.MouseButton1Click:Connect(function() playMusic("91402883144213",2,0.59) end)
music3.MouseButton1Click:Connect(function() playMusic("86412047196482",2,1) end)

discoBtn.MouseButton1Click:Connect(disco)
jumpBtn.MouseButton1Click:Connect(jumpscare)

jump2.MouseButton1Click:Connect(function()
	local sg = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	local img = Instance.new("ImageLabel", sg)
	img.Size = UDim2.new(1,0,1,0)
	img.BackgroundTransparency = 1
	img.Image = "rbxassetid://86380461326437"
	task.wait(5)
	sg:Destroy()
end)

hintBtn.MouseButton1Click:Connect(showHint)
msgBtn.MouseButton1Click:Connect(showMessage)
clearBtn.MouseButton1Click:Connect(clear)
