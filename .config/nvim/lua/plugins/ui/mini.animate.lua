return {
  'echasnovski/mini.animate',
  version = false,
  opts = function()
    -- Track mouse scrolling
    local fast_scrolled = false
    for _, scroll in ipairs({ "Up", "Down" }) do
      local key = "<ScrollWheel" .. scroll .. ">"
      vim.keymap.set({ "n", "v", "i" }, key, function()
        fast_scrolled = true
        return key
      end, { expr = true })
    end

    -- Set up key mappings for j, k, and their uppercase variants
    -- To fix scroll stuck bug in jupyter notebooks
    for _, mapping in ipairs({
      { 'j', 'j' },
      { 'k', 'k' },
      { 'J', '3j' },
      { 'K', '3k' }
    }) do
      local key, action = unpack(mapping)
      vim.keymap.set({ "n", "v" }, key, function()
        fast_scrolled = true
        return action
      end, { expr = true })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "grug-far",
      callback = function()
        vim.b.minianimate_disable = true
      end,
    })

    local animate = require("mini.animate")
    return {
      resize = {
        timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
      },
      scroll = {
        timing = animate.gen_timing.linear({ duration = 180, unit = "total" }),
        subscroll = animate.gen_subscroll.equal({
          max_output_steps = 60,
          predicate = function(total_scroll)
            if fast_scrolled then
              fast_scrolled = false
              return false
            end
            return total_scroll > 1
          end,
        }),
      },
    }
  end
}
