--%[Информация%] %{FFFFFF%}Вы успешно взяли Золотая рулетка с ящика контрабанды!

script_name('AirHelper')
script_author('CHAPPLE')
script_version("0.8.4")
local tag = "{00FF7F}[AirHelper]: {ffffff}"

require "lib.moonloader"
local requests = require('requests')
local vkeys = require "vkeys"
local sampev = require 'lib.samp.events'
local ecfg = require "ecfg"
local imgui = require 'mimgui'
local ffi = require 'ffi'
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local fa = require('fAwesome5')
local encoding = require 'encoding'
encoding.default = 'CP1251'         
local u8 = encoding.UTF8
local ahwindow = new.bool(false)
local infowindow = new.bool(false)
local updatewindow = new.bool(false)
local sizeX, sizeY = getScreenResolution()
local date_ = os.date("%d.%m.%Y")
local time_ = os.date('%H:%M:%S')
local list_ = 0

local aircfg = {
    items = {
        --[[maty = 0,
        narko = 0,
        money = 0,

        premiy = 0,
        nostalgiy = 0,
        moto = 0,

        yellowbox = 0,
        redbox = 0,
        blueox = 0,

        platinaRuletka = 0,
        goldRuletka = 0,]]
    }
}

local CFG = getGameDirectory() .. "\\moonloader\\config\\AirHelper\\AirDropsLoot\\info.cfg"
ecfg.update(aircfg, CFG)


local fa_icon = {
	['ICON_FA_VK'] = "\xef\x86\x89",
	['ICON_FA_TELEGRAM_PLANE'] = "\xef\x8f\xbe",
}

local counts = 0
local oleni = new.int(0)

local maty = new.int(0)
local narko = new.int(0)
local premiy = new.int(0)
local nostalgiy = new.int(0)
local moto = new.int(0)
local yellowbox = new.int(0)
local redbox = new.int(0)
local bluebox = new.int(0)

local platinaRuletka = new.int(0)
local goldRuletka = new.int(0)

local money = new.int(0)

imgui.OnInitialize(function()
	DarkTheme()

	local config = imgui.ImFontConfig()
    config.MergeMode = true
	config.GlyphOffset.y = 1.0
	config.GlyphOffset.x = -5.0
    local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    local iconRanges = imgui.new.ImWchar[3](fa.min_range, fa.max_range, 0)
    bigfont = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/arialbd.ttf', 20.0, nil, glyph_ranges)
    icon = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 20.0, config, iconRanges)
    mainfont = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/arialbd.ttf', 18.0, nil, glyph_ranges)
   	icon = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 20.0, config, iconRanges)
    mfont = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/arialbd.ttf', 17.0, nil, glyph_ranges)
   	icon = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 20.0, config, iconRanges)
    submainfont = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/arialbd.ttf', 15.0, nil, glyph_ranges)
   	icon = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 16.0, config, iconRanges)

    smallfont = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/arialbd.ttf', 12.0, nil, glyph_ranges)
   	icon = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 12.0, config, iconRanges)

    brandfont = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/arialbd.ttf', 20.0, nil, glyph_ranges) -- brands font
	icon = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-brands-400.ttf', 28.0, config, iconRanges) --brands font

    image = imgui.CreateTextureFromFile(getWorkingDirectory() .. '/Screenshot_21.png')

	imgui.GetIO().IniFilename = nil
end)

--if not doesFileExist(directCFG .. "/" .. time.cfg) then



    --item = { maty = maty[0], narko = narko[0], money = money[0], premiy = premiy[0], nostalgiy = nostalgiy[0], moto = moto[0], yellowbox = yellowbox[0], redbox = redbox[0], bluebox = bluebox[0], platinaRuletka = platinaRuletka[0], goldRuletka = goldRuletka[0] }






