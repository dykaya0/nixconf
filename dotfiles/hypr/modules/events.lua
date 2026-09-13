hl.on("config.reloaded", function(m)
    hl.notification.create({
        text = "Config reloaded",
        timeout = 3000,
        icon = "info"
    })
end)
