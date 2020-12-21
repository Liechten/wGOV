script_name("N.G.S.A Helper")
script_description("/ngsa - Information")
script_version("0.3")
script_author("Wayne Rothschild and Englebert Rothschild")
require "lib.moonloader"
requests = require('requests')
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local memory = require "memory" -- подключение для очистки чата
local sampevcheck, sampev = pcall(require, "lib.samp.events") -- подключение для разделения денег

local textdialog = "{336633}________________________________________________________________________________\n\n{FFFFFF}- {336633}Очистка чата: {FFFFFF}[ /cclear ].\n{FFFFFF}- {336633}Постоянный поиск: {FFFFFF}[ /fd ].\n{FFFFFF}- {336633}Калькулятор: {FFFFFF}[ /calc ].\n{FFFFFF}- {336633}Объявление в гос. новости: {FFFFFF}[ /gos ].\n{FFFFFF}- {336633}Объявление в чат рации: {FFFFFF}[ /racia ].\n{FFFFFF}- {336633}Объявление в чат рации: {FFFFFF}[ /vr ].\n{FFFFFF}- {336633}Проверка при призыве: {FFFFFF}[ /pr ].\n{FFFFFF}- {336633}Правила чата использования департамента: {FFFFFF}[ /dpravila ].\n{FFFFFF}- {336633}Список лидеров: {FFFFFF}[ /ld ].\n{FFFFFF}- {336633}Список заместителей: {FFFFFF}[ /zm ].\n{FFFFFF}- {336633}Список администраторов: {FFFFFF}[ /adm ].\n{FFFFFF}- {336633}Информация о обновлениях скрипта: {FFFFFF}[ /updates ]\n{FFFFFF}- {336633}Взять транспорт фракции: {FFFFFF}[ /ag ].\n{FFFFFF}- {336633}Починить транспорт фракции: {FFFFFF}[ /th ].\n{FFFFFF}- {336633}Надеть бронежилет: {FFFFFF}[ /us ].\n{FFFFFF}- {336633}Правила подачи государственной волны: {FFFFFF}[ /govpravila ].\n{FFFFFF}- {336633}Правила выдачи ранга: {FFFFFF}[ /pravilarank ]\n{FFFFFF}- {336633}Надеть фуражку и форму В.В.С / или снять: {FFFFFF}[ /forma ].\n{FFFFFF}- {336633}Лекционный раздел: {FFFFFF}[ /lec ].\n{FFFFFF}- {336633}Авторы скрипта: {FFFFFF}[ /authors ].\n{FFFFFF}- {336633}МГ чат рации: {FFFFFF}[ /rb ].\n{FFFFFF}- {336633}МГ чат рации: {FFFFFF}[ /vb ].\n{FFFFFF}- {336633}МГ чат департамента: {FFFFFF}[ /db ].\n{FFFFFF}- {336633}Надеть каску: {FFFFFF}[ /uh ].\n{FFFFFF}- {336633}Иду на посадку: | /v {FFFFFF}[ /pos ].\n{FFFFFF}- {336633}Взлетаю: | /v {FFFFFF}[ /vzl ].\n{FFFFFF}- {336633}Посмотреть количество звезд: {FFFFFF}[ /wd ].\n{FFFFFF}- {336633}Кинуть шипы: {FFFFFF}[ /sh ].\n{FFFFFF}- {336633}Быстрый PURSUIT: {FFFFFF}[ /pu ].\n{FFFFFF}- {336633}Участники организации в сети: {FFFFFF}[ /mb ].\n{FFFFFF}- {336633}Лидерское меню: {FFFFFF}[ /lm ].\n{FFFFFF}- {336633}Меню зачистки: {FFFFFF}[ /zz ].\n{FFFFFF}- {336633}Система проведения 'Зачисток': {FFFFFF}[ /zzinfo ].\n{FFFFFF}- {336633}Узнать Имя игрока: {FFFFFF}[ /iid ].\n{FFFFFF}- {336633}Быстрое снятие розыска: {FFFFFF}[ /cl ID ].\n{FFFFFF}- {336633}Меню выдачи заданий: {FFFFFF}[ /zadan ].\n\n{336633}________________________________________________________________________________"
local praviladepartamenta = "{336633}________________________________________________________________________________\n\n{FFFFFF}[ 1 ]{336633} Запрещено свободное общение в OOC с {FFFFFF}7:00 {336633}до {FFFFFF}22:00{336633}\n{FFFFFF}[ 2 ]{336633} Запрещены объявления о покупке/продаже имущества.\n{FFFFFF}[ 3 ]{336633} Запрещены оскорбления в сторону сотрудников департамента.\n{FFFFFF}[ 4 ]{336633} Запрещено употребление ненармотивной лексики. {FFFFFF}[ Мат/MG ]{336633}\n{FFFFFF}[ 5 ]{336633} Запрещены OOC приветствия.\n{FFFFFF}[ 6 ]{336633} Запрещёно использовать рацию департамента {FFFFFF}первым{336633} должностям в гос.структурах.\n{FFFFFF}| Исключение {336633}при вынужденных мерах: {FFFFFF}ЧП{336633}, {FFFFFF}Глобальных РП ситуациях {336633}\n{FFFFFF}[ 7 ]{336633} Запрещёно снимать мут, если он был выдан по правилам, даже если человек извинился или по амнистии.\n{FFFFFF}[ 8 ]{336633} Запрещён намеренный откат.\n{FFFFFF}[ 9 ]{336633} Запрещено общение не в рабочей стилистике\n                            {FFFFFF}За нарушение правил рации Департамента сотрудник понесёт наказание в виде:\n{FFFFFF}[ 1 ]{336633} Нарушение первого и девятого пункта - {FFFFFF}Блокирование Рации на 20 минут.\n{FFFFFF}[ 2 ]{336633} Объявления о покупке/продаже имущества - {FFFFFF}Блокирование Рации на 30 минут.\n{FFFFFF}[ 3 ]{336633} Оскорбления в сторону сотрудников департамента - {FFFFFF}Блокирование Рации на 30 минут.\n{FFFFFF}[ 4 ]{336633} Употребление ненармотивной лексики - {FFFFFF}Блокирование Рации на 20 минут.\n{FFFFFF}[ 5 ]{336633} OOC приветствия - {FFFFFF}Блокирование Рации на 20 минут.\n{FFFFFF}[ 6 ]{336633} Использовать рации департамента первым должностям в гос.структурах - {FFFFFF}Блокирование Рации на 30 минут.\n{FFFFFF}[ 7 ]{336633} Намеренный откат в свою пользу - {FFFFFF}Блокирование Рации на 30 минут.\n{FFFFFF}[ 8 ]{336633} Нарушение субординации - {FFFFFF}Блокирование Рации на 20 минут.\n{FFFFFF}[ 9 ]{336633} Нарушение УДО - {FFFFFF}Блокирование Рации на 30 минут."
local pravilagosvolny2 = "{336633}________________________________________________________________________________\n\n{FFFFFF}[ 1 ]{336633} Интервал между подачей гос.волны - {FFFFFF}10 минут\n{FFFFFF}[ 2 ]{336633} Интервал подачи гос.волны (повторно с той же фракции) - {FFFFFF}20 минут\n{FFFFFF}[ 3 ]{336633} Интервал занятия гос.волны (повторно с той же фракции)- {FFFFFF}5 минут\n{FFFFFF}[ 4 ]{336633} Гос.новости о проведении зачисток подаются вне очереди.\n{FFFFFF}[ 5 ]{336633} Максимальное количество строчек {FFFFFF}[/gov ] {336633}- {FFFFFF}2.\n{FFFFFF}[ 6 ]{336633} Вам нужно спросить свободна ли волна на то время,которую вы хотите занять\n{FFFFFF}[ 7 ]{336633} Вам следует заранее занимать гос.волну дабы избежать конфликта.\n{FFFFFF}[ 8 ]{336633} Обязательно нужно сообщать об окончании набора.\n{FFFFFF}[ 9 ]{336633} Как только Вы заняли гос.волну,вам нужно отправить оповещение о том,что проходит набор в вашу организацию.\n{FFFFFF}[ 10 ]{336633} После того,как Вы отправили оповещение,введите команду /lmenu и выберет пункт '{1ee01c}Набор [ОТКРЫТ]{336633} '\n{FFFFFF}[ 11 ]{336633} Во время проведение набора оставляйте пункт в /lmenu '{1ee01c}НАБОР{336633}' открытым\n{FFFFFF}[ 12 ]{336633}  После окончания набора,введи команду /lmenu и выберете вновь пункт 'НАБОР' и должно быть написано '{ff1100}Набор [ЗАКРЫТ]{336633}'\n{FFFFFF}[ 13 ]{336633} Сообщите в гос.волну о том,что вы закончили набор в вашу организацию.\n"
local pravilarank1 = "{336633}________________________________________________________________________________\n\n{FFFFFF}[ 1 ]{336633} Отныне повышение с {FFFFFF}1 {336633}на {FFFFFF}2 {336633}проходит через одни сутки после инвайта во фракцию ( день стажировки )\n{FFFFFF}[ 2 ]{336633}Повышение со {FFFFFF}2 {336633}на {FFFFFF}3 {336633}разрешается через двое суток после получения второго звания\n{FFFFFF}[ 3 ]{336633}Повышение с {FFFFFF}3 {336633}на {FFFFFF}5 {336633}разрешается через четверо суток после получения последнего звания звания или на собрании [ {FFFFFF}только для данных фракций : NGSA , PD {336633}]\n{FFFFFF}[ 4 ]{336633} Повышение для {FFFFFF}6 {336633}рангов и выше происходит только на собрании\n"
local obnovleniascripta1 = "{336633}________________________________________________________________________________\n\n{FFFFFF}[ 1 ]{336633} Релиз 0.1 версии скрипта: {FFFFFF}[ 18.07.2020 ].\n{FFFFFF}[ 2 ]{336633} Релиз 0.2 версии скрипта: {FFFFFF}[ 26.07.2020 ].\n{336633}________________________________________________________________________________"
local authors1 = "{336633}________________________________________________________________________________\n\n{FFFFFF}- {336633}Wayne Rothschild\n{FFFFFF}| {336633}vk.com/avdeenkoo10\n{FFFFFF}- {336633}Englebert Rothschild\n{FFFFFF}| {336633}vk.com/enyag\n{FFFFFF}- {336633}Lucifer Rothschild\n{FFFFFF}| {336633}vk.com/xrubons\n{FFFFFF}- {336633}Bernard Rothschild\n{FFFFFF}| {336633}vk.com/pluha28003\n{FFFFFF}\n{336633}________________________________________________________________________________"
local zzachistkaa2 = "{336633}________________________________________________________________________________\n\n{FFFFFF}- {336633}Общие правила:\n {FFFFFF}| {336633}Организатор должен объявить о зачистке перед тем, как все участвующие сотрудники будут возле зачищаемой организации.\n {FFFFFF}| {336633}Перед тем, как провести зачистку, организатор должен связаться с Лидерами тех фракций, которые будут участвовать.\n {FFFFFF}| {336633}Перед тем, как провести зачистку, организатор должен собрать всех.\n {FFFFFF}| {336633}Зачистку проводят: Генерал N.G.S.A, Генерал В.В.С, Адмирал В.М.С, Генерал С.В.\n {FFFFFF}| {336633}Все сотрудники, участвующие в зачистке, подчиняются организатору.\n {FFFFFF}| {336633}В зачистке могут участвовать все сотрудники ПО: S.W.A.T, N.G.S.A, L.S.P.D, F.B.I.\n {FFFFFF}| {336633}Члены зачищаемой организации, должны быть посажены в карцер.\n {FFFFFF}| {336633}Название зачищаемой организации не оглашается до объявления и приказа в государственные новости.\n {FFFFFF}| {336633}Во время зачистки, членам зачищаемой организации, выдается 6 уровень розыска по статье: 'z' = 'Зачистка'\n{FFFFFF}- {336633}Запреты во время зачистки:\n {FFFFFF}| {336633}Запрещено игнорировать команды организатора зачистки.\n{FFFFFF} | {336633}Запрещено расспрашивать организатора о любых подробностях проведения зачистки.\n{FFFFFF} | {336633}Запрещено обсуждение зачистки в рацию департамента во время ее проведения.\n{FFFFFF} | {336633}На зачистке не могут присутствовать: Мин. Здрав, Правительство, засекреченные агенты F.B.I.\n{FFFFFF}- {336633}Причины проведения зачисток:\n{FFFFFF} | {336633}Вооруженное нападение на базу организации в составе 2+ человек.\n{FFFFFF} | {336633}Убийство или нападение на высокопоставленных лиц.\n{FFFFFF} | {336633}Захват в заложники одного или группы лиц в составе 2+ человек.\n{FFFFFF} | {336633}Похищение высокопоставленных лиц в составе 2+ человек.\n{FFFFFF} | {336633}Организация теракта.\n{FFFFFF} | {336633}Захват здания гос. организации в составе 2+ человек.\n{FFFFFF} | {336633}Срыв собеседование в гос. организацию в составе 2+ человек.\n{FFFFFF} | {336633}Проникновение на закрытую территорию с целью: Кражи, воровства боеприпасов или убийства в составе 2+ человек.\n{FFFFFF}- {336633}Список организаций, которые можно зачищать:\n{FFFFFF} | {336633}Yakuza Mafia.\n{FFFFFF} | {336633}Russian Mafia.\n{FFFFFF} | {336633}Arabian Mafia.\n{FFFFFF} | {336633}Triada Mafia.\n{FFFFFF} | {336633}Cosa Nostra.\n{FFFFFF} | {336633}Баскетбольный клуб Groove Street.\n{FFFFFF} | {336633}Баскетбольный клуб Ballas.\n{FFFFFF} | {336633}Баскетбольный клуб Vagos.\n{FFFFFF} | {336633}Баскетбольный клуб Los Aztecas.\n\n{336633}________________________________________________________________________________\n"