local newFrame = imgui.OnFrame(
	function() return ahwindow[0] end, -- Указываем здесь данное условие, тем самым рендеря окно только в том случае, если его прозрачность больше нуля
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(425, 250), imgui.Cond.FirstUseEver)
        imgui.Begin("AirHelper v"..thisScript().version, ahwindow, imgui.WindowFlags.NoResize)
		imgui.DisableInput = false
        player.HideCursor = false
        imgui.SetCursorPos(imgui.ImVec2(5.000000,28.000000));
        imgui.BeginChild("child",imgui.ImVec2(130, 214), true)
        imgui.PushFont(mfont)
        imgui.SetCursorPos(imgui.ImVec2(1.000000,5.000000));
        if imgui.Button(fa.ICON_FA_HOME .. u8"Главная", imgui.ImVec2(122, 40)) then menu = 1 end
        imgui.SetCursorPos(imgui.ImVec2(1.000000,52.000000));
        if imgui.Button(fa.ICON_FA_COGS .. u8"Функции", imgui.ImVec2(122, 40)) then menu = 2 end
        imgui.SetCursorPos(imgui.ImVec2(1.000000,166.000000));
        if imgui.Button(fa.ICON_FA_INFO_CIRCLE .. u8"О скрипте", imgui.ImVec2(122, 40)) then menu = 3 end
        imgui.EndChild()
        if menu == 1 then
            imgui.SetCursorPos(imgui.ImVec2(140.000000,28.000000));
            imgui.BeginChild("##menu1",imgui.ImVec2(276, 214), true)
            imgui.PushFont(submainfont)
            imgui.SetCursorPosY(65)
            imgui.CenterTextColoredRGB('Приветствую вас!\nВы скачали скрипт AirHelper.\nПодробную информацию о скрипте\nможно посмотреть в "О скрипте"')
            imgui.EndChild()
        end
        if menu == 2 then
            imgui.SetCursorPos(imgui.ImVec2(140.000000,28.000000));
            imgui.BeginChild("##menu2",imgui.ImVec2(276, 214), true)
            imgui.SetCursorPos(imgui.ImVec2(10, 165))
            if imgui.Button(u8"Сохранить", imgui.ImVec2(120, 40)) then
                local item = {
                    date = date_,
                    time = time_,
                    list = list_,

                    maty = maty[0],
                    narko = narko[0],
                    money = money[0],
                    premiy = premiy[0],
                    nostalgiy = nostalgiy[0],
                    moto = moto[0],
                    yellowbox = yellowbox[0],
                    redbox = redbox[0],
                    bluebox = bluebox[0],
                    platinaRuletka = platinaRuletka[0],
                    goldRuletka = goldRuletka[0]
                }
                list_ = list_ + 28
                table.insert(aircfg.items, item)
                ecfg.save(CFG, aircfg)

                maty[0] = 0
                narko[0] = 0
                money[0] = 0
                premiy[0] = 0
                nostalgiy[0] = 0
                moto[0] = 0
                yellowbox[0] = 0
                redbox[0] = 0
                bluebox[0] = 0
                platinaRuletka[0] = 0
                goldRuletka[0] = 0
            end

            imgui.SetCursorPos(imgui.ImVec2(145, 165))
            if imgui.Button(u8"Сохранения", imgui.ImVec2(120, 40)) then
                menu = 4
            end

            imgui.EndChild()
        end

        if menu == 4 then
            imgui.SetCursorPos(imgui.ImVec2(140.000000,28.000000));
            imgui.BeginChild("##menu4",imgui.ImVec2(276, 214), true)
            if #aircfg.items > 0 then
                imgui.CenterTextColoredRGB("Меню сохранений")
                imgui.Separator()
                for index, item in ipairs(aircfg.items) do
                    imgui.SetCursorPosX(36)
                    if imgui.Button(u8(item.date.. " | " ..item.time), imgui.ImVec2(175, 25)) then
                        date = item.date
                        time = item.time
                        
                        money[0] = item.money
                        maty[0] = item.maty

                        imgui.OpenPopup("aaa")
                        --menu = "dateb"
                    end
                    imgui.SameLine()
                    imgui.PushFont(submainfont)
                    imgui.PushStyleVarVec2(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(5.5, 0.5))
                    if imgui.Button(fa.ICON_FA_TRASH..'##'..index, imgui.ImVec2(25, 25)) then
                        table.remove(aircfg.items, index)
                        ecfg.save(CFG, aircfg)
                    end
                    imgui.PopStyleVar(1)
                    imgui.PopFont()
                end
            else
                imgui.CenterTextColoredRGB("Меню сохранений")
                imgui.Separator()
                imgui.CenterTextColoredRGB("У вас пока что нет сохранений.")
            end

            if imgui.BeginPopupModal("aaa", false, imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar) then
                imgui.BeginChild("##E1ditBinder", imgui.ImVec2(250, 260), true)
                
                imgui.PushFont(bigfont)
                imgui.CenterTextColoredRGB(date .. " | ".. time)
                imgui.PopFont()
                imgui.Separator()
                imgui.PushFont(submainfont)
    
                imgui.TextColoredRGB("Материалы: " .. maty[0])
                imgui.TextColoredRGB("Наркотики: ".. narko[0])
                
                imgui.TextColoredRGB("Ларец с премией: ".. premiy[0])
                imgui.TextColoredRGB("Ностальгический ящик: ".. nostalgiy[0])
                imgui.TextColoredRGB("Супер мото-ящик: ".. moto[0])
                imgui.TextColoredRGB("Rare Box Yellow: ".. yellowbox[0])
                imgui.TextColoredRGB("Rare Box Blue: ".. bluebox[0])
                imgui.TextColoredRGB("Rare Box Red: ".. redbox[0])
                imgui.TextColoredRGB("Платиновая рулетка: "..platinaRuletka[0])
                imgui.TextColoredRGB("Золотая рулетка: "..goldRuletka[0])
                imgui.PopFont()
                imgui.Separator()
                imgui.PushFont(mainfont)
                imgui.SetCursorPos(imgui.ImVec2(8, 230));
                imgui.TextColoredRGB("Деньги: ".. money[0] .. "$")
                imgui.PopFont()
                
                imgui.EndChild()
                imgui.SetCursorPos(imgui.ImVec2(80, 275));
                if imgui.Button(u8"Закрыть", imgui.ImVec2(100,25)) then
                    maty[0] = 0
                    narko[0] = 0
                    money[0] = 0
                    premiy[0] = 0
                    nostalgiy[0] = 0
                    moto[0] = 0
                    yellowbox[0] = 0
                    redbox[0] = 0
                    bluebox[0] = 0
                    platinaRuletka[0] = 0
                    goldRuletka[0] = 0
                    imgui.CloseCurrentPopup()
                end
                imgui.EndPopup()
            end
                

            imgui.EndChild()
        end


        if menu == 3 then
            imgui.SetCursorPos(imgui.ImVec2(140.000000,23.000000));
            imgui.BeginChild("##menu3",imgui.ImVec2(276, 214), true)
            imgui.PushFont(mainfont)
            imgui.CenterTextColoredRGB("Чем же полезен AirHelper?") imgui.PopFont()
            imgui.PushFont(submainfont)
            imgui.TextColoredRGB("Этот скрипт помогает вам мониторить статистику каждого вашего АирДропа.")
            imgui.TextColoredRGB("Скрипт собирает всю информацию, кроме бронежилетов и улучшений оружия.")
            
            imgui.SetCursorPos(imgui.ImVec2(5.000000,150.500000));
            imgui.Separator()
				imgui.BeginChild("ideveloper",imgui.ImVec2(265, 49), false)
                
                imgui.PushFont(submainfont)
				imgui.CenterTextColoredRGB("Разработчик: CH4PPLE")
				primer_text = {'https://vk.com/chapple', 'https://t.me/CH4PPLE'}
                imgui.PopFont()

                imgui.PushFont(brandfont)
                imgui.SetCursorPos(imgui.ImVec2(95.0,28.0));
                imgui.Link("https://vk.com/chapple", fa_icon.ICON_FA_VK)
				imgui.SetCursorPos(imgui.ImVec2(93.0,26.0));
				imgui.TextQuestion("     ", u8"Нажмите, чтобы перейти в ВК")

				imgui.SetCursorPos(imgui.ImVec2(145.0,28.0));
                imgui.Link("https://t.me/CH4PPLE", fa_icon.ICON_FA_TELEGRAM_PLANE)
				imgui.SetCursorPos(imgui.ImVec2(143.0,26.0));
				imgui.TextQuestion("     ", u8"Нажмите, чтобы перейти в ТГ")
                imgui.EndChild()
            imgui.EndChild()
        end


		imgui.End()
	end
)

