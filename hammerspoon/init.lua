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


-- Custom menu configuration
local fish = "/usr/local/bin/fish"
local bash = "/bin/bash"

local aliases = {
  ["golinks"]     = { fn = "g-ui",   shell = fish },
  ["pr-select"]   = { fn = "prs-ui", shell = fish },
  ["repo-code"]   = { fn = "rc-ui",  shell = fish },
  ["repo-search"] = { fn = "rs-ui",  shell = fish },
  ["websearch"]   = { fn = "websearch --ui",  shell = fish },
}

local menuItems = "golinks\npr-select\nrepo-code\nrepo-search\nwebsearch"

hs.hotkey.bind({"alt"}, "space", function()
  local chooser = hs.task.new("/Users/Craig/.kelp/bin/choose", function(code, stdout)
    local choice = stdout:gsub("%s+$", "")
    if choice ~= "" then
      local alias = aliases[choice]
      if alias then
        hs.task.new(alias.shell, nil, {"-l", "-c", alias.fn}):start()
      end
    end
  end, {"-s", "20", "-w", "10", "-c", "7287fd"})
  chooser:setInput(menuItems)
  chooser:start()
end)
