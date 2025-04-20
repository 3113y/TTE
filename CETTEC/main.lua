mod = RegisterMod("CET", 1)
--调用四个table
require("CET4_1")
require("CET4_2")
require("CET6_1")
require("CET6_2")
if rem_num == nil then
    rem_num = 20
end
--table初始化
Word_CN = {}
Word_EN = {}
Word_spe_uk = {}
Word_spe_us = {}
Word_rem_num = {}
Word_appear = {}
TRUE_TIMES_TO_ACHIEVE = 3
index = 0
--随机不重复数表的生成
function GetUniqueRandomNumbers(n, min, max)
    local result = {}
    local generated = {}
    math.randomseed(os.time()) -- 设置随机种子，保证每次运行结果不同
    while #result < n do
        local num = math.random(min, max)
        if index == 0 then
            if not generated[num] and CET4_SHORT[num].rem_num <= TRUE_TIMES_TO_ACHIEVE then
                table.insert(result, num)
                generated[num] = true
            end
        elseif index == 1 then
            if not generated[num] and CET4[num].rem_num <= TRUE_TIMES_TO_ACHIEVE then
                table.insert(result, num)
                generated[num] = true
            end
        elseif index == 2 then
            if not generated[num] and CET6_SHORT[num].rem_num <= TRUE_TIMES_TO_ACHIEVE then
                table.insert(result, num)
                generated[num] = true
            end
        elseif index == 3 then
            if not generated[num] and CET6[num].rem_num <= TRUE_TIMES_TO_ACHIEVE then
                table.insert(result, num)
                generated[num] = true
            end
        end
    end
    return result
end

--table获取
Lexicon_num_list = { 1162, 3739, 1228, 2345 }
if index == 0 then
    CET4_SHORT_rem_list = GetUniqueRandomNumbers(rem_num, 1, 1162)
    for i = 1, rem_num do
        Word_CN[i] = CET4_SHORT[CET4_SHORT_rem_list[i]].translation
        Word_EN[i] = CET4_SHORT[CET4_SHORT_rem_list[i]].word
        Word_spe_uk[i] = CET4_SHORT[CET4_SHORT_rem_list[i]].uk
        Word_spe_us[i] = CET4_SHORT[CET4_SHORT_rem_list[i]].us
        Word_rem_num[i] = CET4_SHORT[CET4_SHORT_rem_list[i]].rem_num
        Word_appear[i] = 0
    end
elseif index == 1 then
    CET4_rem_list = GetUniqueRandomNumbers(rem_num, 1, 3739)
    for i = 1, rem_num do
        Word_CN[i] = CET4[CET4_rem_list[i]].translation
        Word_EN[i] = CET4[CET4_rem_list[i]].word
        Word_spe_uk[i] = CET4[CET4_rem_list[i]].uk
        Word_spe_us[i] = CET4[CET4_rem_list[i]].us
        Word_rem_num[i] = CET4[CET4_rem_list[i]].rem_num
        Word_appear[i] = 0
    end
elseif index == 2 then
    CET6_SHORT_rem_list = GetUniqueRandomNumbers(rem_num, 1, 1228)
    for i = 1, rem_num do
        Word_CN[i] = CET6_SHORT[CET6_SHORT_rem_list[i]].translation
        Word_EN[i] = CET6_SHORT[CET6_SHORT_rem_list[i]].word
        Word_spe_uk[i] = CET6_SHORT[CET6_SHORT_rem_list[i]].uk
        Word_spe_us[i] = CET6_SHORT[CET6_SHORT_rem_list[i]].us
        Word_rem_num[i] = CET6_SHORT[CET6_SHORT_rem_list[i]].rem_num
        Word_appear[i] = 0
    end
