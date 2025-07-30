-- Constants
MODIFIERS = {"ctrl", "alt"}    -- Modifiers used for app shortcuts

-- App configuration
APPS = {
  {shortcut = "t", name = "Ghostty"},
  {shortcut = "c", name = "Visual Studio Code"},
  {shortcut = "b", name = "Google Chrome"},
  {shortcut = "s", name = "Slack"},
  {shortcut = "m", name = "Visual Studio Code"},
  {shortcut = ",", name = "Ghostty"},
  {shortcut = ".", name = "Google Chrome"},
  {shortcut = "/", name = "Slack"},
}

-- Bind application shortcuts
for _, app in ipairs(APPS) do
  hs.hotkey.bind(MODIFIERS, app.shortcut, function()
    hs.application.launchOrFocus(app.name)
  end)
end
