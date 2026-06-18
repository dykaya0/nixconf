mainMod = "SUPER"

browser = "librewolf --new-window"
terminal = "ghostty --working-directory=HOME"
appLauncher = "rofi -show drun"
fileManager = "thunar"
emacs = "emacsclient -c"

require("modules.autostart")
require("modules.general")
require("modules.monitors")
require("modules.windowrules")
require("modules.keybinds")
