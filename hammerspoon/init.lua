-- Constants
MODIFIERS = {"alt"}    -- Modifiers used for app shortcuts

-- App configuration
APPS = {
  {shortcut = "t", name = "Ghostty"},
  {shortcut = "c", name = "Visual Studio Code"},
  {shortcut = "b", name = "Brave Browser"},
  {shortcut = "s", name = "Slack"},
  {shortcut = "n", name = "Obsidian"},
  {shortcut = "m", name = "Spotify"},
}

-- Bind application shortcuts
for _, app in ipairs(APPS) do
  hs.hotkey.bind(MODIFIERS, app.shortcut, function()
    hs.application.launchOrFocus(app.name)
  end)
end


-- Custom shortcut for app launcher
hs.hotkey.bind({"alt"}, "space", function()
    hs.task.new("/usr/local/bin/fish", nil, {"-l", "-c", "launcher"}):start()
end)
