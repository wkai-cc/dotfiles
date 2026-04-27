--- @sync entry
local function entry()
	-- 1. 检查你当前光标选中的东西 (hovered)
	local h = cx.active.current.hovered
	-- 2. 如果选中了东西，并且它是一个目录 (is_dir)
	if h and h.cha.is_dir then
		-- 执行“进入 (enter)”动作
		return ya.manager_emit("enter", {})
	end
	-- 3. 如果不是目录（那就是文件），执行“打开 (open)”动作
	ya.manager_emit("open", { hovered = true })
end

return { entry = entry }
