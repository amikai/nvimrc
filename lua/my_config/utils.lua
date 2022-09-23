local M = {}

local cmd = vim.cmd

-- Copy from https://github.com/wbthomason/dotfiles/blob/387ded8ad4c3cb9d5000edbd3b18bc8cb8a186e9/neovim/.config/nvim/lua/config/utils.lua
function M.autocmd(group, cmds, clear)
	clear = clear == nil and false or clear
	if type(cmds) == "string" then
		cmds = { cmds }
	end
	cmd("augroup " .. group)
	if clear then
		cmd([[au!]])
	end
	for _, c in ipairs(cmds) do
		cmd("autocmd " .. c)
	end
	cmd([[augroup END]])
end

function M.km(modes, lhs, rhs, opts)
	opts = opts or {}
	local set_keymap = vim.api.nvim_set_keymap
	if type(modes) == "string" then
		modes = { modes }
	end

	if opts["buffer"] == true then
		opts["buffer"] = nil -- delete the element
		for _, mode in ipairs(modes) do
			vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
		end
		return
	end
	for _, mode in ipairs(modes) do
		vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
	end
end

function M.is_load(plugin)
	return packer_plugins ~= nil and packer_plugins[plugin] ~= nil and packer_plugins[plugin].loaded ~= nil
end

function M.has_plugin(plugin)
	return packer_plugins ~= nil and packer_plugins[plugin] ~= nil
end

-- See https://unix.stackexchange.com/questions/10689/how-can-i-tell-if-im-in-a-tmux-session-from-a-bash-script
function M.is_in_tmux()
	return os.getenv("TERM_PROGRAM") == "tmux"
end

function M.executable(name)
	if fn.executable(name) > 0 then
		return true
	end

	return false
end

return M
