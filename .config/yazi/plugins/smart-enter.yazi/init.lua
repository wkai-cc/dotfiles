--- @sync entry
local function entry()
	local h = cx.active.current.hovered
	if h and h.cha.is_dir then
		return ya.manager_emit("enter", {})
	end
	ya.manager_emit("open", { hovered = true })
end

return { entry = entry }
