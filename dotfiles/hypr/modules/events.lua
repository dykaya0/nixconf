local border_helper = require("modules/helpers/border_color")

hl.on("config.reloaded", function(m)
    hl.notification.create({
        text = "Config reloaded",
        timeout = 3000,
        icon = "info"
    })
end)


hl.on("window.destroy", function(_)
    border_helper.EvaluateBorderColor()
end)

hl.on("window.active", function(_)
    border_helper.EvaluateBorderColor()
end)
