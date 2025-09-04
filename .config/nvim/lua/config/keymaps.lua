-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- always close no matter how many buffers/windows/tabs
vim.keymap.set("c", "q<CR>", "qa<CR>", { desc = "Vim: Alias q to qa", silent = true })
vim.keymap.set("c", "q!<CR>", "qa!<CR>", { desc = "Vim: Alias q! to qa!", silent = true })

---- use tab to switch to next/prev pane, should supersede all other hotkeys (e.g., file explorer)
vim.keymap.set("n", "<Tab>", "<C-w>w", { desc = "Vim: Next Pane", silent = true, noremap = true, buffer = false })
vim.keymap.set("n", "<S-Tab>", "<C-w>W", { desc = "Vim: Prev Pane", silent = true, noremap = true, buffer = false })

-- leetcode
vim.keymap.set("n", "<localleader>lr", "<cmd>Leet run<CR>", { desc = "Leetcode: Run", silent = true })
vim.keymap.set("n", "<localleader>ls", "<cmd>Leet submit<CR>", { desc = "Leetcode: Submit", silent = true })
vim.keymap.set("n", "<localleader>lm", "<cmd>Leet<CR>", { desc = "Leetcode: Menu", silent = true })
vim.keymap.set("n", "<localleader>lc", "<cmd>Leet console<CR>", { desc = "Leetcode: Console", silent = true })

-- vimtex
vim.keymap.set("n", "<localleader>vv", "<cmd>VimtexView<CR>", { desc = "Vimtex: View / Forward Search", silent = true })
vim.keymap.set("n", "<localleader>vt", "<cmd>VimtexTocToggle<CR>", { desc = "Vimtex: Toggle TOC", silent = true })
vim.keymap.set(
  "n",
  "<localleader>vc",
  "<cmd>VimtexCompile<CR>",
  { desc = "Vimtex: Compile Continuously", silent = true }
)
vim.keymap.set("n", "<localleader>vs", "<cmd>VimtexCompile<CR>", { desc = "Vimtex: Stop Compilation", silent = true })
vim.keymap.set("n", "<localleader>vw", "<cmd>VimtexCountWords<CR>", { desc = "Vimtex: Count Words", silent = true })

-- quarto
local runner = require("quarto.runner")
vim.keymap.set("n", "<localleader>jc", runner.run_cell, { desc = "Quarto: Run Cell", silent = true })
vim.keymap.set("n", "<localleader>ja", runner.run_above, { desc = "Quarto: Run Cell and Above", silent = true })
vim.keymap.set("n", "<localleader>jA", runner.run_all, { desc = "Quarto: Run All Cells", silent = true })
vim.keymap.set("n", "<localleader>jl", runner.run_line, { desc = "Quarto: Run Line", silent = true })
vim.keymap.set("v", "<localleader>j", runner.run_range, { desc = "Quarto: Run Visual Range", silent = true })

-- molten
vim.keymap.set("n", "<localleader>jR", "<cmd>MoltenRestart<CR>", { desc = "Molten: Restart Kernel", silent = true })
vim.keymap.set(
  "n",
  "<localleader>jr",
  "<cmd>MoltenRestart!<CR>",
  { desc = "Molten: Restart Kernel and Clear All", silent = true }
)
vim.keymap.set("n", "<localleader>ji", "<cmd>MoltenInterrupt<CR>", { desc = "Molten: Interrupt", silent = true })

-- enter/exit molten output
-- also use q or esc to exit
vim.keymap.set("n", "<localleader>je", function()
  if vim.bo.filetype == "molten_output" then
    vim.cmd("MoltenHideOutput")
  else
    vim.cmd("noautocmd MoltenEnterOutput")
    vim.keymap.set(
      "n",
      "q",
      "<cmd>MoltenHideOutput<CR>",
      { buffer = true, desc = "Molten: Exit Output", silent = true }
    )
    vim.keymap.set(
      "n",
      "<Esc>",
      "<cmd>MoltenHideOutput<CR>",
      { buffer = true, desc = "Molten: Exit Output", silent = true }
    )
  end
end, { desc = "Molten: Toggle Output", silent = true })

vim.keymap.set(
  "n",
  "]]",
  "<cmd>TSTextobjectGotoNextStart @code_cell.inner | norm! zz<CR>",
  { desc = "TS: Next Code Block", silent = true, buffer = true }
)
vim.keymap.set(
  "n",
  "[[",
  "<cmd>TSTextobjectGotoPreviousStart @code_cell.inner | norm! zz<CR>",
  { desc = "TS: Prev Code Block", silent = true, buffer = true }
)
vim.keymap.set(
  { "x", "o" },
  "ib",
  "<cmd>TSTextobjectSelect @code_cell.inner<CR>",
  { desc = "TS: Select Inner Block", silent = true, buffer = true }
)
vim.keymap.set(
  { "x", "o" },
  "ab",
  "<cmd>TSTextobjectSelect @code_cell.outer<CR>",
  { desc = "TS: Select Around Block", silent = true, buffer = true }
)

-- xcodebuild
vim.keymap.set("n", "<localleader>xs", "<cmd>XcodebuildSetup<cr>", { desc = "Xcode: Setup" })
vim.keymap.set("n", "<localleader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Xcode: Toggle Logs" })
vim.keymap.set("n", "<localleader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Xcode: Build Project" })
vim.keymap.set("n", "<localleader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Xcode: Build & Run Project" })
vim.keymap.set("n", "<localleader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Xcode: Run Tests" })
vim.keymap.set("n", "<localleader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Xcode: Run This Test Class" })
vim.keymap.set("n", "<localleader>xx", "<cmd>XcodebuildPicker<cr>", { desc = "Xcode: Show All Actions" })
vim.keymap.set("n", "<localleader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Xcode: Select Device" })
vim.keymap.set("n", "<localleader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Xcode: Select Test Plan" })
vim.keymap.set(
  "n",
  "<localleader>xc",
  "<cmd>XcodebuildToggleCodeCoverage<cr>",
  { desc = "Xcode: Toggle Code Coverage" }
)
vim.keymap.set(
  "n",
  "<localleader>xC",
  "<cmd>XcodebuildShowCodeCoverageReport<cr>",
  { desc = "Xcode: Show Code Coverage Report" }
)
vim.keymap.set("n", "<localleader>xq", "<cmd>Telescope quickfix<cr>", { desc = "Xcode: Show QuickFix List" })

-- xcodebuild + dap (debugger)
local xcodebuild = require("xcodebuild.integrations.dap")
local codelldbPath = os.getenv("HOME") .. "/.config/yadm/tools/codelldb/extension/adapter/codelldb"

xcodebuild.setup(codelldbPath)

vim.keymap.set("n", "<localleader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
vim.keymap.set("n", "<localleader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
vim.keymap.set("n", "<localleader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
vim.keymap.set("n", "<localleader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
vim.keymap.set("n", "<localleader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<localleader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
vim.keymap.set("n", "<localleader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })

-- codewindow
local codewindow = require("codewindow")
vim.keymap.set("n", "<leader>mf", codewindow.toggle_focus, { desc = "Codewindow: Focus", silent = true })
vim.keymap.set("n", "<leader>mm", codewindow.toggle_minimap, { desc = "Codewindow: Toggle", silent = true })