local city = {
    [0] = "Village",
    [1] = "Los-Santos",
    [2] = "San-Fierro",
    [3] = "Las-Venturas"
}

local sampev = require 'lib.samp.events'
local active = true
local mem = require 'memory'
local main_color = 0xFFFFFF
local tag = "{FFD700}[INFOBAR]:"
local keys = require 'vkeys'
local tables
local imgui = require 'imgui'
local encoding = require 'encoding'

encoding.default = 'CP1251'
u8 = encoding.UTF8

local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)

function main()
	wait(100)
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
	imgui.ShowCursor = false
	imgui.SetMouseCursor(-1)
	
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}*{336633}Доброго времени суток, пользователь {FFFFFF}N.G.S.A Helper. {336633}Версия скрипта: {FFFFFF}0.3*", 0x336633)
    sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}*{336633}National Guard of San Andreas | {FFFFFF}Pears Project. {336633}Подробнее о скрипте: {FFFFFF}/ngsa*", 0x336633)

    sampRegisterChatCommand("ngsa", ngsa)
	sampRegisterChatCommand("dpravila", dpravila)
    sampRegisterChatCommand("cclear", cclear)
	sampRegisterChatCommand("ag", ag)
	sampRegisterChatCommand("th", th)
	sampRegisterChatCommand("govpravila", govpravila)
	sampRegisterChatCommand("pravilarank", pravilarank)
	sampRegisterChatCommand("forma", formavvs)
	sampRegisterChatCommand("pr", pr)
	sampRegisterChatCommand("racia", racia)
	sampRegisterChatCommand("gos", government)
	sampRegisterChatCommand("lec", lektcii)
	sampRegisterChatCommand("fd", postfind)
	sampRegisterChatCommand("us", usearm)
	sampRegisterChatCommand("ld", leaders)
	sampRegisterChatCommand("adm", admins)
	sampRegisterChatCommand("updates", updates)
	sampRegisterChatCommand("calc", calc)
	sampRegisterChatCommand("zm", zams)
	sampRegisterChatCommand("authors", authors)
	sampRegisterChatCommand("rb", rb)
	sampRegisterChatCommand("db", db)
	sampRegisterChatCommand("departament", departament1)
	sampRegisterChatCommand("uh", usehelm)
	sampRegisterChatCommand("pos", posadka)
	sampRegisterChatCommand("vzl", vzlet)
	sampRegisterChatCommand("wd", checkwanted)
	sampRegisterChatCommand("pud", pudostoverenie)
	sampRegisterChatCommand("sh", kinytshipi)
	sampRegisterChatCommand("pu", postoyanniypursuit)
	sampRegisterChatCommand("vr", vracia1)
	sampRegisterChatCommand("vb", vb)
	sampRegisterChatCommand("mb", members)
	sampRegisterChatCommand("lm", lmenu) 
	sampRegisterChatCommand("zz", zzachistka1) 
	sampRegisterChatCommand("zzinfo", zzachistka2) 
	sampRegisterChatCommand("iid", nickid) 
	sampRegisterChatCommand("cl", snyatierozyska)
	sampRegisterChatCommand("zadan", vidachazadaniy) 

    while true do 
	wait(10000)
		if main_window_state.v == false then 
		imgui.Process = true
		imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4

	colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled] = ImVec4(0.60, 0.60, 0.60, 1.00)
	colors[clr.WindowBg] = ImVec4(0.11, 0.10, 0.11, 1.00)
	colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.PopupBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.Border] = ImVec4(0.86, 0.86, 0.86, 1.00)
	colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.FrameBg] = ImVec4(0.21, 0.20, 0.21, 0.60)
	colors[clr.FrameBgHovered] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.FrameBgActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.TitleBg] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.TitleBgActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.MenuBarBg] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.ScrollbarBg] = ImVec4(0.00, 0.46, 0.65, 0.00)
	colors[clr.ScrollbarGrab] = ImVec4(0.00, 0.46, 0.65, 0.44)
	colors[clr.ScrollbarGrabHovered] = ImVec4(0.00, 0.46, 0.65, 0.74)
	colors[clr.ScrollbarGrabActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.ComboBg] = ImVec4(0.15, 0.14, 0.15, 1.00)
	colors[clr.CheckMark] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.SliderGrab] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.SliderGrabActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.Button] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.ButtonHovered] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.ButtonActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.Header] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.HeaderHovered] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.HeaderActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.ResizeGrip] = ImVec4(1.00, 1.00, 1.00, 0.30)
	colors[clr.ResizeGripHovered] = ImVec4(1.00, 1.00, 1.00, 0.60)
	colors[clr.ResizeGripActive] = ImVec4(1.00, 1.00, 1.00, 0.90)
	colors[clr.CloseButton] = ImVec4(1.00, 0.10, 0.24, 0.00)
	colors[clr.CloseButtonHovered] = ImVec4(0.00, 0.10, 0.24, 0.00)
	colors[clr.CloseButtonActive] = ImVec4(1.00, 0.10, 0.24, 0.00)
	colors[clr.PlotLines] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.PlotLinesHovered] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.PlotHistogram] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.PlotHistogramHovered] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.TextSelectedBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.ModalWindowDarkening] = ImVec4(0.00, 0.00, 0.00, 0.00)
		end
	end