elseif index == 3 then
    CET6_rem_list = GetUniqueRandomNumbers(rem_num, 1, 2345)
    for i = 1, rem_num do
        Word_CN[i] = CET6[CET6_rem_list[i]].translation
        Word_EN[i] = CET6[CET6_rem_list[i]].word
        Word_spe_uk[i] = CET6[CET6_rem_list[i]].uk
        Word_spe_us[i] = CET6[CET6_rem_list[i]].us
        Word_rem_num[i] = CET6[CET6_rem_list[i]].rem_num
        Word_appear[i] = 0
    end
end

-- 菜单与窗口设置
ImGui.CreateMenu("mainmenu", "CET-4?CET-6!")
ImGui.AddElement("mainmenu", "rem_window", ImGuiElement.MenuItem, "单词记忆")
ImGui.AddElement("mainmenu", "tes_window", ImGuiElement.MenuItem, "单词测试")
ImGui.AddElement("mainmenu", "set_window", ImGuiElement.MenuItem, "设置")
ImGui.CreateWindow("CET_REM", "单词记忆")
ImGui.CreateWindow("CET_TES", "单词测试")
ImGui.CreateWindow("CET_SET", "设置")
ImGui.LinkWindowToElement("CET_REM", "rem_window")
ImGui.LinkWindowToElement("CET_TES", "tes_window")
ImGui.LinkWindowToElement("CET_SET", "set_window")
-- 设置界面
ImGui.AddCombobox("CET_SET", "word_type_chose", "词库选择", function(index, val) print(index, val) end,
    { "四级精简版(1162词)", "四级(3739词)", "六级精简版(1228词)", "六级(2345词)" }, 0, false)
ImGui.AddInputInteger("CET_SET", "word_num_chose", "每局单词数", function(num)
    rem_num = num
end, 20, 5, 10)

ImGui.AddInputText("CET_SET", "CET_search", "请输入该词库中要找的单词", function(value) word_to_search = value end, "", "Word")
ImGui.AddButton("CET_SET", "CET_SET_CONFIRM", "确认搜索", function()
    if index == 0 then
        for sreach_i = 1, Lexicon_num_list[index + 1] do
            if CET4_SHORT[sreach_i].word == word_to_search then
                ImGui.UpdateData("CET_SET_TRANSLATION", ImGuiData.Label, CET4_SHORT[sreach_i].translation)
                ImGui.UpdateData("CET_SET_NUM", ImGuiData.Label, CET4_SHORT[sreach_i].rem_num)
            end
        end
    elseif index == 1 then
        for sreach_i = 1, Lexicon_num_list[index + 1] do
            Imgui.UpdateData("CET_SET_TRANSLATION", ImguiData.Label, CET4[sreach_i].translation)
            Imgui.UpdateData("CET_SET_NUM", ImguiData.Label, CET4[sreach_i].rem_num)
        end
    elseif index == 2 then
        for sreach_i = 1, Lexicon_num_list[index + 1] do
            Imgui.UpdateData("CET_SET_TRANSLATION", ImguiData.Label, CET6_SHORT[sreach_i].translation)
            Imgui.UpdateData("CET_SET_NUM", ImguiData.Label, CET6_SHORT[sreach_i].rem_num)
        end
    elseif index == 3 then
        for sreach_i = 1, Lexicon_num_list[index + 1] do
            Imgui.UpdateData("CET_SET_TRANSLATION", ImguiData.Label, CET6[sreach_i].translation)
            Imgui.UpdateData("CET_SET_NUM", ImguiData.Label, CET6[sreach_i].rem_num)
        end
    end
end)
ImGui.AddButton("CET_SET", "CET_CHANGE", "标记为已背过", function()
    if index == 0 then
        for sreach_i = 1, Lexicon_num_list[index + 1] do
            if CET4_SHORT[sreach_i].word == word_to_search then
                CET4_SHORT[sreach_i].rem_num = TRUE_TIMES_TO_ACHIEVE
            end
        end
    elseif index == 1 then
        for sreach_i = 1, Lexicon_num_list[index + 1] do
            if CET4[sreach_i].word == word_to_search then
                CET4[sreach_i].rem_num = TRUE_TIMES_TO_ACHIEVE
            end
        end
    elseif index == 2 then
        for sreach_i = 1, Lexicon_num_list[index + 1] do
            if CET6_SHORT[sreach_i].word == word_to_search then
                CET6_SHORT[sreach_i].rem_num = TRUE_TIMES_TO_ACHIEVE
            end
        end
    elseif index == 3 then
        for sreach_i = 1, Lexicon_num_list[index + 1] do
            if CET6[sreach_i].word == word_to_search then
                CET6[sreach_i].rem_num = TRUE_TIMES_TO_ACHIEVE
            end
        end
    end
end
)
ImGui.AddText("CET_SET", "", true, "CET_SET_TRANSLATION")
ImGui.AddText("CET_SET", "", true, "CET_SET_NUM")
ImGui.AddInputFloat("CET_SET", "damage_start", "伤害初始倍率", function(num)
    Damage_start = num
end, 0.8, 0.1, 0.5)
ImGui.AddInputFloat("CET_SET", "damage_add", "伤害初始倍率", function(num)
    Damage_add = num
end, 0.02, 0.02, 0.1)
if Damage_start == nil then
    Damage_start = 0.8
