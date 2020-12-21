script_name("N.G.S.A Helper")
script_description("/ngsa - Information")
script_version("0.3")
script_author("Wayne Rothschild and Englebert Rothschild")
require "lib.moonloader"
requests = require('requests')
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local memory = require "memory" -- ����������� ��� ������� ����
local sampevcheck, sampev = pcall(require, "lib.samp.events") -- ����������� ��� ���������� �����

local textdialog = "{336633}________________________________________________________________________________\n\n{FFFFFF}- {336633}������� ����: {FFFFFF}[ /cclear ].\n{FFFFFF}- {336633}���������� �����: {FFFFFF}[ /fd ].\n{FFFFFF}- {336633}�����������: {FFFFFF}[ /calc ].\n{FFFFFF}- {336633}���������� � ���. �������: {FFFFFF}[ /gos ].\n{FFFFFF}- {336633}���������� � ��� �����: {FFFFFF}[ /racia ].\n{FFFFFF}- {336633}���������� � ��� �����: {FFFFFF}[ /vr ].\n{FFFFFF}- {336633}�������� ��� �������: {FFFFFF}[ /pr ].\n{FFFFFF}- {336633}������� ���� ������������� ������������: {FFFFFF}[ /dpravila ].\n{FFFFFF}- {336633}������ �������: {FFFFFF}[ /ld ].\n{FFFFFF}- {336633}������ ������������: {FFFFFF}[ /zm ].\n{FFFFFF}- {336633}������ ���������������: {FFFFFF}[ /adm ].\n{FFFFFF}- {336633}���������� � ����������� �������: {FFFFFF}[ /updates ]\n{FFFFFF}- {336633}����� ��������� �������: {FFFFFF}[ /ag ].\n{FFFFFF}- {336633}�������� ��������� �������: {FFFFFF}[ /th ].\n{FFFFFF}- {336633}������ ����������: {FFFFFF}[ /us ].\n{FFFFFF}- {336633}������� ������ ��������������� �����: {FFFFFF}[ /govpravila ].\n{FFFFFF}- {336633}������� ������ �����: {FFFFFF}[ /pravilarank ]\n{FFFFFF}- {336633}������ ������� � ����� �.�.� / ��� �����: {FFFFFF}[ /forma ].\n{FFFFFF}- {336633}���������� ������: {FFFFFF}[ /lec ].\n{FFFFFF}- {336633}������ �������: {FFFFFF}[ /authors ].\n{FFFFFF}- {336633}�� ��� �����: {FFFFFF}[ /rb ].\n{FFFFFF}- {336633}�� ��� �����: {FFFFFF}[ /vb ].\n{FFFFFF}- {336633}�� ��� ������������: {FFFFFF}[ /db ].\n{FFFFFF}- {336633}������ �����: {FFFFFF}[ /uh ].\n{FFFFFF}- {336633}��� �� �������: | /v {FFFFFF}[ /pos ].\n{FFFFFF}- {336633}�������: | /v {FFFFFF}[ /vzl ].\n{FFFFFF}- {336633}���������� ���������� �����: {FFFFFF}[ /wd ].\n{FFFFFF}- {336633}������ ����: {FFFFFF}[ /sh ].\n{FFFFFF}- {336633}������� PURSUIT: {FFFFFF}[ /pu ].\n{FFFFFF}- {336633}��������� ����������� � ����: {FFFFFF}[ /mb ].\n{FFFFFF}- {336633}��������� ����: {FFFFFF}[ /lm ].\n{FFFFFF}- {336633}���� ��������: {FFFFFF}[ /zz ].\n{FFFFFF}- {336633}������� ���������� '��������': {FFFFFF}[ /zzinfo ].\n{FFFFFF}- {336633}������ ��� ������: {FFFFFF}[ /iid ].\n{FFFFFF}- {336633}������� ������ �������: {FFFFFF}[ /cl ID ].\n{FFFFFF}- {336633}���� ������ �������: {FFFFFF}[ /zadan ].\n\n{336633}________________________________________________________________________________"
local praviladepartamenta = "{336633}________________________________________________________________________________\n\n{FFFFFF}[ 1 ]{336633} ��������� ��������� ������� � OOC � {FFFFFF}7:00 {336633}�� {FFFFFF}22:00{336633}\n{FFFFFF}[ 2 ]{336633} ��������� ���������� � �������/������� ���������.\n{FFFFFF}[ 3 ]{336633} ��������� ����������� � ������� ����������� ������������.\n{FFFFFF}[ 4 ]{336633} ��������� ������������ ������������� �������. {FFFFFF}[ ���/MG ]{336633}\n{FFFFFF}[ 5 ]{336633} ��������� OOC �����������.\n{FFFFFF}[ 6 ]{336633} ��������� ������������ ����� ������������ {FFFFFF}������{336633} ���������� � ���.����������.\n{FFFFFF}| ���������� {336633}��� ����������� �����: {FFFFFF}��{336633}, {FFFFFF}���������� �� ��������� {336633}\n{FFFFFF}[ 7 ]{336633} ��������� ������� ���, ���� �� ��� ����� �� ��������, ���� ���� ������� ��������� ��� �� ��������.\n{FFFFFF}[ 8 ]{336633} �������� ���������� �����.\n{FFFFFF}[ 9 ]{336633} ��������� ������� �� � ������� ����������\n                            {FFFFFF}�� ��������� ������ ����� ������������ ��������� ������ ��������� � ����:\n{FFFFFF}[ 1 ]{336633} ��������� ������� � �������� ������ - {FFFFFF}������������ ����� �� 20 �����.\n{FFFFFF}[ 2 ]{336633} ���������� � �������/������� ��������� - {FFFFFF}������������ ����� �� 30 �����.\n{FFFFFF}[ 3 ]{336633} ����������� � ������� ����������� ������������ - {FFFFFF}������������ ����� �� 30 �����.\n{FFFFFF}[ 4 ]{336633} ������������ ������������� ������� - {FFFFFF}������������ ����� �� 20 �����.\n{FFFFFF}[ 5 ]{336633} OOC ����������� - {FFFFFF}������������ ����� �� 20 �����.\n{FFFFFF}[ 6 ]{336633} ������������ ����� ������������ ������ ���������� � ���.���������� - {FFFFFF}������������ ����� �� 30 �����.\n{FFFFFF}[ 7 ]{336633} ���������� ����� � ���� ������ - {FFFFFF}������������ ����� �� 30 �����.\n{FFFFFF}[ 8 ]{336633} ��������� ������������ - {FFFFFF}������������ ����� �� 20 �����.\n{FFFFFF}[ 9 ]{336633} ��������� ��� - {FFFFFF}������������ ����� �� 30 �����."
local pravilagosvolny2 = "{336633}________________________________________________________________________________\n\n{FFFFFF}[ 1 ]{336633} �������� ����� ������� ���.����� - {FFFFFF}10 �����\n{FFFFFF}[ 2 ]{336633} �������� ������ ���.����� (�������� � ��� �� �������) - {FFFFFF}20 �����\n{FFFFFF}[ 3 ]{336633} �������� ������� ���.����� (�������� � ��� �� �������)- {FFFFFF}5 �����\n{FFFFFF}[ 4 ]{336633} ���.������� � ���������� �������� �������� ��� �������.\n{FFFFFF}[ 5 ]{336633} ������������ ���������� ������� {FFFFFF}[/gov ] {336633}- {FFFFFF}2.\n{FFFFFF}[ 6 ]{336633} ��� ����� �������� �������� �� ����� �� �� �����,������� �� ������ ������\n{FFFFFF}[ 7 ]{336633} ��� ������� ������� �������� ���.����� ���� �������� ���������.\n{FFFFFF}[ 8 ]{336633} ����������� ����� �������� �� ��������� ������.\n{FFFFFF}[ 9 ]{336633} ��� ������ �� ������ ���.�����,��� ����� ��������� ���������� � ���,��� �������� ����� � ���� �����������.\n{FFFFFF}[ 10 ]{336633} ����� ����,��� �� ��������� ����������,������� ������� /lmenu � ������� ����� '{1ee01c}����� [������]{336633} '\n{FFFFFF}[ 11 ]{336633} �� ����� ���������� ������ ���������� ����� � /lmenu '{1ee01c}�����{336633}' ��������\n{FFFFFF}[ 12 ]{336633}  ����� ��������� ������,����� ������� /lmenu � �������� ����� ����� '�����' � ������ ���� �������� '{ff1100}����� [������]{336633}'\n{FFFFFF}[ 13 ]{336633} �������� � ���.����� � ���,��� �� ��������� ����� � ���� �����������.\n"
local pravilarank1 = "{336633}________________________________________________________________________________\n\n{FFFFFF}[ 1 ]{336633} ������ ��������� � {FFFFFF}1 {336633}�� {FFFFFF}2 {336633}�������� ����� ���� ����� ����� ������� �� ������� ( ���� ���������� )\n{FFFFFF}[ 2 ]{336633}��������� �� {FFFFFF}2 {336633}�� {FFFFFF}3 {336633}����������� ����� ���� ����� ����� ��������� ������� ������\n{FFFFFF}[ 3 ]{336633}��������� � {FFFFFF}3 {336633}�� {FFFFFF}5 {336633}����������� ����� ������� ����� ����� ��������� ���������� ������ ������ ��� �� �������� [ {FFFFFF}������ ��� ������ ������� : NGSA , PD {336633}]\n{FFFFFF}[ 4 ]{336633} ��������� ��� {FFFFFF}6 {336633}������ � ���� ���������� ������ �� ��������\n"
local obnovleniascripta1 = "{336633}________________________________________________________________________________\n\n{FFFFFF}[ 1 ]{336633} ����� 0.1 ������ �������: {FFFFFF}[ 18.07.2020 ].\n{FFFFFF}[ 2 ]{336633} ����� 0.2 ������ �������: {FFFFFF}[ 26.07.2020 ].\n{336633}________________________________________________________________________________"
local authors1 = "{336633}________________________________________________________________________________\n\n{FFFFFF}- {336633}Wayne Rothschild\n{FFFFFF}| {336633}vk.com/avdeenkoo10\n{FFFFFF}- {336633}Englebert Rothschild\n{FFFFFF}| {336633}vk.com/enyag\n{FFFFFF}- {336633}Lucifer Rothschild\n{FFFFFF}| {336633}vk.com/xrubons\n{FFFFFF}- {336633}Bernard Rothschild\n{FFFFFF}| {336633}vk.com/pluha28003\n{FFFFFF}\n{336633}________________________________________________________________________________"
local zzachistkaa2 = "{336633}________________________________________________________________________________\n\n{FFFFFF}- {336633}����� �������:\n {FFFFFF}| {336633}����������� ������ �������� � �������� ����� ���, ��� ��� ����������� ���������� ����� ����� ���������� �����������.\n {FFFFFF}| {336633}����� ���, ��� �������� ��������, ����������� ������ ��������� � �������� ��� �������, ������� ����� �����������.\n {FFFFFF}| {336633}����� ���, ��� �������� ��������, ����������� ������ ������� ����.\n {FFFFFF}| {336633}�������� ��������: ������� N.G.S.A, ������� �.�.�, ������� �.�.�, ������� �.�.\n {FFFFFF}| {336633}��� ����������, ����������� � ��������, ����������� ������������.\n {FFFFFF}| {336633}� �������� ����� ����������� ��� ���������� ��: S.W.A.T, N.G.S.A, L.S.P.D, F.B.I.\n {FFFFFF}| {336633}����� ���������� �����������, ������ ���� �������� � ������.\n {FFFFFF}| {336633}�������� ���������� ����������� �� ���������� �� ���������� � ������� � ��������������� �������.\n {FFFFFF}| {336633}�� ����� ��������, ������ ���������� �����������, �������� 6 ������� ������� �� ������: 'z' = '��������'\n{FFFFFF}- {336633}������� �� ����� ��������:\n {FFFFFF}| {336633}��������� ������������ ������� ������������ ��������.\n{FFFFFF} | {336633}��������� ������������� ������������ � ����� ������������ ���������� ��������.\n{FFFFFF} | {336633}��������� ���������� �������� � ����� ������������ �� ����� �� ����������.\n{FFFFFF} | {336633}�� �������� �� ����� ��������������: ���. �����, �������������, ������������� ������ F.B.I.\n{FFFFFF}- {336633}������� ���������� ��������:\n{FFFFFF} | {336633}����������� ��������� �� ���� ����������� � ������� 2+ �������.\n{FFFFFF} | {336633}�������� ��� ��������� �� ������������������ ���.\n{FFFFFF} | {336633}������ � ��������� ������ ��� ������ ��� � ������� 2+ �������.\n{FFFFFF} | {336633}��������� ������������������ ��� � ������� 2+ �������.\n{FFFFFF} | {336633}����������� �������.\n{FFFFFF} | {336633}������ ������ ���. ����������� � ������� 2+ �������.\n{FFFFFF} | {336633}���� ������������� � ���. ����������� � ������� 2+ �������.\n{FFFFFF} | {336633}������������� �� �������� ���������� � �����: �����, ��������� ����������� ��� �������� � ������� 2+ �������.\n{FFFFFF}- {336633}������ �����������, ������� ����� ��������:\n{FFFFFF} | {336633}Yakuza Mafia.\n{FFFFFF} | {336633}Russian Mafia.\n{FFFFFF} | {336633}Arabian Mafia.\n{FFFFFF} | {336633}Triada Mafia.\n{FFFFFF} | {336633}Cosa Nostra.\n{FFFFFF} | {336633}������������� ���� Groove Street.\n{FFFFFF} | {336633}������������� ���� Ballas.\n{FFFFFF} | {336633}������������� ���� Vagos.\n{FFFFFF} | {336633}������������� ���� Los Aztecas.\n\n{336633}________________________________________________________________________________\n"

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
	
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}*{336633}������� ������� �����, ������������ {FFFFFF}N.G.S.A Helper. {336633}������ �������: {FFFFFF}0.3*", 0x336633)
    sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}*{336633}National Guard of San Andreas | {FFFFFF}Pears Project. {336633}��������� � �������: {FFFFFF}/ngsa*", 0x336633)

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
    sampSendChat(string.format("/clear %s ������", id))
  else
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ������ ������� {336633}[/cl ID ]", 0x336633)
  end
