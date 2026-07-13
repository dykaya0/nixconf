mainMod = "SUPER"

browser = "firefox --new-window"
terminal = 'ghostty --working-directory="$HOME"'
appLauncher = "rofi -show drun"
fileManager = "thunar"
emacs = "emacsclient -c -a ''"

require("modules.autostart")
require("modules.general")
require("modules.monitors")
require("modules.windowrules")
require("modules.keybinds")
