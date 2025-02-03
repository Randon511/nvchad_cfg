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

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