local secondFrame = imgui.OnFrame(
	function() return infowindow[0] end, -- Указываем здесь данное условие, тем самым рендеря окно только в том случае, если его прозрачность больше нуля
    function(player)
        player.HideCursor = true
        invent = sampTextdrawIsExists(inv)
        if not isPauseMenuActive() and invent == false then
            imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 1.08, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
            imgui.SetNextWindowSize(imgui.ImVec2(265, 256), imgui.Cond.FirstUseEver)
            imgui.Begin(" ", infowindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
            imgui.PushFont(bigfont)
            imgui.CenterTextColoredRGB("AirDrop | Item Informer")
            imgui.PopFont()
            imgui.Separator()
            imgui.PushFont(submainfont)

            imgui.TextColoredRGB("Материалы: " .. maty[0])
            imgui.TextColoredRGB("Наркотики: ".. narko[0])
            
            imgui.TextColoredRGB("Ларец с премией: ".. premiy[0])
            imgui.TextColoredRGB("Ностальгический ящик: ".. nostalgiy[0])
            imgui.TextColoredRGB("Супер мото-ящик: ".. moto[0])
            imgui.TextColoredRGB("Rare Box Yellow: ".. yellowbox[0])
            imgui.TextColoredRGB("Rare Box Blue: ".. bluebox[0])
            imgui.TextColoredRGB("Rare Box Red: ".. redbox[0])
            imgui.TextColoredRGB("Платиновая рулетка: "..platinaRuletka[0])
            imgui.TextColoredRGB("Золотая рулетка: "..goldRuletka[0])
            imgui.PopFont()
            imgui.Separator()
            imgui.PushFont(mainfont)
            imgui.SetCursorPos(imgui.ImVec2(10, 230));
            imgui.TextColoredRGB("Деньги: ".. money[0] .. "$")
            imgui.PopFont()

            imgui.End()
        end
	end
)

local updateFrame = imgui.OnFrame(
	function() return updatewindow[0] end,
	function(player)
	if not isPauseMenuActive() then
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(258, 150), imgui.Cond.FirstUseEver)
        imgui.Begin("UpdateWindow", updatewindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
		imgui.DisableInput = false
		imgui.PushFont(smallfont)
		imgui.CenterTextColoredRGB('Обновление AirHelper!')
		imgui.Separator()
		imgui.PopFont()
		imgui.CenterTextColoredRGB('Вышло новое обновление для AirHelper.')
		imgui.CenterTextColoredRGB('Хотите ли вы обновить скрипт?')
		imgui.PushStyleVarVec2(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
		imgui.SetCursorPos(imgui.ImVec2(((imgui.GetWindowWidth() + imgui.GetStyle().ItemSpacing.x) / 6), 100))
		imgui.PushFont(mainfont)
		if imgui.Button(u8"Да", imgui.ImVec2(80, 35)) then updatewindow[0] = false update():download() end
		imgui.SetCursorPos(imgui.ImVec2(((imgui.GetWindowWidth() + imgui.GetStyle().ItemSpacing.x) / 6) + 88, 100))
		if imgui.Button(u8"Нет", imgui.ImVec2(80, 35)) then updatewindow[0] = false end
		imgui.PopFont()
		imgui.PopStyleVar()
		
		imgui.End()
	end
end
)

function main() 
    while not isSampAvailable() do
        wait(100)
    end

    local lastver = update():getLastVersion()
    local request = requests.get('https://raw.githubusercontent.com/chapple01/AirHelper/main/Nicks.txt?token=GHSAT0AAAAAABWORMTT5Z4TQEYCBFKTYZ5OYZHKZHA')
    local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
    local function res()
        for n in request.text:gmatch('[^\r\n]+') do
            if nick:find(n) then return true end
        end
        return false
    end
    if not res() then sampAddChatMessage(tag.."Скрипт не куплен.", 0x00FF7F) thisScript():unload() else sampAddChatMessage(tag..'Скрипт запущен. Версия: '..lastver..'. Активация: /airh', 0x00FF7F) end

    if thisScript().version ~= lastver then
        sampAddChatMessage(tag..'Вышло обновление скрипта ('..thisScript().version..' -> '..lastver..')!', 0x00FF7F)
		updatewindow[0] = true
    end
    
    sampRegisterChatCommand("airh", function()
		ahwindow[0] = not ahwindow[0]
        menu = 1
	end)
    sampRegisterChatCommand("airi", function()
		infowindow[0] = not infowindow[0]
	end)
    sampRegisterChatCommand("+++", function()
		money[0] = money[0] + 500000
        maty[0] = maty[0] + 300
	end)
    sampRegisterChatCommand("resett", function()
        maty[0] = 0
        narko[0] = 0
        money[0] = 0
        premiy[0] = 0
        nostalgiy[0] = 0
        moto[0] = 0
        yellowbox[0] = 0
        redbox[0] = 0
        bluebox[0] = 0
        platinaRuletka[0] = 0
        goldRuletka[0] = 0
    end)

    while true do
		wait(0)
        date_ = os.date("%d.%m.%Y")
        time_ = os.date('%H:%M:%S')
    end
end

function update()
    local raw = 'https://raw.githubusercontent.com/chapple01/AirHelper/main/version.json?token=GHSAT0AAAAAABWORMTSLWWULWM76JQMW3YSYZHKTUQ'
    local dlstatus = require('moonloader').download_status
    local requests = require('requests')
    local f = {}
    function f:getLastVersion()
        local response = requests.get(raw)
        if response.status_code == 200 then
            return decodeJson(response.text)['last']
        else
            return 'UNKNOWN'
        end
    end
    function f:download()
        local response = requests.get(raw)
        if response.status_code == 200 then
            downloadUrlToFile(decodeJson(response.text)['updateurl'], thisScript().path, function (id, status, p1, p2)
				if status == 57 then
					sampAddChatMessage(tag..'Начинаю загрузку скрипта...', 0x00FF7F)
				end
                if status == dlstatus.STATUSEX_ENDDOWNLOAD then
                    sampAddChatMessage(tag..'Скрипт обновлен, перезагрузка...', 0x00FF7F)
                end
            end)
        else
            sampAddChatMessage(tag..'Ошибка, невозможно установить обновление, код ошибки: '..response.status_code, 0x00FF7F)
        end
    end
    return f
end

function files_add()
	if not doesDirectoryExist("moonloader\\config\\AirHelper\\AirDropsLoot") then createDirectory("moonloader\\config\\AirHelper\\AirDropsLoot") end
end

function sampev.onServerMessage(color, text)
    --[[if text:find("%[Информация%] %{FFFFFF%}Вы подобрали предмет (.+). Чтобы открыть инвентарь используйте клавишу 'Y' или /invent") then
		item = text:match("Вы подобрали предмет '(.*)'.+. Чтобы открыть инвентарь используйте клавишу 'Y' или /invent")
        count = text:match("(%d+)")
		print(item)
        --[Информация] {FFFFFF}Вы подобрали предмет 'Тушка оленя' (1 шт). Чтобы открыть инвентарь используйте клавишу 'Y' или /invent
        print(count)
        oleni[0] = oleni[0] + count
        print(oleni[0])
	end]]
    if text:find("%[Информация%] %{FFFFFF%}Вы успешно взяли .* с ящика контрабанды!") then
        items, counts = text:match("%[Информация%].-Вы успешно взяли (.+) %((%d+) шт%) с ящика контрабанды!")
        item = text:match("%[Информация%] %{FFFFFF%}Вы успешно взяли (.*) с ящика контрабанды!")
        moneys = text:match("(%d+)")
        moneyss = tonumber(moneys)
        if items == "Материалы" then
            counts = tonumber(counts)
            maty[0] = maty[0] + counts
            print(maty[0])
        end
        if item == "Материалы" then
            maty[0] = maty[0] + 1
            print(maty[0])
        end

        if items == "Наркотики" then
            if counts == nil then
                narko[0] = narko[0] + 1
            else
                counts = tonumber(counts)
                narko[0] = narko[0] + counts
            end
            print(narko[0])
        end
        if item == "Наркотики" then
            narko[0] = narko[0] + 1
            print(narko[0])
        end

        if item == "Ларец с премией" then
            premiy[0] = premiy[0] + 1
            print(premiy[0])
        end
        if item == "Ностальгический ящик" then
            nostalgiy[0] = nostalgiy[0] + 1
            print(nostalgiy[0])
        end
        if item == "Супер мото-ящик" then
            moto[0] = moto[0] + 1
            print(moto[0])
        end
        if item == "Rare Box Yellow" then
            yellowbox[0] = yellowbox[0] + 1
            print(yellowbox[0])
        end
        if item == "Rare Box Blue" then
            bluebox[0] = bluebox[0] + 1
            print(bluebox[0])
        end
        if item == "Rare Box Red" then
            redbox[0] = redbox[0] + 1
            print(redbox[0])
        end
        


        if item == "Золотая рулетка" then
            goldRuletka[0] = goldRuletka[0] + 1
            print(goldRuletka[0])
        end
        if item == "Платиновая рулетка" then
            platinaRuletka[0] = platinaRuletka[0] + 1
            print(platinaRuletka[0])
        end
        if moneys == "500000" then
            money[0] = money[0] + 500000
        end
    end
    --[[if text:find(".+") then
        dobavlen = text:match("Вам был добавлен предмет '(.*)'. Чтобы открыть инвентарь используйте клавишу 'Y' или /invent")
        print(dobavlen)
        if dobavlen == "Наркотики" then
            narko[0] = narko[0] + 1
        end
    end]]
end

function sampev.onShowTextDraw(id, data)
	if data.text == "…H‹EHЏAP’" or data.text == "INVENTORY" then
		inv = id
	end
end

function imgui.Link(link,name,myfunc)
    myfunc = type(name) == 'boolean' and name or myfunc or false
    name = type(name) == 'string' and name or type(name) == 'boolean' and link or link
    local size = imgui.CalcTextSize(name)
    local p = imgui.GetCursorScreenPos()
    local p2 = imgui.GetCursorPos()
    local resultBtn = imgui.InvisibleButton('##'..link..name, size)
    if resultBtn then
        if not myfunc then
            os.execute('explorer '..link)
        end
    end
    imgui.SetCursorPos(p2)
    if imgui.IsItemHovered() then
        imgui.TextColored(imgui.ImVec4(0, 0.5, 1, 1), name)
        --imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y + size.y), imgui.ImVec2(p.x + size.x, p.y + size.y), imgui.GetColorU32Vec4(imgui.ImVec4(0, 0.5, 1, 1)))
    else
        imgui.TextColored(imgui.ImVec4(0, 0.4, 1, 1), name)
    end
    return resultBtn
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImVec4(r/255, g/255, b/255, a/255)
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.TextWrapped(u8(w)) end
        end
    end

    render_text(text)
