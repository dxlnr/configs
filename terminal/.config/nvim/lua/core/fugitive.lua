local status_ok, telescope = pcall(require, "fugitive")
if not status_ok then
  return
end

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