end

function cmd_imgui(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v or show_2_window.v
end

function lmenu()
	lua_thread.create(function()
    sampSendChat("/lmenu")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* � ������ {336633}��������� ����.", 0x336633)
	end)
end

function members()
	lua_thread.create(function()
    sampSendChat("/members")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* � ������ {336633}������ ���������� ����������� ", 0x336633)
	end)
end

function posadka()
	lua_thread.create(function()
    sampSendChat("/v ��� �� �������!")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* � ������� � {336633}�������", 0x336633)
	end)
end

function vzlet()
	lua_thread.create(function()
    sampSendChat("/v �������!")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* � ������� � {336633}������", 0x336633)
	end)
end

function usehelm()
    lua_thread.create(function()
    sampSendChat("/usehelm", 0x336633)
    end)
end

function zams()
    lua_thread.create(function()
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* � ������ ������ {336633}������������.", 0x336633)
	sampSendChat("/zams", 0x336633)
    end)
end

function admins()
    lua_thread.create(function()
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* � ������ ������ {336633}�������������.", 0x336633)
    sampSendChat("/admins", 0x336633)
    end)
end

function leaders()
    lua_thread.create(function()
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* � ������ ������ {336633}�������..", 0x336633)
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
		sampSendChat("/me ����� �������.", 0x336633)
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
		sampSendChat("������ ����, ���.")
			wait(1000)
		sampSendChat("/ame �������� �������� �����������.")
			wait(2000)
		sampSendChat("������� � ����� ��������������?")
	elseif list == 1 then
		sampSendChat("������, ���. � ������ ��������� �� ���� ���������.")
			wait(2000)
		sampSendChat("���� ���� ������, ��: ID-�����, ������.")
	elseif list == 2 then
		sampSendChat("������ ������.")
			wait(2000)
		sampSendChat("��� ��������� � ���� ��� �������?")
	elseif list == 3 then
		sampSendChat("������ ������.")
			wait(2000)
		sampSendChat("����������� � �������� �����?")
	elseif list == 4 then
		sampSendChat("������ ������.")
			wait(2000)
		sampSendChat("������� ��� ���������� � �����?")
	elseif list == 5 then
		sampSendChat("������ ���������.")
			wait(2000)
		sampSendChat("����� ����� ������?")
	elseif list == 6 then
		sampSendChat("������ �����.")
			wait(2000)
		sampSendChat("������� ������� �����?")
	elseif list == 7 then
		sampSendChat("������ ������.")
			wait(2000)
		sampSendChat("������ ������ ������������ �������?")
	elseif list == 8 then
		sampSendChat("������ �������.")
			wait(2000)
		sampSendChat("��� ���������� � �������?")
	elseif list == 9 then
		sampSendChat("��������, �� �� ��� �� ��������� ��-�� ������� ������������ ���������.")
	elseif list == 10 then
		sampSendChat("��������, �� �� ��� �� ��������� ��-�� ���������� �������� ������.")
	elseif list == 11 then
		sampSendChat("��������, �� �� ��� �� ��������� ��-�� ���������� � ������ ������")
		wait(500)
		sampSendChat("/b ������ ������ ���������� ��� ������ ������ ������������")
	elseif list == 12 then
		sampSendChat("��������, �� �� ��� �� ��������� ��-�� ������ ����� ���������� � �����.")
		wait(500)
		sampSendChat("/b � ��� ����� ������ ���� ������� ���� 3.")
	elseif list == 13 then
		sampSendChat("��������, �� �� ��� �� ��������� ��-�� �������� �������� ����.")
	elseif list == 14 then
		sampSendChat("��������, �� �� ��� �� ��������� ��-�� ����.�������������.")
		wait(500)
		sampSendChat("/b �� �� ����������� ��.")
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
	sampSendChat("/v �������� �����! ��������� ����� ����������� �� ���������!")
		wait(1000)
	sampSendChat("/v ����� �� ���� - 10 �����! ���������� ������� ������� � ������ ����!")
	elseif list == 1 then
	sampSendChat("/v �������� �����! ��������� ����� ����������� ����� ����� ���� 51!")
		wait(1000)
	sampSendChat("/v ����� �� ���� - 10 �����! ���������� ������� ������� � ������ ����!")
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
	sampSendChat("/r ��������, �����! �� ���� 51 ��������� �������������!")
		wait(2000)
	sampSendChat("/r ��������� ������, ����� ������!")
	elseif list == 1 then
	sampSendChat("/r ��������, �����! �� ���� �.�.� ��������� �������������!")
		wait(2000)
	sampSendChat("/r ��������� ������, ����� ������!")
	elseif list == 2 then
	sampSendChat("/r // ���������, � ��� ���� �������.")
		wait(1000)
	sampSendChat("/r // ������: BJG3jhq.")
		wait(500)
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ������ �� ������� �����: {336633}https://discord.gg/BJG3jhq", 0x336633)
	elseif list == 3 then
	sampSendChat("/r ������� �������� � ���� ������-��������� ���. ���������..")
		wait(1000)
	sampSendChat("/r ..����� ������ �� �������, � ������� �.�.�, ����������.")
		wait(500)
	elseif list == 4 then
	sampSendChat("/r ������� �������� � ���� ������-������� ���. ���������..")
		wait(1000)
	sampSendChat("/r ..����� ������ �� �������, � ������� �.�.�, ����������.")
	elseif list == 5 then
	sampSendChat("/r �������� �����! ��������� ����� ����������� ����� ����� ���� 51!")
		wait(1000)
	sampSendChat("/r ����� �� ����: �.� 10 �����. �.�.� 10 �����. �.�.� 15 �����.")
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
	sampSendChat("/d ������ � ���������� �������.")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, ������ ������� �������� ����������� �����������.")
		wait(6000)
	sampSendChat("/gov Cosa Nostra. ������� �������, ������ �� ���������� � �������.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d ������ �� ���������� �������.")
	elseif list == 1 then
	sampSendChat("/d ������ � ���������� �������.")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, ������ ������� �������� ����������� �����������.")
		wait(6000)
	sampSendChat("/gov Yakuza Mafia. ������� �������, ������ �� ���������� � �������.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d ������ �� ���������� �������.")
	elseif list == 2 then
	sampSendChat("/d ������ � ���������� �������.")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, ������ ������� �������� ����������� �����������.")
		wait(6000)
	sampSendChat("/gov Triada Mafia. ������� �������, ������ �� ���������� � �������.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d ������ �� ���������� �������.")
	elseif list == 3 then
	sampSendChat("/d ������ � ���������� �������.")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, ������ ������� �������� ����������� �����������.")
		wait(6000)
	sampSendChat("/gov Russian Mafia. ������� �������, ������ �� ���������� � �������.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d ������ �� ���������� �������.")
	elseif list == 4 then
	sampSendChat("/d ������ � ���������� �������.")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, ������ ������� �������� ����������� �����������.")
		wait(6000)
	sampSendChat("/gov �������������� �����: Grove Street. ������ �� ���������� � �������.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d ������ �� ���������� �������.")
	elseif list == 5 then
	sampSendChat("/d ������ � ���������� �������.")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, ������ ������� �������� ����������� �����������.")
		wait(6000)
	sampSendChat("/gov �������������� �����: Ballas Gang. ������ �� ���������� � �������.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d ������ �� ���������� �������.")
	elseif list == 6 then
	sampSendChat("/d ������ � ���������� �������.")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, ������ ������� �������� ����������� �����������.")
		wait(6000)
	sampSendChat("/gov �������������� �����: Vagos Gang. ������ �� ���������� � �������.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d ������ �� ���������� �������.")
	elseif list == 7 then
	sampSendChat("/d ������ � ���������� �������.")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, ������ ������� �������� ����������� �����������.")
		wait(6000)
	sampSendChat("/gov �������������� �����: Los Aztecas Gang. ������ �� ���������� � �������.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d ������ �� ���������� �������.")
	elseif list == 8 then
	sampSendChat("/d ������ � ���������� �������.")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, ������ ������� �������� ����������� �����������.")
		wait(6000)
	sampSendChat("/gov Arabian Mafia. ������� �������, ������ �� ���������� � �������.")
		wait(1000)
	sampSendChat("/zachistka")
		wait(1000)
	sampSendChat("/d ������ �� ���������� �������.")
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
	sampSendChat("/r ��������� ����������� �/� �������. �� ��� ��������� 10 ������.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 1 then
	sampSendChat("/r ��������� ����������� �/� ������ X2. �� ��� ��������� 10 ������.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 2 then
 	sampSendChat("/r ��������� ����������� �/� ������ �4. �� ��� ��������� 10 ������.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 3 then
 	sampSendChat("/r ������� ������� �������. �� ��� ��������� 10 ������.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 4 then
 	sampSendChat("/r ������� ������� �������. �� ��� ��������� 10 ������.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 5 then
 	sampSendChat("/r ��������� ������� ������� �� ���� ���� 51. �� ��� ��������� 2 �����.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 6 then
 	sampSendChat("/r ��������� ������� ������� �� ���� �.�.�. �� ��� ��������� 2 �����.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 7 then
 	sampSendChat("/r ������� �/� �������. �� ��� ��������� 6 ������.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 8 then
 	sampSendChat("/r ������� �/� ������ X2. �� ��� ��������� 6 ������.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 9 then
 	sampSendChat("/r ������� �/� ������ X2. �� ��� ��������� 6 ������.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 10 then
 	sampSendChat("/r ��������� ����������� ������������ ������. �� ��� ��������� 10 ������.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 11 then
 	sampSendChat("/r ��������� ��������� ��������� � ����������. �� ��� ��������� 10 ������.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 12 then
 	sampSendChat("/r ��������� ����������� ��������� ������. �� ��� ��������� 10 ������.")
	wait(1000)
	sampSendChat("/r // /time + F8")
	elseif list == 13 then
 	sampSendChat("/r ���������� ��������� �� ���������. �� ��� ��������� 6 ������.")
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
	sampSendChat("/d �����!")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, ������ ������� �������������� � ������������ �������.")
		wait(6000)
	sampSendChat("/gov ��� ����������� �� ������ ���������. ID-����� | ������ | ������� �����. ���� � ����������.")
		wait(1000)
	sampSendChat("/d ������� �������!")
		wait(1000)
	sampSendChat("/time")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ����� ������� ����� � {336633}[ /lmenu ]{FFFFFF}.")
	elseif list == 1 then
    sampSendChat("/d �����!")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, �������������� � ������������ ������� ���������.")
		wait(6000)
	sampSendChat("/gov ���������� ������� �� ����������.")
		wait(1000)
	sampSendChat("/d ������� �������!")
		wait(1000)
	sampSendChat("/time")
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ����� ������� ����� � {336633}[ /lmenu ]{FFFFFF}.")
	elseif list == 2 then
    sampSendChat("/d �����!")
		wait(1000)
	sampSendChat("/gov ��������� ������ �����, ������� ��������� �� ����������� ������.")
		wait(6000)
	sampSendChat("/gov ��������� ���������� �� ������� �����.")
		wait(1000)
	sampSendChat("/d ������� �������!")
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
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ � ������.")
	wait(5000)
	sampSendChat("/z �� ����� ������� �����, ����������� ������ ���� ������")
	wait(5000)
	sampSendChat("/z ����������� ����-������� �����. ������� ���� - ����� ����� ���. ��������� ������..")
	wait(5000)
	sampSendChat("/z ..����� 5 �����. ����� �����.")
	wait(5000)
	sampSendChat("/z ����������� ����-������� �����. ���� - �����. ��������� - (����������, �����������)..")
	wait(5000)
	sampSendChat("/z ..����� �����.")
	wait(5000)
	sampSendChat("/z ���� ���� ������ � ������� �����, ��� ������ ������� � ������� ������������.. ")
	wait(5000)
	sampSendChat("/z ..� ������ ���� �� ����������. (���� �������).")
	wait(5000)
	sampSendChat("/z ����������� ������ ������ 10 �����.")
	wait(5000)
	sampSendChat("/z ��� ������ � ������ ��� ������ �� �����.")
	wait(5000)
	sampSendChat("/z ������ �����������, � �� �������� ������ ������. ��� ��������!")
	wait(5000)
	sampSendChat("/me ������ ������..")
	elseif list == 1 then
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ �� ������������.")
	wait(5000)
	sampSendChat("/z � ����� ���, �� �� ������ ����������� ������ ������ �����. � ��� ��� ����..")
	wait(5000)
	sampSendChat("/z ..����� , �� , ��� , ������.")
	wait(5000)
	sampSendChat("/z ������� ������� ������. �������� � �������-�������, � ��� ����� ����������..")
	wait(5000)
	sampSendChat("/z � �������� �������, ����� ��� �������� ����.")
	wait(5000)
	sampSendChat("/z �������, ����, ��������� ����������?")
	wait(5000)
	sampSendChat("/z ����� ������� �� �� ������������ �����-��������, �������..")
	wait(5000)
	sampSendChat("/z �� ������� � ����� �����.")
	wait(5000)
	sampSendChat("/z �� ���� ���������� ������ �� ������, �������.")
	wait(5000)
	sampSendChat("/z � �������: ������� ��������, ����� ����������� ��������.")
	wait(5000)
	sampSendChat("/z ���������� �� ���� ����������� ������ �� ��, ������ �����.")
	wait(5000)
	sampSendChat("/z ��������� ����� ���� �� �������� �� ������.")
	wait(5000)
	sampSendChat("/z �� �� ���������� ������������, �� ��������� ������� � ������ ����..")
	wait(5000)
	sampSendChat("/z ��� ��� ��� ������� ������ ������������ �������.")
	wait(5000)
	sampSendChat("/z �� ������������ �� ���������� ������������, ���� ����� ����� ��������..")
	wait(5000)
	sampSendChat("/z ..� ������ � ���. �������.")
	wait(5000)
	sampSendChat("/z ��� ������ � ������ ��� ������ �� �����.")
	wait(5000)
	sampSendChat("/z ������ �����������, � �� �������� ������ ������. ��� ��������!")
	wait(5000)
	sampSendChat("/me ������ ������..")
	elseif list == 2 then
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ �� �������� ����������.")
	wait(5000)
	sampSendChat("/z ������ ����� �� ������� ������ ����-�������, ���������.. ")
	wait(5000)
	sampSendChat("/z ..����� ����� ���� ���������..")
	wait(5000)
	sampSendChat("/z ..NGSA ��� ���������� �������� �������.")
	wait(5000)
	sampSendChat("/z �������� ���������, ������������ ���: ����������, ��������, ������..")
	wait(5000)
	sampSendChat("/z ..�����������, ������.")
	wait(5000)
	sampSendChat("/z ��������� ��������� ����� ������ ����� ���������� ��������.")
	wait(5000)
	sampSendChat("/z ���� �� �� �� ���� ������, �����..")
	wait(5000)
	sampSendChat("/z ..����� ������� � ������ ����.")
	wait(5000)
	sampSendChat("/z ��������: Hydra , Rustler ����� ������ ��� �������� ������, �������..")
	wait(5000)
	sampSendChat("/z ��� �� ������� ��������.")
	wait(5000)
	sampSendChat("/z ��� ������ � ������ ��� ������ �� �����.")
	wait(5000)
	sampSendChat("/z ������ �����������, � �� �������� ������ ������. ��� ��������!")
	wait(5000)
	sampSendChat("/me ������ ������..")
	elseif list == 3 then
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ �� ��������� � �����.")
	wait(5000)
	sampSendChat("/z ��� ������� ��������� ����������, ����� ������� ��� ������� �����.")
	wait(5000)
	sampSendChat("/z �� ���������� ��� �����: 10 ����� ��� �� � ���, 15 ����� ��� ���.")
	wait(5000)
	sampSendChat("/z ���� �� �� ������ ������� � ����� �� �����, ��� �����..")
	wait(5000)
	sampSendChat("/z ..���������� � ��������, �������..")
	wait(5000)
	sampSendChat("/z .. ��������� �������� �� ���������, � ����� ����� � �����.")
	wait(5000)
	sampSendChat("/z � ����� ��������� ������� ������, �������� �� ����, ����� ������..")
	wait(5000)
	sampSendChat("/z ..�������� �� ��������.")
	wait(5000)
	sampSendChat("/z �������� ����� ��� ���������� ������.")
	wait(5000)
	sampSendChat("/z ���� �� �� ����� ����� ������� ���������, ��� ������ �� ��������� �����..")
	wait(5000)
	sampSendChat("/z ..��������� ���������� ��������.")
	wait(5000)
	sampSendChat("/z �� �� ���������� ���� ������ ����� ������, �� ����� �������.")
	wait(5000)
	sampSendChat("/z ��� ������ � ������ ��� ������ �� �����.")
	wait(5000)
	sampSendChat("/z ������ �����������, � �� �������� ������ ������. ��� ��������!")
	wait(5000)
	sampSendChat("/me ������ ������..")
	elseif list == 4 then
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ �� �����������.")
	wait(5000)
	sampSendChat("/z ��� ����� ����������? ������� ��������.")
	wait(5000)
	sampSendChat("/z ���������� - ����������, ���������� ������������, ������������..")
	wait(5000)
	sampSendChat("/z ..�� �������� ������ ������ � ����.")
	wait(5000)
	sampSendChat("/z ������� ���������, ��������� �� �� ��� �����..")
	wait(5000)
	sampSendChat("/z ..��� ������� ��������� � �����.")
	wait(5000)
	sampSendChat("/z ������ - ��������� �������, � ������� �� ������.")
	wait(5000)
	sampSendChat("/z ������ - ������������ ������ ������ �� �������.")
	wait(5000)
	sampSendChat("/z ������ - �� �������� �����, ������ �� �������.")
	wait(5000)
	sampSendChat("/z ��������� - �� �������� �������!")
	wait(5000)
	sampSendChat("/z ����� - ���� � ��� ���������� �����, ��� ��������..")
	wait(5000)
	sampSendChat("/z ..�����-�� ������, �� � �����..")
	wait(5000)
	sampSendChat("/z ..����������� � ������� �� ���� � ����������.")
	wait(5000)
	sampSendChat("/z ������ - � ���������� ������, �� � ����� �� ����� �� ���������� � ��������.")
	wait(5000)
	sampSendChat("/z �����, � ������� �� ��� ���������, ���� ����� ������� ���������..")
	wait(5000)
	sampSendChat("/z ..����� ������ �� ���. �������� ������.")
	wait(5000)
	sampSendChat("/z ��� ������ � ������ ��� ������ �� �����.")
	wait(5000)
	sampSendChat("/z ������ �����������, � �� �������� ������ ������. ��� ��������!")
	wait(5000)
	sampSendChat("/me ������ ������..")
	elseif list == 5 then
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ ��� �����������.")
	wait(5000)
	sampSendChat("/z ���� �������������� ������ - ������ � ������ ����.")
	wait(5000)
	sampSendChat("/z �������� ���� ��� �������������� � � ����� - ������ �������..")
	wait(5000)
	sampSendChat("/z ..��� ����������.")
	wait(5000)
	sampSendChat("/z ��������� ������� � 12:00 �� 14:00, �� ���..")
	wait(5000)
	sampSendChat("/z ..����� �� ������� �������� ������ ������.")
	wait(5000)
	sampSendChat("/z ������� ���� ���������� � 8:00 ���� �� 20:00 ������.")
	wait(5000)
	sampSendChat("/z ������ ������������ �� ����, ����� ������ ��� ���������..")
	wait(5000)
	sampSendChat("/z ..�� ����������� ����� ��������� �����.")
	wait(5000)
	sampSendChat("/z ��������� ����� �� �������� �� ������.")
	wait(5000)
	sampSendChat("/z ����������� ���������� ��� ����������� ������� ��������...")
	wait(5000)
	sampSendChat("/z ... �� ������� �� ����������� ������� �����.")
	wait(5000)
	sampSendChat("/z ��� ������ � ������ ��� ������ �� �����.")
	wait(5000)
	sampSendChat("/z ������ �����������, � �� �������� ������ ������. ��� ��������!")
	wait(5000)
	sampSendChat("/me ������ ������..")
	elseif list == 6 then
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ � ��������.")
	wait(5000)
	sampSendChat("/z ������ ���� ���. ������� ������ ����������..")
	wait(5000)
	sampSendChat("/z ..�� ������� ���� � ������� �������� ���.")
	wait(5000)
	sampSendChat("/z ������� ���� ���������� � 8:00 �� 20:00.")
	wait(5000)
	sampSendChat("/z ��� ������ ���, ������ ����� � 12:00 �� 14:00.")
	wait(5000)
	sampSendChat("/z ���� ���-�� �������� ������������ ���� ��� ������...")
	wait(5000)
	sampSendChat("/z ...�� � ��� ���� ��������� �������.")
	wait(5000)
	sampSendChat("/z ��� ������ � ������ ��� ������ �� �����.")
	wait(5000)
	sampSendChat("/z ������ �����������, � �� �������� ������ ������. ��� ��������!")
	wait(5000)
	sampSendChat("/me ������ ������..")
	elseif list == 7 then
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ � ��������� ���������.")
	wait(5000)
	sampSendChat("/z ������� �����������, � �������.")
	wait(5000)
	sampSendChat("/z ������� ����� �������� ��:")
	wait(5000)
	sampSendChat("/z ...����������� �������� �� ����� ������� ������..")
	wait(5000)
	sampSendChat("/z ...��� �� �����;...")
	wait(5000)
	sampSendChat("/z ...�� ��������� ����� � ������� �����, �� ���������� ������������;...")
	wait(5000)
	sampSendChat("/z ...������������ �������� ������� �� ������, ������������ ��;...")
	wait(5000)
	sampSendChat("/z ...��������� �� ������, ����������� ��� ����������� ��.")
	wait(5000)
	sampSendChat("/z �� ���� ������ ��������, ������� ��� ����� ���� ������������ �����, �����...")
	wait(5000)
	sampSendChat("/z ...���� ������������ ��� ���� ���������� � �� �������� ��� �������.")
	wait(5000)
	sampSendChat("/z ��� ������ � ������ ��� ������ �� �����.")
	wait(5000)
	sampSendChat("/z ������ �����������, � �� �������� ������ ������. ��� ��������!")
	wait(5000)
	sampSendChat("/me ������ ������..")
	elseif list == 8 then
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ � ��������.")
	wait(5000)
	sampSendChat("/z ��������������� ��������� �������� ��� ������� �� ����������� �����.")
	wait(5000)
	sampSendChat("/z ����� �����, ���� ������ ��. ���������� ��������� ���������� �������� ����������.")
	wait(5000)
	sampSendChat("/z ��������������� ��������� ������������ ��������� ��������� � ������ �����.")
	wait(5000)
	sampSendChat("/z ����� ����� ��������� ���������� ����������� ������.")
	wait(5000)
	sampSendChat("/z ��������� ��������� �������� ������, ������..")
	wait(5000)
	sampSendChat("/z ..������� ������, ����� ������������, � ���.")
	wait(5000)
	sampSendChat("/z ��� ������ � ������ ��� ������ �� �����.")
	wait(5000)
	sampSendChat("/z ������ �����������, � �� �������� ������ ������. ��� ��������!")
	wait(5000)
	sampSendChat("/me ������ ������..")
	elseif list == 9 then
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ ��� ������ ���������� �����.")
	wait(5000)
	sampSendChat("/z ���� ����������� ������� �� ����������� ����.")
	wait(5000)
	sampSendChat("/z ��������� ������� �� ������.")
	wait(5000)
	sampSendChat("/z �� ��������� ������ ��, ������ ������� � ������ ����.")
	wait(5000)
	sampSendChat("/z ���������� �� ����� ����������� ������ �� ��.")
	wait(5000)
	sampSendChat("/z ��������� ��������� ����� ��� ������� �� ��.")
	wait(5000)
	sampSendChat("/z �� ����� ������� �����, ����� ����������� ����� �������.")
	wait(5000)
	sampSendChat("/z ���� ��� ����� �������� ����, �..")
	wait(5000)
	sampSendChat("/z ..����� � ����, �������� �������� �� ������.")
	wait(5000)
	sampSendChat("/z �� ���� ������ ��������. �������� ����.")
	wait(5000)
	sampSendChat("/me ������ ������..")
	elseif list == 10 then
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ ��� ������-������� ���..")
	wait(5000)
	sampSendChat("/z �� ��������� ������ ���, ������ ������� � ������ ����.")
	wait(5000)
	sampSendChat("/z ���� ����������� ������� �� �����..")
	wait(5000)
	sampSendChat("/z ..�������� �, � �� ������ �������� ��.")
	wait(5000)
	sampSendChat("/z ������ ����������� �������� �������.")
	wait(5000)
	sampSendChat("/z ��������� �������� ���� �� ������ ����� � ������� �����.")
	wait(5000)
	sampSendChat("/z ��������� ���. ������ � �����, ������ ��������� ��� ����.")
	wait(5000)
	sampSendChat("/z �� ����� ������� �����, ����� ��������..")
	wait(5000)
	sampSendChat("/z ..� �����, � ������������ ���������.")
	wait(5000)
	sampSendChat("/z �� ���� ���, ���� ����, �� ������!")
	wait(5000)
	sampSendChat("/me ������ ������..")
	elseif list == 11 then
	sampSendChat("/z �����, �����������!")
	wait(5000)
	sampSendChat("/me ������ ������, ����� �������� ����.")
	wait(5000)
	sampSendChat("/z ������� �������� ������ ��� ������-��������� ���..")
	wait(5000)
	sampSendChat("/z ��������� ����� ������ ��������� Hydra..")
	wait(5000)
	sampSendChat("/z ..Rustler , Nevada � ������ ����.")
	wait(5000)
	sampSendChat("/z �� ����� ����������� ����� �.")
	wait(5000)
	sampSendChat("/z ..������� �������� � ������������ ���.")
	wait(5000)
	sampSendChat("/z ������� �� ���.")
	wait(5000)
	sampSendChat("/z �� �������� ����� ���, �� ���������, ������� � ������ ����.")
	wait(5000)
	sampSendChat("/z �������� ������ ��, ���, ���� �� �� ���� ����������.")
	wait(5000)
	sampSendChat("/z �� ��������� �������� �� ���. ���������� �����.")
	wait(5000)
	sampSendChat("/z ����� �������, �������� �����, ������!")
	wait(5000)
	sampSendChat("/z ����� �������, ��������� ������� �� ���. ���������.")
	wait(5000)
	sampSendChat("/z ����������� ������� � ������� ��� ���������� ����������.")
	wait(5000)
	sampSendChat("/z �� ���� � ���� ���, ���� ���� �������..")
	wait(5000)
	sampSendChat("/z ..��������� ����� ������, ��� ��������.")
	wait(5000)
	sampSendChat("/me ������ ������..")
	else
				end
			end
		end
	end
end

function lektcii(arg)
	sampShowDialog(17130, "{FFFFFF}N.G.S.A Helper | ���������� ������", string.format("[ 1 ] ������ � ������\n[ 2 ] ������ �� ������������\n[ 3 ] ������ �� �������� ����������\n[ 4 ] ������ �� ��������� � �����\n[ 5 ] ������ �� ��������� �� ����� ���������� \n[ 6 ] ������ ��� �����������\n[ 7 ] ������ � ��������\n[ 8 ] ������ � ��������� ���������\n[ 9 ] ������ � ��������\n[ 10 ] ������ ��� ������ ��\n[ 11 ] ������ ��� ���������� ���\n[ 12 ] ������ ��� ������ ���"), "�������", "�������", 2)
	lua_thread.create(lektcii1)
end

function vidachazadaniy(arg)
	sampShowDialog(17132, "{FFFFFF}N.G.S.A Helper | ���� ������ �������", string.format("[ 1 ] ��������� ����������� �������� | 10 ������\n[ 2 ] ��������� ����������� ������� �2 | 10 ������\n[ 3 ] ��������� ����������� ������� �4 | 10 ������\n[ 4 ] ������ ������� ������� | 10 ������\n[ 5 ] ������ ������� ������� | 10 ������\n[ 6 ] �������� ������� ���� 51 | 2 �����\n[ 7 ] �������� ������� �.�.� | 2 �����\n[ 8 ] ������ ������� | 6 ������\n[ 9 ] ������ ������ �2 | 6 ������\n[ 10 ] ������ ������ �4 | 6 ������\n[ 11 ] ����������� ������������ ������. | 10 ������\n[ 12 ] ��������� ��������� � ���������� | 10 ������\n[ 13 ] ����������� ��������� ������ | 10 ������\n[ 14 ] ��������� ���������� | 6 ������"), "�������", "�������", 2)
	lua_thread.create(vidachazadaniy1)
end

function government(arg)
	sampShowDialog(17130, "{FFFFFF}N.G.S.A Helper | ������ ��������������� �����", string.format("[ 1 ] � ������ �������\n[ 2 ] � ����� �������\n[ 3 ] � ����������� ������"), "�������", "�������", 2)
	lua_thread.create(government1)
end

function racia(arg)
	sampShowDialog(17128, "{FFFFFF}N.G.S.A Helper | �����: R", string.format("[ 1 ] ������������� ���� 51\n[ 2 ] ������������� �.�.�\n[ 3 ] ������� �����\n[ 4 ] ���������� �.�.�\n[ 5 ] ���������� �.�.�\n[ 6 ] �������� ����������"), "�������", "�������", 2)
	lua_thread.create(racia1)
end

function departament(arg)
	sampShowDialog(12861, "{FFFFFF}N.G.S.A Helper | �����: �����������", string.format("[ 1 ] ������������� ���� 51\n[ 2 ] ������������� �.�.�"), "�������", "�������", 2)
	lua_thread.create(departament1)
end

function pr(arg)
	sampShowDialog(17126, "{FFFFFF}N.G.S.A Helper | ������", string.format("[ 1 ] �������������\n[ 2 ] �������� ����������\n[ 3 ] ������ 1\n[ 4 ] ������ 2\n[ 5 ] ������ 3\n[ 6 ] ������ 4\n[ 7 ] ������ 5\n[ 8 ] ������ 6\n[ 9 ] ������ 7\n[ 10 ] �����: ����. ����\n[ 11 ] �����: ������� �����\n[ 12 ] �����: ���/���\n[ 13 ] �����: ��������� ���\n[ 14 ] �����: ������� ���\n[ 15 ] �����: ����.�������������"), "�������", "�������", 2)
	lua_thread.create(prizivinvites)
end

function formavvs(arg)
	sampShowDialog(1717, "{FFFFFF}N.G.S.A Helper | ����� ������-��������� ���", string.format("[ 1 ] ������ �����\n[ 2 ] ����� �����"), "�������", "�������", 2)
	lua_thread.create(formavvs1)
end

function vracia1(arg)
	sampShowDialog(17129, "{FFFFFF}N.G.S.A Helper | �����: V", string.format("[ 1 ] ���������� �.�.�\n[ 2 ] ���������� �.�.�"), "�������", "�������", 2)
	lua_thread.create(vracia)
end

function zzachistka1(arg)
	sampShowDialog(17371387, "{FFFFFF}N.G.S.A Helper | ���� ��������", string.format("[ 1 ] {d6db39}Cosa Nostra\n[ 2 ] {bd0f0f}Yakuza Mafia\n[ 3 ] {132054}Triada Mafia\n[ 4 ] {141414}Russian Mafia\n[ 5 ] {05ad16}Grove Street\n[ 6 ] {9215ab}Ballas Gang\n[ 7 ] {bfb71b}Vagos Gang\n[ 8 ] {10abc7}Los Aztecas Gang\n[ 9 ] {6e5003}Arabian Mafia"), "�������", "�������", 2)
	lua_thread.create(zzachistka)
end

function ngsa(arg)
    sampShowDialog(1970, "{FFFFFF}N.G.S.A Helper | ����������", textdialog, "*", "", 0)
end

function dpravila(arg)
    sampShowDialog(1971, "{FFFFFF}N.G.S.A Helper | ������� ������������� ���� ������������", praviladepartamenta, "*", "", 0)
end
	
function govpravila(arg)
    sampShowDialog(1976712, "{FFFFFF}N.G.S.A Helper | ������� ������������� ��������������� �����", pravilagosvolny2, "*", "", 0)
end
	
function pravilarank(arg)
    sampShowDialog(1976714, "{FFFFFF}N.G.S.A Helper | ������� ��������� ����� �� �������", pravilarank1, "*", "", 0)
end

function updates(arg)
    sampShowDialog(19767271, "{FFFFFF}N.G.S.A Helper | ���������� �������", obnovleniascripta1, "*", "", 0)
end

function authors(arg)
    sampShowDialog(19767279, "{FFFFFF}N.G.S.A Helper | ������ �������", authors1, "*", "", 0)
end

function zzachistka2(arg)
    sampShowDialog(19767280, "{FFFFFF}N.G.S.A Helper | ������� ���������� ��������", zzachistkaa2, "*", "", 0)
end

function calc(params)
    if params == '' then
        sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* �����������: {336633}[ ������ ]{FFFFFF}.", -1)
    else
        local func = load('return ' .. params)
        if func == nil then
            sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ������..", -1)
        else
            local bool, res = pcall(func)
            if bool == false or type(res) ~= 'number' then
                sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ��� �� ������� �� ���..", -1)
            
            else
                sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ��������� {336633}" .. res, -1)
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
			else sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}*���������� ����� ������ {336633}[ /fd ID ]{FFFFFF}.", -1)
			end
		else sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ������ ����� {336633}�� � ����{FFFFFF}.", -1)
		end
	else
		sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ���������� ����� {336633}���������{FFFFFF}.", -1)
		confind = false
	end
end

function postoyanniypursuit(param)
  local id = string.match(param, '%s*(.+)')
  if id ~= nil then
    sampSendChat(string.format("/pursuit %s", id))
  else
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ������� {FFFFFF}PURSUIT {336633} [/pu ID ]", 0x336633)
  end
end

function kinytshipi(param)
  local id = string.match(param, '(%d+)')
  if id ~= nil then
  
	sampSendChat(string.format("/ship %d", id))
  else
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ������ ���� ��� ������ {336633} [/sh ID ]", 0x336633)
  end
end

function checkwanted(param)
  local id = string.match(param, '(%d+)')
  if id ~= nil then
    sampSendChat(string.format("/wanted %d", id))
  else
	sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ���������� ���������� ����� {336633} [/wd ID ]", 0x336633)
  end
end

function nickid(params)
    id = tonumber(params)
    if params and id ~= nil then
        nick = sampGetPlayerNickname(id)
        result = sampIsPlayerConnected(id)
		level = sampGetPlayerScore(id)
        if result then
            sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* {336633}ID: {FFFFFF}" .. id .. ". {336633}��� �������: {FFFFFF}" .. nick .. ". {336633}�������: {FFFFFF}" .. level .. ".", -1)
        else
            sampAddChatMessage("{336633}[N.G.S.A] {FFFFFF}* ����� �������", -1)
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
		imgui.Text(u8"�����: " .. city[getCityPlayerIsIn(PLAYER_HANDLE)] .. " | HP: " .. Health .. " | AHP: " .. Armor, main_color)
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