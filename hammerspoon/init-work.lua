-- Constants
MODIFIERS = { "alt"}    -- Modifiers used for app shortcuts

-- App configuration
APPS = {
  {shortcut = "t", name = "Ghostty"},
  {shortcut = "c", name = "Visual Studio Code"},
  {shortcut = "b", name = "Brave Browser"},
  {shortcut = "s", name = "Slack"},
  {shortcut = "n", name = "Obsidian"},
  {shortcut = "a", name = "Claude"},
  {shortcut = "m", name = "Spotify"},
  {shortcut = "1", name = "Visual Studio Code"},
  {shortcut = "2", name = "Ghostty"},
  {shortcut = "3", name = "Brave Browser"},
  {shortcut = "4", name = "Slack"},
}

-- Bind application shortcuts
for _, app in ipairs(APPS) do
  hs.hotkey.bind(MODIFIERS, app.shortcut, function()
    hs.application.launchOrFocus(app.name)
  end)
end
