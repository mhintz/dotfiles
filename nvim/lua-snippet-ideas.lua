-- Copy file path with line range to clipboard in format: @File#L1-99
vim.keymap.set("v", "<leader>fC", function()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local file_path = vim.fn.expand("%:.")
  local result = string.format("@%s#L%d-%d", file_path, start_line, end_line)

  vim.fn.setreg("+", result)
  vim.notify(string.format("Copied: %s", result), vim.log.levels.INFO)
end, { desc = "Copy file path with line range" }) 

-- Search and paste import strings
-- requires: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
vim.keymap.set("n", "<leader>i", function()
  local target_buf = vim.api.nvim_get_current_buf()
  local target_win = vim.api.nvim_get_current_win()
  local word = vim.fn.expand("<cword>")

  Snacks.picker.grep({
    search = "import.*" .. word,
    confirm = function(picker, item)
      if not item then
        return
      end

      picker:close()

      -- Remove filepath:line:col: prefix to get just the content
      local line_text = item.text or ""
      local content = line_text:match("^[^:]+:%d+:%d+:(.*)$")
      if not content then
        return
      end

      -- Switch back to the target buffer/window
      vim.api.nvim_set_current_win(target_win)
      vim.api.nvim_set_current_buf(target_buf)

      -- Prepend import line to file
      vim.api.nvim_buf_set_lines(target_buf, 0, 0, false, { content })
    end,
  })
end, { desc = "Search and paste import strings" })