end

function imgui.CenterTextColoredRGB(text)
	local width = imgui.GetWindowWidth()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local ImVec4 = imgui.ImVec4

	local explode_argb = function(argb)
	local a = bit.band(bit.rshift(argb, 24), 0xFF)
	local r = bit.band(bit.rshift(argb, 16), 0xFF)
	local g = bit.band(bit.rshift(argb, 8), 0xFF)
	local b = bit.band(argb, 0xFF)
	return a, r, g, b
	end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImVec4(r/255, g/255, b/255, a/255)
    end

	local render_text = function(text_)
	for w in text_:gmatch('[^\r\n]+') do
	local textsize = w:gsub('{.-}', '')
	local text_width = imgui.CalcTextSize(u8(textsize))
	imgui.SetCursorPosX( width / 2 - text_width .x / 2 )
	local text, colors_, m = {}, {}, 1
	w = w:gsub('{(......)}', '{%1FF}')
	while w:find('{........}') do
	local n, k = w:find('{........}')
	local color = getcolor(w:sub(n + 1, k - 1))
	if color then
	text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
	colors_[#colors_ + 1] = color
	m = n
	end
	w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
	end
	if text[0] then
	for i = 0, #text do
	imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
	imgui.SameLine(nil, 0)
	end
	imgui.NewLine()
	else
	imgui.Text(u8(w))
	end
	end
	end
	render_text(text)
end

function imgui.TextQuestion(label, description)
    imgui.TextDisabled(label)

    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
            imgui.PushTextWrapPos(600)
                imgui.TextUnformatted(description)
            imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function DarkTheme() --https://www.blast.hk/threads/25442/post-973165
    imgui.SwitchContext()

    imgui.GetStyle().WindowPadding = imgui.ImVec2(8, 8)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5, 3)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 4)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(4, 4)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 21
    imgui.GetStyle().ScrollbarSize = 10
    imgui.GetStyle().GrabMinSize = 8

    imgui.GetStyle().WindowBorderSize = 1
    imgui.GetStyle().ChildBorderSize = 1
    imgui.GetStyle().PopupBorderSize = 1
    imgui.GetStyle().FrameBorderSize = 1
    imgui.GetStyle().TabBorderSize = 1

    imgui.GetStyle().WindowRounding = 5
    imgui.GetStyle().ChildRounding = 5
    imgui.GetStyle().FrameRounding = 5
    imgui.GetStyle().PopupRounding = 5
    imgui.GetStyle().ScrollbarRounding = 5
    imgui.GetStyle().GrabRounding = 5
    imgui.GetStyle().TabRounding = 5

    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)

    imgui.GetStyle().Colors[imgui.Col.Text]                   = imgui.ImVec4(0.90, 0.90, 0.90, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
    imgui.GetStyle().Colors[imgui.Col.WindowBg]               = imgui.ImVec4(0.08, 0.08, 0.08, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ChildBg]                = imgui.ImVec4(0.10, 0.10, 0.10, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PopupBg]                = imgui.ImVec4(0.08, 0.08, 0.08, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Border]                 = imgui.ImVec4(0.70, 0.70, 0.70, 0.40)
    imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBg]                = imgui.ImVec4(0.15, 0.15, 0.15, 1.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = imgui.ImVec4(0.19, 0.19, 0.19, 0.71)
    imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = imgui.ImVec4(0.34, 0.34, 0.34, 0.79)
    imgui.GetStyle().Colors[imgui.Col.TitleBg]                = imgui.ImVec4(0.00, 0.69, 0.33, 0.80)
    imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = imgui.ImVec4(0.00, 0.74, 0.36, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = imgui.ImVec4(0.00, 0.69, 0.33, 0.50)
    imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = imgui.ImVec4(0.00, 0.80, 0.38, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = imgui.ImVec4(0.16, 0.16, 0.16, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = imgui.ImVec4(0.00, 0.69, 0.33, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = imgui.ImVec4(0.00, 0.82, 0.39, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = imgui.ImVec4(0.00, 1.00, 0.48, 1.00)	
    imgui.GetStyle().Colors[imgui.Col.CheckMark]              = imgui.ImVec4(0.00, 0.69, 0.33, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = imgui.ImVec4(0.00, 0.69, 0.33, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = imgui.ImVec4(0.00, 0.77, 0.37, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Button]                 = imgui.ImVec4(0.00, 0.69, 0.33, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = imgui.ImVec4(0.00, 0.82, 0.39, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = imgui.ImVec4(0.00, 0.87, 0.42, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Header]                 = imgui.ImVec4(0.00, 0.69, 0.33, 1.00)
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = imgui.ImVec4(0.00, 0.76, 0.37, 0.57)
    imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = imgui.ImVec4(0.00, 0.88, 0.42, 0.89)
    imgui.GetStyle().Colors[imgui.Col.Separator]              = imgui.ImVec4(1.00, 1.00, 1.00, 0.40)
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = imgui.ImVec4(1.00, 1.00, 1.00, 0.60)
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = imgui.ImVec4(1.00, 1.00, 1.00, 0.80)
    imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = imgui.ImVec4(0.00, 0.69, 0.33, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = imgui.ImVec4(0.00, 0.76, 0.37, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = imgui.ImVec4(0.00, 0.86, 0.41, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Tab]                    = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabHovered]             = imgui.ImVec4(0.28, 0.28, 0.28, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabActive]              = imgui.ImVec4(0.30, 0.30, 0.30, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = imgui.ImVec4(0.07, 0.10, 0.15, 0.97)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = imgui.ImVec4(0.14, 0.26, 0.42, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotLines]              = imgui.ImVec4(0.00, 0.69, 0.33, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = imgui.ImVec4(0.00, 0.74, 0.36, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = imgui.ImVec4(0.00, 0.69, 0.33, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = imgui.ImVec4(0.00, 0.80, 0.38, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = imgui.ImVec4(0.00, 0.69, 0.33, 0.72)
    imgui.GetStyle().Colors[imgui.Col.DragDropTarget]         = imgui.ImVec4(1.00, 1.00, 0.00, 0.90)
    imgui.GetStyle().Colors[imgui.Col.NavHighlight]           = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight]  = imgui.ImVec4(1.00, 1.00, 1.00, 0.70)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg]      = imgui.ImVec4(0.80, 0.80, 0.80, 0.20)
    imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg]       = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
end