end
if Damage_add == nil then
    Damage_add = 0.02
end
-- 记忆界面
Rem_update_i = 1
ImGui.AddText("CET_TES", Word_CN[1], true, "CET_WORD")
ImGui.AddText("CET_REM", Word_EN[1], true, "CET_REM_WORD_EN")
ImGui.AddText("CET_REM", Word_CN[1], true, "CET_REM_WORD_CN")
--ImGui.AddText("CET_REM", "英式" .. Word_spe_uk[1], true, "CET_REM_WORD_SPE_EN")
--ImGui.AddText("CET_REM", "美式" .. Word_spe_us[1], true, "CET_REM_WORD_SPE_US")
ImGui.AddText("CET_REM", "背过次数: " .. Word_appear[1], true, "CET_REM_WORD_TIME")
ImGui.AddButton("CET_REM", "CET_REM_next", "下一个", function()
    if Rem_update_i <= rem_num then
        ImGui.UpdateData("CET_REM_WORD_CN", ImGuiData.Label, Word_CN[Rem_update_i])
        ImGui.UpdateData("CET_REM_WORD_EN", ImGuiData.Label, Word_EN[Rem_update_i])
        --ImGui.UpdateData("CET_REM_WORD_SPE_EN", ImGuiData.Label, "英式" .. Word_spe_uk[Rem_update_i])
        --ImGui.UpdateData("CET_REM_WORD_SPE_US", ImGuiData.Label, "美式" .. Word_spe_us[Rem_update_i])
        ImGui.UpdateData("CET_REM_WORD_TIME", ImGuiData.Label, "背过次数" .. Word_appear[Rem_update_i])
        Rem_update_i = Rem_update_i + 1
    end
end)
-- 选项按钮的初始化
local selectedIndex = -1
local AnswerIndex = 1
CET_BUTTEN = { "CET_BUTTEN_1", "CET_BUTTEN_2", "CET_BUTTEN_3" }
function Math_random(max, count, excludeValue)
    local numbers = {}
    for i = 1, max do
        if i ~= excludeValue then
            numbers[#numbers + 1] = i
        end
    end

    local result = {}
    for i = 1, count do
        local index = math.random(#numbers)
        result[#result + 1] = numbers[index]
        table.remove(numbers, index)
    end

    return result
end

ImGui.AddButton("CET_TES", "CET_BUTTEN_1", Word_EN[1], function()
    selectedIndex = 1
end, false)
ImGui.AddButton("CET_TES", "CET_BUTTEN_2", Word_EN[Math_random(rem_num, 1)[1]], function()
    selectedIndex = 2
end, false)
ImGui.AddButton("CET_TES", "CET_BUTTEN_3", Word_EN[Math_random(rem_num, 1)[2]], function()
    selectedIndex = 3
end, false)
ImGui.AddText("CET_TES", "答案", true, "CET_ans")
ImGui.AddText("CET_TES", "占位符", true, "CET_remin")
True_answer_num = 0
Answer = 2
True_times_list = {}
-- 添加检查答案按钮
ImGui.AddButton("CET_TES", "CET_ANSWER", "检查答案", function()
    if selectedIndex == AnswerIndex then
        ImGui.UpdateData("CET_remin", ImGuiData.Label, "正确")
        True_answer_num = True_answer_num + 1
        if Answer <= rem_num then
            True_times_list[Answer - 1] = 1
        elseif Answer <= 2 * rem_num and Answer > rem_num then
            True_times_list[Answer - rem_num - 1] = True_times_list[Answer - rem_num - 1] + 1
        end
    else
        True_answer_num = True_answer_num - 1
        if Answer <= rem_num then
            ImGui.UpdateData("CET_remin", ImGuiData.Label, "错误，答案是" .. Word_EN[Answer - 1])
        elseif Answer <= 2 * rem_num and Answer > rem_num then
            ImGui.UpdateData("CET_remin", ImGuiData.Label, "错误，答案是" .. Word_EN[Answer - rem_num - 1])
        elseif Answer > 2 * rem_num then
            ImGui.UpdateData("CET_remin", ImGuiData.Label, "本局已背完")
        end
    end
end, false)

ImGui.AddButton("CET_TES", "CET_TES_next", "下一个", function()
    if Answer <= rem_num then
        ImGui.UpdateData("CET_WORD", ImGuiData.Label, Word_CN[Answer])
        AnswerIndex = math.random(3)
        for tes_update_i = 1, 3 do
            if tes_update_i == AnswerIndex then
                ImGui.UpdateData(CET_BUTTEN[tes_update_i], ImGuiData.Label, Word_EN[Answer])
            else
                ImGui.UpdateData(CET_BUTTEN[tes_update_i], ImGuiData.Label,
                    Word_EN[Math_random(rem_num, 3, Answer)[tes_update_i]])
            end
        end
        Answer = Answer + 1
    elseif Answer <= 2 * rem_num and Answer > rem_num then
        ImGui.UpdateData("CET_WORD", ImGuiData.Label, Word_EN[Answer - rem_num])
        AnswerIndex = math.random(3)
        for tes_update_i = 1, 3 do
            if tes_update_i == AnswerIndex then
                ImGui.UpdateData(CET_BUTTEN[tes_update_i], ImGuiData.Label, Word_CN[Answer - rem_num])
            else
                ImGui.UpdateData(CET_BUTTEN[tes_update_i], ImGuiData.Label,
                    Word_CN[Math_random(rem_num, 3, Answer)[tes_update_i]])
            end
        end
        Answer = Answer + 1
    elseif Answer > 2 * rem_num then
        ImGui.UpdateData("CET_WORD", ImGuiData.Label, "已背完")
    end
end

)
ImGui.SetVisible("CET_TES", true)

function mod:per_floor()
    True_answer_num = 0
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.per_floor)
function mod:refresh(_, asd)
    if not asd then
        True_answer_num = 0
        Answer = 2
        True_times_list = {}
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.per_floor)
function mod:add_any(player)
    player.Damage = player.Damage * (Damage_start + Damage_add * True_answer_num)
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.add_any)
--[[
3715计划难以实施，答对三次记为正确令每正确n次后为背过(OK)
检索和标记已背过的单词
添加一个重新检测回调，刷新词库状态，还要有个计数模式记住背了多少个词
汉译英，汉选英，英选汉三种，每对一个+0.02，初始*0.8
自定义倍率应用的属性。damage,tear,charge,lucky,speed
支持自定义词库



]]
