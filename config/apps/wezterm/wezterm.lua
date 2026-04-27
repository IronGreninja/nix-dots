local wez = require "wezterm"

local cfg = wez.config_builder()

-- fixes underline(eg: snacks.indent scope in nvim) changing color based on the text color above it
-- https://wezterm.org/config/lua/config/term.html
cfg.term = "wezterm"

cfg.color_scheme = "Gruvbox dark, hard (base16)"

-- tab, window
-- cfg.hide_tab_bar_if_only_one_tab = true
cfg.tab_bar_at_bottom = true
cfg.window_padding = { bottom = 0 }
cfg.window_frame = {
  font = wez.font { family = "Roboto", weight = "Bold" },
  font_size = 13,
}

-- fonts
cfg.font_size = 18
cfg.font = wez.font_with_fallback {
  {
    family = "JetBrains Mono",
    weight = "Light",
    harfbuzz_features = { "zero", "ss02" },
  },
  { family = "Symbols Nerd Font Mono", scale = 0.75 },
}
-- cfg.line_height = 1.1

-- cursor
cfg.force_reverse_video_cursor = true

return cfg
