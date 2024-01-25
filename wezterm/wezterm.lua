local wezterm = require 'wezterm';
local act = wezterm.action

local mux = wezterm.mux

-- this is called by the mux server when it starts up.
-- It makes a window split top/bottom
--wezterm.on('mux-startup', function()
--  local tab, pane, window = mux.spawn_window {}
--  pane:split { direction = 'Top' }
--  pane:split { direction = 'Right' }
--end)


return {
--    default_prog = {"/usr/bin/zsh", "-l"},
--    color_scheme = "Tomorrow Night Blue",
--    color_scheme = "Nord",
    color_scheme = "Zenburn",
    color_scheme_dirs = { os.getenv("HOME") .. "/.config.wezterm/colors/" },
    font_size = 8.0,
    underline_thickness = "75%",
    underline_position = "75%",
    strikethrough_position ="130%",
    dpi = 96.0,
    font_dirs = { os.getenv("HOME") .. "/.local/share/fonts/" },
    font = wezterm.font_with_fallback {
      { family = 'FiraCode', weight = 'Regular',
        harfbuzz_features = { 'cv13', 'cv18', 'cv31', 'ss03' },
      },
      'FiraCode',
      'VictorMono',
      'Noto Color Emoji',
      'Symbols Nerd Font Mono',
    },
    harfbuzz_features = { 'kern', 'liga', 'clig', 'calt' },
    font_rules = {
    -- Select a fancy italic font for italic text
      {
        italic = true,
        intensity = "Normal",
        font = wezterm.font { family = 'VictorMono',
          weight = 'Medium', style = 'Italic' },
      },
      -- Similarly, a fancy bold+italic font
      {
        intensity = "Bold",
        italic = true,
        font = wezterm.font { family = 'VictorMono',
          weight = "Bold", style = 'Italic' },
      },
    -- Make regular bold text a different color to make it stand out even more
      {
        intensity = 'Bold',
        font = wezterm.font { family = 'FiraCode',
          weight = 'DemiBold', style = 'Normal',
          harfbuzz_features = { 'ss03', 'cv13', 'cv18', 'cv31' },
        },
      },
    -- For half-intensity text, use a lighter weight font
      {
        italic = true,
        intensity = 'Half',
        font = wezterm.font { family = 'VictorMono',
          weight = 'Light', style = 'Italic' },
      },
      {
        intensity = 'Half',
        italic = false,
        font = wezterm.font { family = 'VictorMono',
          weight = "Light", harfbuzz_features = { 'ss04' }},
      },
    },
    font_shaper = "Harfbuzz",
    -- https://github.com/rubjo/victor-mono
    -- https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets
    -- ss04 is for victor as cv13 is 0 for fira that change $ with ss04
    -- ss05 @, cv18 %, ss10 FfT lig,
    freetype_interpreter_version = 40,
    freetype_render_target = "HorizontalLcd",
--    freetype_load_flags = 'MONOCHROME|NO_AUTOHINT',
--    freetype_load_target = "Light",
--    freetype_render_target = "Normal",

----------------------------------
    enable_wayland = true,
    hide_tab_bar_if_only_one_tab = false,
    use_fancy_tab_bar = false,
--    selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%",
    window_padding = {
                left = 0,
                right = 0,
                top = 0,
                bottom = 0,
              },
    window_background_opacity = 0.9,
    animation_fps = 1,
--    front_end = "Software",
    pane_focus_follows_mouse = true,
    disable_default_key_bindings = true,
    leader = { key = "Space", mods = "CTRL|SHIFT" },
    keys = {
      --- tmux ---
        { key = "k", mods = "ALT", action = act({ SpawnTab = "CurrentPaneDomain" }) },
        { key = "j", mods = "ALT", action = act({ CloseCurrentTab = { confirm = true } }) },
        { key = "h", mods = "ALT", action = act({ ActivateTabRelative = -1 }) },
        { key = "l", mods = "ALT", action = act({ ActivateTabRelative = 1 }) },
        { key = "h", mods = "ALT|CTRL", action = act({ MoveTabRelative = -1 }) },
        { key = "l", mods = "ALT|CTRL", action = act({ MoveTabRelative = 1 }) },
        {
                key = "k",
                mods = "ALT|CTRL",
                action = act.Multiple({ act.CopyMode("ClearSelectionMode"), act.ActivateCopyMode, act.ClearSelection }),
        },
        { key = "j", mods = "ALT|CTRL", action = act({ PasteFrom = "PrimarySelection" }) },
--        { key = "1", mods = "ALT", action = act({ ActivateTab = 0 }) },
--        { key = "2", mods = "ALT", action = act({ ActivateTab = 1 }) },
--        { key = "3", mods = "ALT", action = act({ ActivateTab = 2 }) },
--        { key = "4", mods = "ALT", action = act({ ActivateTab = 3 }) },
--        { key = "5", mods = "ALT", action = act({ ActivateTab = 4 }) },
--        { key = "6", mods = "ALT", action = act({ ActivateTab = 5 }) },
--        { key = "7", mods = "ALT", action = act({ ActivateTab = 6 }) },
--        { key = "8", mods = "ALT", action = act({ ActivateTab = 7 }) },
--        { key = "9", mods = "ALT", action = act({ ActivateTab = 8 }) },
        { key = "-", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
        { key = "\\", mods = "ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
        { key = "h", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Left" }) },
        { key = "l", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Right" }) },
        { key = "k", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Up" }) },
        { key = "j", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Down" }) },
        { key = "h", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Left", 1 } }) },
        { key = "l", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Right", 1 } }) },
        { key = "k", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Up", 1 } }) },
        { key = "j", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Down", 1 } }) },
        { key = "Enter", mods = "ALT", action = "QuickSelect" },
        { key = "f", mods = "CTRL|SHIFT", action = act.Search("CurrentSelectionOrEmptyString") },
        ---- Defaults Bindings ----
        { key = "c", mods = "CTRL|SHIFT", action = act({ CopyTo = "Clipboard" }) },
        { key = "v", mods = "CTRL|SHIFT", action = act({ PasteFrom = "Clipboard" }) },
        { key = "Insert", mods = "SHIFT", action = act({ PasteFrom = "PrimarySelection" }) },
        { key = "=", mods = "CTRL", action = "ResetFontSize" },
        { key = "+", mods = "CTRL", action = "IncreaseFontSize" },
        { key = "-", mods = "CTRL", action = "DecreaseFontSize" },
        { key = "PageUp", mods = "ALT", action = act({ ScrollByPage = -1 }) },
        { key = "PageDown", mods = "ALT", action = act({ ScrollByPage = 1 }) },
        { key = "z", mods = "ALT", action = "ReloadConfiguration" },
        { key = "z", mods = "ALT|SHIFT", action = act({ EmitEvent = "toggle-tmux-keybinds" }) },
        { key = "e", mods = "ALT", action = act({ EmitEvent = "trigger-nvim-with-scrollback" }) },
        { key = "q", mods = "ALT", action = act({ CloseCurrentPane = { confirm = true } }) },
        { key = "x", mods = "ALT", action = act({ CloseCurrentPane = { confirm = true } }) },
--        { key = "u", mods = "CTRL|SHIFT", action = "CharSelect" },
        {
          key = 'u',
          mods = 'SHIFT|CTRL',
          action = act.CharSelect {
          copy_on_select = true,
          copy_to = 'ClipboardAndPrimarySelection',
          },
        },
        {
                key = "r",
                mods = "ALT",
                action = act({
                        ActivateKeyTable = {
                                name = "resize_pane",
                                one_shot = false,
                                timeout_milliseconds = 3000,
                                replace_current = false,
                        },
                }),
        },
        { key = "s", mods = "ALT", action = act.PaneSelect({
                alphabet = "1234567890",
        }) },
        {
                key = "b",
                mods = "ALT",
                action = act.RotatePanes("CounterClockwise"),
        },
        { key = "f", mods = "ALT", action = act.RotatePanes("Clockwise") },

    },

--------------------------------------------------------------------

    colors = {
        tab_bar = {

            -- The color of the strip that goes along the top of the window
            background = "#262626",

            -- The active tab is the one that has focus in the window
            active_tab = {
                -- The color of the background area for the tab
                bg_color = "#404040",
                -- The color of the text for the tab
                fg_color = "#c0c0c0",

                -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
                -- label shown for this tab.
                -- The default is "Normal"
                intensity = "Bold",

                -- Specify whether you want "None", "Single" or "Double" underline for
                -- label shown for this tab.
                -- The default is "None"
                underline = "None",

                -- Specify whether you want the text to be italic (true) or not (false)
                -- for this tab.  The default is false.
                italic = false,

                -- Specify whether you want the text to be rendered with strikethrough (true)
                -- or not for this tab.  The default is false.
                strikethrough = false,
            },

            -- Inactive tabs are the tabs that do not have focus
            inactive_tab = {
                bg_color = "#202020",
                fg_color = "#808080",

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over inactive tabs
            inactive_tab_hover = {
                bg_color = "#363636",
                fg_color = "#909090",
                italic = false,

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab_hover`.
            }
        }
    }
}
