local assistant_bot = table.deepcopy(data.raw["character"]["character"])

assistant_bot.name = "assistant-bot"
assistant_bot.minable = nil
assistant_bot.selection_box = {{-0.4, -0.4}, {0.4, 0.4}}
assistant_bot.collision_box = {{-0.2, -0.2}, {0.2, 0.2}}
assistant_bot.collision_mask = {"player-layer", "train-layer", "consider-tile-transitions"}
assistant_bot.flags = {"placeable-off-grid", "not-on-map", "not-repairable"}
assistant_bot.ai_settings = {
    do_separation = false,
    path_resolution_modifier = -2,
}
assistant_bot.light = {
    {
        minimum_darkness = 0.3,
        intensity = 0.4,
        size = 25,
        color = {r=1.0, g=1.0, b=1.0}
    },
    {
        type = "oriented",
        minimum_darkness = 0.3,
        picture = {
            filename = "__core__/graphics/light-cone.png",
            priority = "extra-high",
            flags = {"light"},
            scale = 2,
            width = 200,
            height = 200
        },
        shift = {0, -13},
        size = 2,
        intensity = 0.6,
        color = {r=1.0, g=1.0, b=1.0}
    }
}

-- Custom icon for the assistant bot
assistant_bot.icon = "__factorio-assista__/graphics/icons/assistant-bot.png"
assistant_bot.icon_size = 64
assistant_bot.icon_mipmaps = 4

data:extend({assistant_bot})

-- If you want to add a custom sprite for the bot, you can modify the animations
-- This requires creating custom graphics files
-- assistant_bot.animations = {
--     ... (custom animation definition) ...
-- }
