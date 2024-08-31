-- NPC Assistant Bot Control Script

-- Define global variables
global.assistant_bot = nil

-- Initialize the assistant bot when a new game starts or when the mod is added to an existing game
script.on_init(function()
    -- print started
    game.print("Assistant bot control script started")
    create_assistant_bot()
end)

-- Create the assistant bot
function create_assistant_bot()
    if #game.players == 0 then
        script.on_event(defines.events.on_player_created, function(event)
            script.on_event(defines.events.on_player_created, nil)
            create_assistant_bot()
        end)
        return
    end

    local player = game.players[1]
    local position = player.surface.find_non_colliding_position("assistant-bot", player.position, 10, 1)
    
    if position then
        global.assistant_bot = player.surface.create_entity{
            name = "assistant-bot",
            position = position,
            force = player.force
        }
        
        if global.assistant_bot then
            global.assistant_bot.color = {r = 0, g = 1, b = 1}
        else
            game.print("Failed to create assistant bot")
        end
    else
        game.print("Could not find a suitable position for the assistant bot")
    end
end

-- Command to summon the bot to the player
commands.add_command("summon_assistant", "Summons the assistant bot to your location", function(command)
    local player = game.get_player(command.player_index)
    if player and global.assistant_bot and global.assistant_bot.valid then
        local position = player.surface.find_non_colliding_position("character", player.position, 5, 0.5)
        if position then
            global.assistant_bot.teleport(position)
            player.print("Assistant bot summoned!")
        else
            player.print("Could not find a suitable position nearby.")
        end
    else
        player.print("Assistant bot is not available.")
    end
end)

-- Modify the on_tick event handler
script.on_event(defines.events.on_tick, function(event)
    if not global.assistant_bot or not global.assistant_bot.valid then
        create_assistant_bot()
        return
    end

    local player = game.players[1]
    if player and player.valid then
        local distance = ((global.assistant_bot.position.x - player.position.x)^2 + (global.assistant_bot.position.y - player.position.y)^2)^0.5
        if distance > 10 then
            -- Move the bot towards the player
            local direction = {
                x = (player.position.x - global.assistant_bot.position.x) / distance,
                y = (player.position.y - global.assistant_bot.position.y) / distance
            }
            global.assistant_bot.teleport({
                x = global.assistant_bot.position.x + direction.x * 0.1,
                y = global.assistant_bot.position.y + direction.y * 0.1
            })
        end
    end
end)