end

function snyatierozyska(param)
  local id = string.match(param, '%s*(.+)')
  if id ~= nil then
    sampSendChat(string.format("/clear %s Ошибка", id))
  else
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Снятие розыска {336633}[/cl ID ]", 0x336633)
  end
end

function cmd_imgui(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v or show_2_window.v
end

function lmenu()
	lua_thread.create(function()
    sampSendChat("/lmenu")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Я открыл {336633}лидерское меню.", 0x336633)
	end)
end

function members()
	lua_thread.create(function()
    sampSendChat("/members")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Я открыл {336633}список участников организации ", 0x336633)
	end)
end

function posadka()
	lua_thread.create(function()
    sampSendChat("/v Иду на посадку!")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Я доложил о {336633}посадке", 0x336633)
	end)
end

function vzlet()
	lua_thread.create(function()
    sampSendChat("/v Взлетаю!")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Я доложил о {336633}взлете", 0x336633)
	end)
end

function usehelm()
    lua_thread.create(function()
    sampSendChat("/usehelm", 0x336633)
    end)
end

function zams()
    lua_thread.create(function()
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Я достал список {336633}Заместителей.", 0x336633)
	sampSendChat("/zams", 0x336633)
    end)
end

function admins()
    lua_thread.create(function()
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Я достал список {336633}Администрации.", 0x336633)
    sampSendChat("/admins", 0x336633)
    end)
end

function leaders()
    lua_thread.create(function()
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Я достал список {336633}Лидеров..", 0x336633)
    sampSendChat("/leaders", 0x336633)
    end)
end

function usearm()
    lua_thread.create(function()
    sampSendChat("/usearm", 0x336633)
    end)
end

function ag()
    lua_thread.create(function()
    sampSendChat("/agetcar", 0x336633)
	sampSendChat("/agetavia", 0x336633)
    end)
end

function th()
    lua_thread.create(function()
    sampSendChat("/tehveh", 0x336633)
	sampSendChat("/tehavia", 0x336633)
    end)
end


function cclear()
    memory.fill(sampGetChatInfoPtr() + 306, 0x0, 25200)
    memory.write(sampGetChatInfoPtr() + 306, 25562, 4, 0x0)
    memory.write(sampGetChatInfoPtr() + 0x63DA, 1, 1)
end

function formavvs1()

	while sampIsDialogActive() do
		wait(0)
	local result, button, list, input = sampHasDialogRespond(1717)
        if result then
            if button == 1 then
	if list == 0 then
		sampSendChat("/formavvs", 0x336633)
		sampSendChat("/cvet 23", 0x336633)
		sampSendChat("/me надел фурашку.", 0x336633)
	elseif list == 1 then
		sampSendChat("/formavvs", 0x336633)
		sampSendChat("/color", 0x336633)
		sampSendChat("/color", 0x336633)
		else
				end
			end
		end
	end
end

function prizivinvites()

	while sampIsDialogActive() do
		wait(0)
	local result, button, list, input = sampHasDialogRespond(17126)
        if result then
            if button == 1 then
	if list == 0 then
		sampSendChat("Добрый день, сэр.")
			wait(1000)
		sampSendChat("/ame исполнил воинское приветствие.")
			wait(2000)
		sampSendChat("Прибыли с целью рекрутирования?")
	elseif list == 1 then
		sampSendChat("Хорошо, сэр. Я должен взглянуть на Ваши документы.")
			wait(2000)
		sampSendChat("Если быть точнее, то: ID-Карта, Навыки.")
	elseif list == 2 then
		sampSendChat("Вопрос первый.")
			wait(2000)
		sampSendChat("Что находится у меня над головой?")
	elseif list == 3 then
		sampSendChat("Вопрос второй.")
			wait(2000)
		sampSendChat("Ознакомлены с порталом штата?")
	elseif list == 4 then
		sampSendChat("Вопрос третий.")
			wait(2000)
		sampSendChat("Сколько лет проживаете в штате?")
	elseif list == 5 then
		sampSendChat("Вопрос четвертый.")
			wait(2000)
		sampSendChat("Какие языки знаете?")
	elseif list == 6 then
		sampSendChat("Вопрос пятый.")
			wait(2000)
		sampSendChat("Имеется военный билет?")
	elseif list == 7 then
		sampSendChat("Вопрос шестой.")
			wait(2000)
		sampSendChat("Почему именно Национальная Гвардия?")
	elseif list == 8 then
		sampSendChat("Вопрос седьмой.")
			wait(2000)
		sampSendChat("Как относитесь к отказам?")
	elseif list == 9 then
		sampSendChat("Извините, но Вы нам не подходите из-за плохого психического состояния.")
	elseif list == 10 then
		sampSendChat("Извините, но Вы нам не подходите из-за отсутствия военного билета.")
	elseif list == 11 then
		sampSendChat("Извините, но Вы нам не подходите из-за нахождения в Черном Списке")
		wait(500)
		sampSendChat("/b Черный Список Военкомата или Черный Список Департамента")
	elseif list == 12 then
		sampSendChat("Извините, но Вы нам не подходите из-за малого срока проживания в штате.")
		wait(500)
		sampSendChat("/b К нам можно только имея уровень выше 3.")
	elseif list == 13 then
		sampSendChat("Извините, но Вы нам не подходите из-за ужасного внешнего вида.")
	elseif list == 14 then
		sampSendChat("Извините, но Вы нам не подходите из-за проф.непригодности.")
		wait(500)
		sampSendChat("/b Вы не отыгрываете РП.")
		else
				end
			end
		end
	end
end

function vracia()

	while sampIsDialogActive() do
		wait(0)
	local result, button, list, input = sampHasDialogRespond(17129)
        if result then
            if button == 1 then
	if list == 0 then
	sampSendChat("/v Внимание бойцы! Объявлено общее построениие на Авианосце!")
		wait(1000)
	sampSendChat("/v Время на сбор - 10 минут! Опоздавшие получат выговор в личное дело!")
	elseif list == 1 then
	sampSendChat("/v Внимание бойцы! Объявлено общее построениие около Штаба Зоны 51!")
		wait(1000)
	sampSendChat("/v Время на сбор - 10 минут! Опоздавшие получат выговор в личное дело!")
	else
				end
			end
		end
	end
end

function racia1()

	while sampIsDialogActive() do
		wait(0)
	local result, button, list, input = sampHasDialogRespond(17128)
        if result then
            if button == 1 then
	if list == 0 then
	sampSendChat("/r Внимание, бойцы! На базу 51 совершено проникновение!")
		wait(2000)
	sampSendChat("/r Требуется помощь, очень срочно!")
	elseif list == 1 then
	sampSendChat("/r Внимание, бойцы! На базу В.М.С совершено проникновение!")
		wait(2000)
	sampSendChat("/r Требуется помощь, очень срочно!")
	elseif list == 2 then
	sampSendChat("/r // Напоминаю, у нас есть Дискорд.")
		wait(1000)
	sampSendChat("/r // Ссылка: BJG3jhq.")
		wait(500)
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Ссылка на дискорд канал: {336633}https://discord.gg/BJG3jhq", 0x336633)
	elseif list == 3 then
	sampSendChat("/r Открыты переводы в ряды Военно-воздушных сил. Подробнее..")
		wait(1000)
	sampSendChat("/r ..можно узнать на портале, в разделе В.В.С, стажировка.")
		wait(500)
	elseif list == 4 then
	sampSendChat("/r Открыты переводы в ряды Военно-морских сил. Подробнее..")
		wait(1000)
	sampSendChat("/r ..можно узнать на портале, в разделе В.М.С, стажировка.")
	elseif list == 5 then
	sampSendChat("/r Внимание бойцы! Объявлено общее построениие около Штаба Зоны 51!")
		wait(1000)
	sampSendChat("/r Время на сбор: С.В 10 минут. В.В.С 10 минут. В.М.С 15 минут.")
	else
				end
			end
		end
	end
end

function zzachistka()

	while sampIsDialogActive() do
		wait(0)
	local result, button, list, input = sampHasDialogRespond(17371387)
        if result then
            if button == 1 then
	if list == 0 then
	sampSendChat("/d Выхожу в экстренное вещание.")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, сейчас пройдет зачистка нелегальной организации.")
		wait(6000)
	sampSendChat("/gov Cosa Nostra. Большая просьба, никому не появляться в секторе.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d Выхожу из экстренное вещания.")
	elseif list == 1 then
	sampSendChat("/d Выхожу в экстренное вещание.")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, сейчас пройдет зачистка нелегальной организации.")
		wait(6000)
	sampSendChat("/gov Yakuza Mafia. Большая просьба, никому не появляться в секторе.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d Выхожу из экстренное вещания.")
	elseif list == 2 then
	sampSendChat("/d Выхожу в экстренное вещание.")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, сейчас пройдет зачистка нелегальной организации.")
		wait(6000)
	sampSendChat("/gov Triada Mafia. Большая просьба, никому не появляться в секторе.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d Выхожу из экстренное вещания.")
	elseif list == 3 then
	sampSendChat("/d Выхожу в экстренное вещание.")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, сейчас пройдет зачистка нелегальной организации.")
		wait(6000)
	sampSendChat("/gov Russian Mafia. Большая просьба, никому не появляться в секторе.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d Выхожу из экстренное вещания.")
	elseif list == 4 then
	sampSendChat("/d Выхожу в экстренное вещание.")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, сейчас пройдет зачистка нелегальной организации.")
		wait(6000)
	sampSendChat("/gov Баскетбольного клуба: Grove Street. Никому не появляться в секторе.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d Выхожу из экстренное вещания.")
	elseif list == 5 then
	sampSendChat("/d Выхожу в экстренное вещание.")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, сейчас пройдет зачистка нелегальной организации.")
		wait(6000)
	sampSendChat("/gov Баскетбольного клуба: Ballas Gang. Никому не появляться в секторе.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d Выхожу из экстренное вещания.")
	elseif list == 6 then
	sampSendChat("/d Выхожу в экстренное вещание.")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, сейчас пройдет зачистка нелегальной организации.")
		wait(6000)
	sampSendChat("/gov Баскетбольного клуба: Vagos Gang. Никому не появляться в секторе.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d Выхожу из экстренное вещания.")
	elseif list == 7 then
	sampSendChat("/d Выхожу в экстренное вещание.")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, сейчас пройдет зачистка нелегальной организации.")
		wait(6000)
	sampSendChat("/gov Баскетбольного клуба: Los Aztecas Gang. Никому не появляться в секторе.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d Выхожу из экстренное вещания.")
	elseif list == 8 then
	sampSendChat("/d Выхожу в экстренное вещание.")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, сейчас пройдет зачистка нелегальной организации.")
		wait(6000)
	sampSendChat("/gov Arabian Mafia. Большая просьба, никому не появляться в секторе.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d Выхожу из экстренное вещания.")
	else
				end
			end
		end
	end
end

function vidachazadaniy1()

	while sampIsDialogActive() do
		wait(0)
	local result, button, list, input = sampHasDialogRespond(17132)
        if result then
            if button == 1 then
	if list == 0 then
	sampSendChat("/r Проверьте исправность Т/С Патриот. За это получаете 10 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 1 then
	sampSendChat("/r Проверьте исправность Т/С Ранчер X2. За это получаете 10 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 2 then
 	sampSendChat("/r Проверьте исправность Т/С Ранчер Х4. За это получаете 10 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 3 then
 	sampSendChat("/r Помойте мужские туалеты. За это получаете 10 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 4 then
 	sampSendChat("/r Помойте женские туалеты. За это получаете 10 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 5 then
 	sampSendChat("/r Проверьте сколько бензина на базе Зоны 51. За это получаете 2 балла.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 6 then
 	sampSendChat("/r Проверьте сколько бензина на базе В.М.С. За это получаете 2 балла.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 7 then
 	sampSendChat("/r Помойте Т/С Патриот. За это получаете 6 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 8 then
 	sampSendChat("/r Помойте Т/С Ранчер X2. За это получаете 6 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 9 then
 	sampSendChat("/r Помойте Т/С Ранчер X2. За это получаете 6 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 10 then
 	sampSendChat("/r Проверьте исправность Контрольного центра. За это получаете 10 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 11 then
 	sampSendChat("/r Проверьте состояние парашютов в вертолетах. За это получаете 10 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 12 then
 	sampSendChat("/r Проверьте техническое состояние катера. За это получаете 10 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 13 then
 	sampSendChat("/r Установите антивирус на компьютер. За это получаете 6 баллов.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	else
				end
			end
		end
	end
end

function government1()

	while sampIsDialogActive() do
		wait(0)
	local result, button, list, input = sampHasDialogRespond(17130)
        if result then
            if button == 1 then
	if list == 0 then
	sampSendChat("/d Вещаю!")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, сейчас пройдет рекрутирование в Национальную Гвардию.")
		wait(6000)
	sampSendChat("/gov Для поступления на службу требуется. ID-Карта | Навыки | Военный билет. Ждем в военкомате.")
		wait(1000)
	sampSendChat("/d Окончил вещание!")
		wait(1000)
	sampSendChat("/time")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Нужно открыть набор в {336633}[ /lmenu ]{FFFFFF}.")
	elseif list == 1 then
    sampSendChat("/d Вещаю!")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, рекрутирование в Национальную Гвардию завершено.")
		wait(6000)
	sampSendChat("/gov Опоздавших просьба не появляться.")
		wait(1000)
	sampSendChat("/d Окончил вещание!")
		wait(1000)
	sampSendChat("/time")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Нужно закрыть набор в {336633}[ /lmenu ]{FFFFFF}.")
	elseif list == 2 then
    sampSendChat("/d Вещаю!")
		wait(1000)
	sampSendChat("/gov Уважаемые жители штата, открыты заявление на Контрактную Службу.")
		wait(6000)
	sampSendChat("/gov Подробная информация на Портале Штата.")
		wait(1000)
	sampSendChat("/d Окончил вещание!")
		wait(1000)
	sampSendChat("/time")
	else
				end
			end
		end
	end
end

function lektcii1()

	while sampIsDialogActive() do
		wait(0)
	local result, button, list, input = sampHasDialogRespond(17130)
        if result then
            if button == 1 then
	if list == 0 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию о постах.")
	wait(5000)
	sampSendChat("/z Во время занятия поста, обязательно должен быть доклад")
	wait(5000)
	sampSendChat("/z Докладывает Штаб-сержант Плюха. Занимаю пост - вышка возле ВПП. Следующий доклад..")
	wait(5000)
	sampSendChat("/z ..через 5 минут. Конец связи.")
	wait(5000)
	sampSendChat("/z Докладывает Штаб-сержант Плюха. Пост - вышка. Состояние - (стабильное, критическое)..")
	wait(5000)
	sampSendChat("/z ..Конец связи.")
	wait(5000)
	sampSendChat("/z Если дали приказ о занятии поста, нет смысла спорить с старшим руководством.. ")
	wait(5000)
	sampSendChat("/z ..и занять пост по приказанию. (имея доклады).")
	wait(5000)
	sampSendChat("/z Докладывать строго каждые 10 минут.")
	wait(5000)
	sampSendChat("/z Эту лекцию я провел для вашего же блага.")
	wait(5000)
	sampSendChat("/z Будьте внимательны, и не перечьте другим бойцам. Все свободны!")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	elseif list == 1 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию по субординации.")
	wait(5000)
	sampSendChat("/z В армии США, вы не должны употреблять жаргон другой армии. У нас нет слов..")
	wait(5000)
	sampSendChat("/z ..можно , да , нет , привет.")
	wait(5000)
	sampSendChat("/z Давайте приведу пример. Допустим я Рядовой-курсант, и мне нужно обратиться..")
	wait(5000)
	sampSendChat("/z к старшему составу, чтобы они занялись мной.")
	wait(5000)
	sampSendChat("/z Генерал, Уэйн, разрешите обратиться?")
	wait(5000)
	sampSendChat("/z Таким образом вы не употребляете слова-паразиты, которые..")
	wait(5000)
	sampSendChat("/z не уместны в нашей армии.")
	wait(5000)
	sampSendChat("/z Ко всем обращаться строго по званию, фамилии.")
	wait(5000)
	sampSendChat("/z К примеру: Генерал Ротшильд, дайте последующие указания.")
	wait(5000)
	sampSendChat("/z Обращаться ко всем сослуживцам Строго на Вы, больше никак.")
	wait(5000)
	sampSendChat("/z Запрещено вести спор со старшими по званию.")
	wait(5000)
	sampSendChat("/z За не соблюдение субординации, вы получаете выговор в личное дело..")
	wait(5000)
	sampSendChat("/z так как это перечит Уставу Министерства Обороны.")
	wait(5000)
	sampSendChat("/z За многократное не соблюдение субординации, боец будет лишен шевронов..")
	wait(5000)
	sampSendChat("/z ..и уволен с Нац. Гвардии.")
	wait(5000)
	sampSendChat("/z Эту лекцию я провел для вашего же блага.")
	wait(5000)
	sampSendChat("/z Будьте внимательны, и не перечьте другим бойцам. Все свободны!")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	elseif list == 2 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию по военному транспорту.")
	wait(5000)
	sampSendChat("/z Бойцам армии не имеющим звание Штаб-Сержант, запрещено.. ")
	wait(5000)
	sampSendChat("/z ..брать какой либо транспорт..")
	wait(5000)
	sampSendChat("/z ..NGSA без разрешения старшего состава.")
	wait(5000)
	sampSendChat("/z Наземный транспорт, предназначен для: тренировок, зачисток, парада..")
	wait(5000)
	sampSendChat("/z ..мероприятия, охраны.")
	wait(5000)
	sampSendChat("/z Воздушный транспорт брать только после разрешения Генерала.")
	wait(5000)
	sampSendChat("/z Если на то не было спроса, будет..")
	wait(5000)
	sampSendChat("/z ..выдан выговор в личное дело.")
	wait(5000)
	sampSendChat("/z Самолеты: Hydra , Rustler брать только для учебного полета, патруля..")
	wait(5000)
	sampSendChat("/z или по приказу Генерала.")
	wait(5000)
	sampSendChat("/z Эту лекцию я провел для вашего же блага.")
	wait(5000)
	sampSendChat("/z Будьте внимательны, и не перечьте другим бойцам. Все свободны!")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	elseif list == 3 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию по поведению в строю.")
	wait(5000)
	sampSendChat("/z При приказу всеобщего построения, сразу явиться без всякого спора.")
	wait(5000)
	sampSendChat("/z На построение вам даётся: 10 минут для СВ и ВВС, 15 минут для ВМС.")
	wait(5000)
	sampSendChat("/z Если вы не успели попасть в строй во время, вам нужно..")
	wait(5000)
	sampSendChat("/z ..обратиться к Генералу, Тренеру..")
	wait(5000)
	sampSendChat("/z .. попросить прощения за опоздание, и после стать в строй.")
	wait(5000)
	sampSendChat("/z В строю запрещено держать оружие, смотреть на часы, вести диалог..")
	wait(5000)
	sampSendChat("/z ..смотреть по сторонам.")
	wait(5000)
	sampSendChat("/z Покидать строй без разрешения нельзя.")
	wait(5000)
	sampSendChat("/z Если вы во время строя увидели нарушение, без спроса не открывать огонь..")
	wait(5000)
	sampSendChat("/z ..дождитесь приказания Генерала.")
	wait(5000)
	sampSendChat("/z За не соблюдение этих правил после лекции, он будет наказан.")
	wait(5000)
	sampSendChat("/z Эту лекцию я провел для вашего же блага.")
	wait(5000)
	sampSendChat("/z Будьте внимательны, и не перечьте другим бойцам. Все свободны!")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	elseif list == 4 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию по тренировкам.")
	wait(5000)
	sampSendChat("/z Что такое тренировка? Давайте расскажу.")
	wait(5000)
	sampSendChat("/z Тренировка - физическая, логическая деятельность, направленная..")
	wait(5000)
	sampSendChat("/z ..на развития вашего разума и силы.")
	wait(5000)
	sampSendChat("/z Правила поведения, запомните их на всю жизнь..")
	wait(5000)
	sampSendChat("/z ..как таблицу умножения в школе.")
	wait(5000)
	sampSendChat("/z Первое - слушаться Тренера, и Старших по званию.")
	wait(5000)
	sampSendChat("/z Второе - использовать оружие только по приказу.")
	wait(5000)
	sampSendChat("/z Третье - не покидать строй, только по приказу.")
	wait(5000)
	sampSendChat("/z Четвертое - не перечить Тренеру!")
	wait(5000)
	sampSendChat("/z Пятое - если у вас повреждена мышца, или возникла..")
	wait(5000)
	sampSendChat("/z ..какая-то травма, вы в праве..")
	wait(5000)
	sampSendChat("/z ..отпроситься у Тренера на уход с Тренировки.")
	wait(5000)
	sampSendChat("/z Шестое - с разрешения Майора, вы в праве не ехать на тренировку с составом.")
	wait(5000)
	sampSendChat("/z Бойцы, я надеюсь вы все запомнили, если будут вопросы подходите..")
	wait(5000)
	sampSendChat("/z ..после лекции ко мне. Проведем беседу.")
	wait(5000)
	sampSendChat("/z Эту лекцию я провел для вашего же блага.")
	wait(5000)
	sampSendChat("/z Будьте внимательны, и не перечьте другим бойцам. Все свободны!")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	elseif list == 5 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию для новобранцев.")
	wait(5000)
	sampSendChat("/z Ваша первостепенная задача - защита и охрана базы.")
	wait(5000)
	sampSendChat("/z Покидать базу без предупреждения и в форме - строго выговор..")
	wait(5000)
	sampSendChat("/z ..без обсуждений.")
	wait(5000)
	sampSendChat("/z Обеденный перерыв с 12:00 до 14:00, за это..")
	wait(5000)
	sampSendChat("/z ..время вы успеете заняться своими делами.")
	wait(5000)
	sampSendChat("/z Рабочий день начинается с 8:00 утра до 20:00 вечера.")
	wait(5000)
	sampSendChat("/z Увидев гражданского на базе, стоит узнать его намерения..")
	wait(5000)
	sampSendChat("/z ..не обязательно сразу открывать огонь.")
	wait(5000)
	sampSendChat("/z Запрещены споры со старшими по званию.")
	wait(5000)
	sampSendChat("/z Необходимую информацию для прохождения Военной Академии...")
	wait(5000)
	sampSendChat("/z ... вы найдете на официальном портале Штата.")
	wait(5000)
	sampSendChat("/z Эту лекцию я провел для вашего же блага.")
	wait(5000)
	sampSendChat("/z Будьте внимательны, и не перечьте другим бойцам. Все свободны!")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	elseif list == 6 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию о самоволе.")
	wait(5000)
	sampSendChat("/z Каждый боец Нац. Гвардии обязан находиться..")
	wait(5000)
	sampSendChat("/z ..на военной базе в течении рабочего дня.")
	wait(5000)
	sampSendChat("/z Рабочий день начинается с 8:00 до 20:00.")
	wait(5000)
	sampSendChat("/z Для личных дел, дается время с 12:00 до 14:00.")
	wait(5000)
	sampSendChat("/z Если кто-то покидает расположение базы без ведома...")
	wait(5000)
	sampSendChat("/z ...то в его дело заносится выговор.")
	wait(5000)
	sampSendChat("/z Эту лекцию я провел для вашего же блага.")
	wait(5000)
	sampSendChat("/z Будьте внимательны, и не перечьте другим бойцам. Все свободны!")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	elseif list == 7 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию о получении выговоров.")
	wait(5000)
	sampSendChat("/z Слушаем внимательно, и вникаем.")
	wait(5000)
	sampSendChat("/z Выговор можно получить за:")
	wait(5000)
	sampSendChat("/z ...самовольные действия во время несения службы..")
	wait(5000)
	sampSendChat("/z ...сон на посту;...")
	wait(5000)
	sampSendChat("/z ...не цензурная брань в рабочее время, не соблюдение субординации;...")
	wait(5000)
	sampSendChat("/z ...невыполнение приказов старших по званию, неподчинение им;...")
	wait(5000)
	sampSendChat("/z ...нападение на мирных, сослуживцев или сотрудников ПО.")
	wait(5000)
	sampSendChat("/z На этом лекция окончена, советую как можно чаще перечитывать Устав, чтобы...")
	wait(5000)
	sampSendChat("/z ...быть осведомлённым обо всех изменениях и не забывать его пунктов.")
	wait(5000)
	sampSendChat("/z Эту лекцию я провел для вашего же блага.")
	wait(5000)
	sampSendChat("/z Будьте внимательны, и не перечьте другим бойцам. Все свободны!")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	elseif list == 8 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию о запретах.")
	wait(5000)
	sampSendChat("/z Военнослужащему запрещено стрелять без причины по гражданским лицам.")
	wait(5000)
	sampSendChat("/z Бойцу Армии, ниже звания Мл. Лейтенанта запрещено самовольно покидать территорию.")
	wait(5000)
	sampSendChat("/z Военнослужащему запрещено использовать служебный транспорт в личных целях.")
	wait(5000)
	sampSendChat("/z Бойцу Армии запрещено выражаться нецензурной бранью.")
	wait(5000)
	sampSendChat("/z Служащему запрещено нарушать Законы, Уставы..")
	wait(5000)
	sampSendChat("/z ..Военный жаргон, Указы Министерства, и ПДД.")
	wait(5000)
	sampSendChat("/z Эту лекцию я провел для вашего же блага.")
	wait(5000)
	sampSendChat("/z Будьте внимательны, и не перечьте другим бойцам. Все свободны!")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	elseif list == 9 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию для бойцов Сухопутных Войск.")
	wait(5000)
	sampSendChat("/z Ваша обязанность следить за территорией базы.")
	wait(5000)
	sampSendChat("/z Слушаться Старших по званию.")
	wait(5000)
	sampSendChat("/z За нарушение Устава СВ, строго выговор в личное дело.")
	wait(5000)
	sampSendChat("/z Обращаться ко своим сослуживцам строго на Вы.")
	wait(5000)
	sampSendChat("/z Запрещено открывать огонь без причины на то.")
	wait(5000)
	sampSendChat("/z Во время занятия поста, нужно обязательно иметь доклады.")
	wait(5000)
	sampSendChat("/z Если вам нужно покинуть базу, и..")
	wait(5000)
	sampSendChat("/z ..пойти в Штаб, доложите Старшему по званию.")
	wait(5000)
	sampSendChat("/z На этом лекция окончена. Берегите ноги.")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	elseif list == 10 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию для Военно-морских сил..")
	wait(5000)
	sampSendChat("/z За нарушение Устава ВМС, строго выговор в личное дело.")
	wait(5000)
	sampSendChat("/z Ваша обязанность следить за базой..")
	wait(5000)
	sampSendChat("/z ..охранять её, и не давать ограбить БП.")
	wait(5000)
	sampSendChat("/z Строго подчиняться Старшему составу.")
	wait(5000)
	sampSendChat("/z Запрещено покидать базу по личным целям в рабочее время.")
	wait(5000)
	sampSendChat("/z Проводить тех. осмотр у лодок, делать улучшения для базы.")
	wait(5000)
	sampSendChat("/z Во время занятия поста, нужно доложить..")
	wait(5000)
	sampSendChat("/z ..в рацию, в последующими докладами.")
	wait(5000)
	sampSendChat("/z На этом все, всех благ, за работу!")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	elseif list == 11 then
	sampSendChat("/z Бойцы, приветствую!")
	wait(5000)
	sampSendChat("/me открыв книжку, начал говорить речь.")
	wait(5000)
	sampSendChat("/z Сегодня проведем лекцию для Военно-воздушных сил..")
	wait(5000)
	sampSendChat("/z Запрещено брать летный транспорт Hydra..")
	wait(5000)
	sampSendChat("/z ..Rustler , Nevada в личных цели.")
	wait(5000)
	sampSendChat("/z Не иметь бесполезные споры с.")
	wait(5000)
	sampSendChat("/z ..Старшим составом и руководством ВВС.")
	wait(5000)
	sampSendChat("/z Следить за ВПП.")
	wait(5000)
	sampSendChat("/z Не нарушать Устав ВВС, за нарушение, выговор в личное дело.")
	wait(5000)
	sampSendChat("/z Помогать Бойцам СВ, ВМС, если на то есть надобность.")
	wait(5000)
	sampSendChat("/z Не оставлять самолеты на гос. аэропортах Штата.")
	wait(5000)
	sampSendChat("/z Перед полетом, надевать форму, строго!")
	wait(5000)
	sampSendChat("/z Перед полетом, осмотреть самолет на тех. неполадки.")
	wait(5000)
	sampSendChat("/z Осматривать колонки с солярой для воздушного транспорта.")
	wait(5000)
	sampSendChat("/z На этом у меня все, если есть вопросы..")
	wait(5000)
	sampSendChat("/z ..подходите после лекции, все свободны.")
	wait(5000)
	sampSendChat("/me закрыл книжку..")
	else
				end
			end
		end
	end
end

function lektcii(arg)
	sampShowDialog(17130, "{FFFFFF}N.G.S.A Helper | Лекционный раздел", string.format("[ 1 ] Лекция о постах\n[ 2 ] Лекция по субординации\n[ 3 ] Лекция по военному транспорту\n[ 4 ] Лекция по поведению в строю\n[ 5 ] Лекция по поведению во время тренировки \n[ 6 ] Лекция для новобранцев\n[ 7 ] Лекция о самоволе\n[ 8 ] Лекция о получении выговоров\n[ 9 ] Лекция о запретах\n[ 10 ] Лекция для Бойцов СВ\n[ 11 ] Лекция для Пехотинцев ВМС\n[ 12 ] Лекция для Птичек ВВС"), "Выбрать", "Закрыть", 2)
	lua_thread.create(lektcii1)
end

function vidachazadaniy(arg)
	sampShowDialog(17132, "{FFFFFF}N.G.S.A Helper | Меню выдачи заданий", string.format("[ 1 ] Проверить исправность Патриота | 10 баллов\n[ 2 ] Проверить исправность Ранчера Х2 | 10 баллов\n[ 3 ] Проверить исправность Ранчера Х4 | 10 баллов\n[ 4 ] Помыть мужские туалеты | 10 баллов\n[ 5 ] Помыть женские туалеты | 10 баллов\n[ 6 ] Проверка бензина Зона 51 | 2 балла\n[ 7 ] Проверка бензина В.М.С | 2 балла\n[ 8 ] Помыть Патриот | 6 баллов\n[ 9 ] Помыть Ранчер Х2 | 6 баллов\n[ 10 ] Помыть Ранчер Х4 | 6 баллов\n[ 11 ] Исправность Контрольного центра. | 10 баллов\n[ 12 ] Состояние парашютов в вертолетах | 10 баллов\n[ 13 ] Техническое состояние катера | 10 баллов\n[ 14 ] Установка антивируса | 6 баллов"), "Выбрать", "Закрыть", 2)
	lua_thread.create(vidachazadaniy1)
end

function government(arg)
	sampShowDialog(17130, "{FFFFFF}N.G.S.A Helper | Подача государственной волны", string.format("[ 1 ] О начале призыва\n[ 2 ] О конце призыва\n[ 3 ] О контрактной службе"), "Выбрать", "Закрыть", 2)
	lua_thread.create(government1)
end

function racia(arg)
	sampShowDialog(17128, "{FFFFFF}N.G.S.A Helper | Рация: R", string.format("[ 1 ] Проникновение Зона 51\n[ 2 ] Проникновение В.М.С\n[ 3 ] Дискорд канал\n[ 4 ] Стажировка В.В.С\n[ 5 ] Стажировка В.М.С\n[ 6 ] Всеобщее построение"), "Выбрать", "Закрыть", 2)
	lua_thread.create(racia1)
end

function departament(arg)
	sampShowDialog(12861, "{FFFFFF}N.G.S.A Helper | Рация: департамент", string.format("[ 1 ] Проникновение Зона 51\n[ 2 ] Проникновение В.М.С"), "Выбрать", "Закрыть", 2)
	lua_thread.create(departament1)
end

function pr(arg)
	sampShowDialog(17126, "{FFFFFF}N.G.S.A Helper | Призыв", string.format("[ 1 ] Приветстствие\n[ 2 ] Проверка документов\n[ 3 ] Вопрос 1\n[ 4 ] Вопрос 2\n[ 5 ] Вопрос 3\n[ 6 ] Вопрос 4\n[ 7 ] Вопрос 5\n[ 8 ] Вопрос 6\n[ 9 ] Вопрос 7\n[ 10 ] Отказ: псих. сост\n[ 11 ] Отказ: Военный билет\n[ 12 ] Отказ: ЧСД/ЧСВ\n[ 13 ] Отказ: Маленький лвл\n[ 14 ] Отказ: Внешний вид\n[ 15 ] Отказ: Проф.непригодность"), "Выбрать", "Закрыть", 2)
	lua_thread.create(prizivinvites)
end

function formavvs(arg)
	sampShowDialog(1717, "{FFFFFF}N.G.S.A Helper | Форма Военно-Воздушных сил", string.format("[ 1 ] Надеть форму\n[ 2 ] Снять форму"), "Выбрать", "Закрыть", 2)
	lua_thread.create(formavvs1)
end

function vracia1(arg)
	sampShowDialog(17129, "{FFFFFF}N.G.S.A Helper | Рация: V", string.format("[ 1 ] Построение В.М.С\n[ 2 ] Построение В.В.С"), "Выбрать", "Закрыть", 2)
	lua_thread.create(vracia)
end

function zzachistka1(arg)
	sampShowDialog(17371387, "{FFFFFF}N.G.S.A Helper | Меню зачистки", string.format("[ 1 ] {d6db39}Cosa Nostra\n[ 2 ] {bd0f0f}Yakuza Mafia\n[ 3 ] {132054}Triada Mafia\n[ 4 ] {141414}Russian Mafia\n[ 5 ] {05ad16}Grove Street\n[ 6 ] {9215ab}Ballas Gang\n[ 7 ] {bfb71b}Vagos Gang\n[ 8 ] {10abc7}Los Aztecas Gang\n[ 9 ] {6e5003}Arabian Mafia"), "Выбрать", "Закрыть", 2)
	lua_thread.create(zzachistka)
end

function ngsa(arg)
    sampShowDialog(1970, "{FFFFFF}N.G.S.A Helper | Информация", textdialog, "*", "", 0)
end

function dpravila(arg)
    sampShowDialog(1971, "{FFFFFF}N.G.S.A Helper | Правила использования чата департамента", praviladepartamenta, "*", "", 0)
end
	
function govpravila(arg)
    sampShowDialog(1976712, "{FFFFFF}N.G.S.A Helper | Правила использования государственной волны", pravilagosvolny2, "*", "", 0)
end
	
function pravilarank(arg)
    sampShowDialog(1976714, "{FFFFFF}N.G.S.A Helper | Правила повышения ранга во фракции", pravilarank1, "*", "", 0)
end

function updates(arg)
    sampShowDialog(19767271, "{FFFFFF}N.G.S.A Helper | Обновления скрипта", obnovleniascripta1, "*", "", 0)
end

function authors(arg)
    sampShowDialog(19767279, "{FFFFFF}N.G.S.A Helper | Авторы скрипта", authors1, "*", "", 0)
end

function zzachistka2(arg)
    sampShowDialog(19767280, "{FFFFFF}N.G.S.A Helper | Система проведения зачисток", zzachistkaa2, "*", "", 0)
end

function calc(params)
    if params == '' then
        sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Калькулятор: {336633}[ пример ]{FFFFFF}.", -1)
    else
        local func = load('return ' .. params)
        if func == nil then
            sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Ошибка..", -1)
        else
            local bool, res = pcall(func)
            if bool == false or type(res) ~= 'number' then
                sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Что то сделано не так..", -1)
            
            else
                sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Результат {336633}" .. res, -1)
            end
        end
    end
end

function rb(param)
	mgchat1 = param
	sampSendChat("/r // "..mgchat1)
end
		
function db(param)
	mgchat2 = param
	sampSendChat("/d // "..mgchat2)
end

function vb(param)
	mgchat3 = param
	sampSendChat("/v // "..mgchat3)
end

function postfind(param)
	tonumber(param)
	confind2 = param
	if confind == false then
		confind = true
		if sampIsPlayerConnected(param) then
			if confind2 ~= nil then
					lua_thread.create(function()
						while confind == true do 
							if confind == false then break end
							wait(1500)
							sampSendChat("/find "..confind2)
							wait(1500)
						end
					end)
			else sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}*Постоянный поиск игрока {336633}[ /fd ID ]{FFFFFF}.", -1)
			end
		else sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Данный игрок {336633}не в игре{FFFFFF}.", -1)
		end
	else
		sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Постоянный поиск {336633}прекращен{FFFFFF}.", -1)
		confind = false
	end
end

function postoyanniypursuit(param)
  local id = string.match(param, '%s*(.+)')
  if id ~= nil then
    sampSendChat(string.format("/pursuit %s", id))
  else
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Быстрый {FFFFFF}PURSUIT {336633} [/pu ID ]", 0x336633)
  end
end

function kinytshipi(param)
  local id = string.match(param, '(%d+)')
  if id ~= nil then
  
	sampSendChat(string.format("/ship %d", id))
  else
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Кинуть шипы под колеса {336633} [/sh ID ]", 0x336633)
  end
end

function checkwanted(param)
  local id = string.match(param, '(%d+)')
  if id ~= nil then
    sampSendChat(string.format("/wanted %d", id))
  else
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Посмотреть количество звезд {336633} [/wd ID ]", 0x336633)
  end
end

function nickid(params)
    id = tonumber(params)
    if params and id ~= nil then
        nick = sampGetPlayerNickname(id)
        result = sampIsPlayerConnected(id)
		level = sampGetPlayerScore(id)
        if result then
            sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* {336633}ID: {FFFFFF}" .. id .. ". {336633}Имя Фамилия: {FFFFFF}" .. nick .. ". {336633}Уровень: {FFFFFF}" .. level .. ".", -1)
        else
            sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* Игрок оффлайн", -1)
        end
    end
end

function comma_value(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function separator(text)
	if text:find("$") then
	    for S in string.gmatch(text, "%$%d+") do
	    	local replace = comma_value(S)
	    	text = string.gsub(text, S, replace)
	    end
	    for S in string.gmatch(text, "%d+%$") do
	    	S = string.sub(S, 0, #S-1)
	    	local replace = comma_value(S)
	    	text = string.gsub(text, S, replace)
	    end
	end
	return text
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
	text = separator(text)
	title = separator(title)
	return {dialogId, style, title, button1, button2, text}
end

function sampev.onServerMessage(color, text)
	text = separator(text)
	return {color, text}
end

function sampev.onCreate3DText(id, color, position, distance, testLOS, attachedPlayerId, attachedVehicleId, text)
	text = separator(text)
	return {id, color, position, distance, testLOS, attachedPlayerId, attachedVehicleId, text}
end

function sampev.onTextDrawSetString(id, text)
	text = separator(text)
	return {id, text}
end

function imgui.OnDrawFrame()

	if not isCharInAnyCar(PLAYER_PED) then
		posX, posY = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(50, 500), imgui.Cond.FirstUseEver)
		imgui.ShowCursor = false
		imgui.SetMouseCursor(-1)
		_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
		server = sampGetCurrentServerName(PLAYER_HANDLE)
		ip = sampGetCurrentServerAddress(PLAYER_PED)
		weap = getCurrentCharWeapon(PLAYER_PED)
		weaponid = getWeapontypeModel(weap)
		ammo = getAmmoInCharWeapon(PLAYER_PED, weap)
		nick = sampGetPlayerNickname(id)
		fFps = mem.getfloat(0xB7CB50, 4, false)	
		ping = sampGetPlayerPing(id)
		time = (os.date("%H",os.time())..':'..os.date("%M",os.time())..':'..os.date("%S",os.time()))
		date = (os.date("%d",os.time())..'.'..os.date("%m",os.time())..'.'..os.date("%Y",os.time()))
		Health = getCharHealth(PLAYER_PED)
		Armor = getCharArmour(PLAYER_PED)
		Level = sampGetPlayerScore(id)
		pspeed = getCharSpeed(PLAYER_PED)
		imgui.Begin("INFOBAR | Special for N.G.S.A Helper", window, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.ShowBorders)
		imgui.Text("       National Guard of San Andreas", main_color)
		imgui.Text("_______________________________", main_color)
		imgui.Text("" .. server, main_color)
		imgui.Text("".. nick .. " [" .. id .."]", main_color)
		imgui.Text("FPS: " .. math.floor(fFps).. " | Ping: ".. ping, main_color)
		imgui.Text("Time: " .. time .. " | Date: ".. date, main_color)
		imgui.Text(u8"Город: " .. city[getCityPlayerIsIn(PLAYER_HANDLE)] .. " | HP: " .. Health .. " | AHP: " .. Armor, main_color)
		imgui.End()
	else
		imgui.SetNextWindowPos(imgui.ImVec2(50, 500), imgui.Cond.FirstUseEver)
		imgui.ShowCursor = false
		imgui.SetMouseCursor(-1)
		_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
		car = storeCarCharIsInNoSave(playerPed)
		carmodel = getCarModel(car)
		carname = getGxtText(getNameOfVehicleModel(carmodel))
		_, cid = sampGetVehicleIdByCarHandle(car)
		carhp = getCarHealth(car)
		cspeed = getCarSpeed(car)
		server = sampGetCurrentServerName(PLAYER_HANDLE)
		ip = sampGetCurrentServerAddress(PLAYER_PED)
		nick = sampGetPlayerNickname(id)
		fFps = mem.getfloat(0xB7CB50, 4, false)	
		ping = sampGetPlayerPing(id)
		time = (os.date("%H",os.time())..':'..os.date("%M",os.time())..':'..os.date("%S",os.time()))
		date = (os.date("%d",os.time())..'/'..os.date("%m",os.time())..'/'..os.date("%Y",os.time()))
		Health = getCharHealth(PLAYER_PED)
		Armor = getCharArmour(PLAYER_PED)
		Level = sampGetPlayerScore(id)
		imgui.Begin("INFOBAR | Special for N.G.S.A Helper", window, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.ShowBorders)
		imgui.Text("       National Guard of San Andreas", main_color)
		imgui.Text("_______________________________", main_color)
		imgui.Text("" .. server, main_color)
		imgui.Text("".. nick .. " [" .. id .."]", main_color)
		imgui.Text("FPS: " .. math.floor(fFps).. " | Ping: ".. ping, main_color)
		imgui.Text("Time: " .. time .. " | Date: ".. date, main_color)
		imgui.Text("City: " .. city[getCityPlayerIsIn(PLAYER_HANDLE)] .. " | HP: " .. Health .. " | AHP: " .. Armor, main_color)
		imgui.End()
	end
end