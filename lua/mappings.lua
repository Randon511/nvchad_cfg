require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

vim.o.shiftwidth = 4

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Define a function for find and replace
local function find_and_replace()
  vim.ui.input({ prompt = "Find: " }, function(find)
    if find then
      vim.ui.input({ prompt = "Replace with: " }, function(replace)
        if replace then
          -- Perform the find and replace
          vim.cmd(string.format("%%s/%s/%s/gc", find, replace))
        end
      end)
    end
  end)
end

-- Set the keybind for <leader>fr
vim.keymap.set("n", "<leader>fr", find_and_replace, { noremap = true, silent = true, desc = "Find and Replace" })

-- Find and replace selected text
vim.keymap.set(
  "x",
  "<leader>r",
  'y:%s/<C-r>"//gc<Left><Left><Left>',
  { desc = "Find and replace in selection", silent = false }
)

-- Swap between header and source file
vim.keymap.set("n", "<leader>hs", ":ClangdSwitchSourceHeader<CR>", { desc = "Switch between header and source files" })

-- Fuzzy find for files being tracked by git
vim.keymap.set("n", "<leader>gf", function()
  require("telescope.builtin").find_files {
    find_command = { "git", "ls-files", "--recurse-submodules" },
  }
end, { desc = "Search Git-tracked files including submodules" })

-- Move text up and down
vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv", { desc = "Move line up", silent = true })
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv", { desc = "Move line down", silent = true })

-- Half page jump and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down and center", silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up and center", silent = true })

-- Paste and send deleted text to void buffer
vim.keymap.set("x", "<leader>p", '"_dP')
