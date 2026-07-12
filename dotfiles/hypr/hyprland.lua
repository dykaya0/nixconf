mainMod = "SUPER"

browser = "firefox --new-window"
terminal = "ghostty"
appLauncher = "rofi -show drun"
fileManager = "thunar"
emacs = "emacsclient -c -a ''"

require("modules.autostart")
require("modules.general")
require("modules.monitors")
require("modules.windowrules")
require("modules.keybinds")
