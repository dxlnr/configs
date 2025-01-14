local colorscheme = "rose-pine"
-- local colorscheme = "yash"

function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    ColorMyPencils(colorscheme)
  end,
})
