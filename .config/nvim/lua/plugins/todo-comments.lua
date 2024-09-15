-- Options:
-- PERF: This isn't particularly efficient. Too bad!
-- HACK: Bizarre vector flip inherited from earlier code, WTF?
-- TODO: Write docs :(
-- NOTE: See issue #707
-- FIX: Yes, this causes a memory leak. Too bad!

--[[
WARNING:
Dear maintainer:
Once you are done trying to 'optimize' this routine,
and have realized what a terrible mistake that was,
please increment the following counter as a warning
to the next guy:

total_hours_wasted_here = 42
--]]

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {}
}
