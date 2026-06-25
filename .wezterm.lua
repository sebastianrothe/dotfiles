  local wezterm = require 'wezterm'
  local config = wezterm.config_builder()

  -- Performance
  config.front_end = 'WebGpu'
  config.webgpu_power_preference = 'HighPerformance'
  config.animation_fps = 60

  -- Font
  config.font = wezterm.font_with_fallback { 'Hack', 'JetBrains Mono', 'Fira Code' }
  config.font_size = 15.0

  -- Warp dark theme
  config.colors = {
    foreground = '#D9D9D9',
    background = '#1B1B1F',
    cursor_bg = '#95D886',
    cursor_fg = '#1B1B1F',
    cursor_border = '#95D886',
    selection_fg = '#D9D9D9',
    selection_bg = '#264F78',
    ansi = {
      '#3C3C44', '#F66060', '#65C97A', '#FAB96B',
      '#6090D0', '#9B87DC', '#50C8D8', '#D0D0D0',
    },
    brights = {
      '#5C5C66', '#FF8080', '#80E090', '#FFC080',
      '#80AAEE', '#B8A0F0', '#70D8E8', '#F0F0F0',
    },
    tab_bar = {
      background = '#1B1B1F',
      active_tab   = { bg_color = '#2C2C32', fg_color = '#D9D9D9' },
      inactive_tab = { bg_color = '#1B1B1F', fg_color = '#888888' },
      inactive_tab_hover = { bg_color = '#25252B', fg_color = '#BBBBBB' },
      new_tab       = { bg_color = '#1B1B1F', fg_color = '#888888' },
      new_tab_hover = { bg_color = '#25252B', fg_color = '#D9D9D9' },
    },
  }

  -- Cursor
  config.default_cursor_style = 'BlinkingBlock'
  config.cursor_blink_rate = 500

  -- Window
  config.initial_cols = 120
  config.initial_rows = 28
  config.window_padding = { left = 10, right = 10, top = 10, bottom = 10 }
  config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
  config.window_background_opacity = 0.95
  config.macos_window_background_blur = 20

  -- Tabs
  config.hide_tab_bar_if_only_one_tab = true
  config.tab_max_width = 32

  -- Panes
  config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.7 }

  -- Misc
  config.scrollback_lines = 5000
  config.audible_bell = 'Disabled'

  return config
