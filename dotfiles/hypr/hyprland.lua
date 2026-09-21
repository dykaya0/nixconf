mainMod = "SUPER"

browser = "firefox"
terminal = "footclient"
appLauncher = "rofi -show drun"
fileManager = "thunar"
emacs = "emacsclient -c -a ''"

require("modules.autostart")
require("modules.general")
require("modules.events")
require("modules.monitors")
require("modules.windowrules")
require("modules.keybinds")
