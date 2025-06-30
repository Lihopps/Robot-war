local simulations = {}


simulations.asuras_briefing =
{
  checkboard = false,
  save = "__Robot-war__/menu-simulation/asuras_briefing.zip",
  init =
  [[
    local logo = game.surfaces.nauvis.find_entities_filtered{name = "heat-interface", limit = 1}[1]
    game.simulation.camera_position = {logo.position.x, logo.position.y}
    game.simulation.camera_zoom = 0.5
    game.tick_paused = false
    game.surfaces.nauvis.daytime = 0
  ]],
   update =
  [[
  ]]
}

simulations.control_unit =
{
  mods["Robot-war"],
  init =
  [[
    require("__core__/lualib/story")
    player={}
    unit={}
    group={}
    chest={}

    local function initial()
      player = game.simulation.create_test_player{name = "kovarex"}
      player.teleport{-1.5, 5.5}
      player.force="player"
      player.force.ai_controllable=true
      game.simulation.camera_player = player
      game.simulation.camera_zoom = 0.8
      game.simulation.camera_position = {0, 0.5}
      game.simulation.camera_player_cursor_position = player.position
      unit=game.surfaces[1].create_entity{name="robot-unit",position={-4,0},force=player.force}
      unit.speed = player.character_running_speed
      unit.commandable.set_command({
        type=defines.command.stop,
        ticks_to_wait=60*4})
      chest=game.surfaces[1].create_entity{name="steel-chest",position={-8,0},force="enemy"}
      group=game.surfaces[1].create_unit_group{ position = {-4,0}, force = player.force}
      group.add_member(unit)
    end

    local story_table =
    {
      {
        {
          name = "start",
          init = function() 
          initial()
          game.simulation.camera_player_cursor_direction = defines.direction.north 
          end,
          condition = story_elapsed_check(2)
        },
        {
          condition = function() return game.simulation.move_cursor({position = {player.position.x, player.position.y - 2}}) end,
          action = function() game.simulation.control_press{control = "give-unit-combat-remote", notify = player.input_method ~= defines.input_method.game_controller} end
        },
        {
          condition = function() return game.simulation.move_cursor({position = {-4.75, -1.75}}) end,
          action = function()
            
            if player.input_method ~= defines.input_method.game_controller then
              game.simulation.control_down{control = "select-for-blueprint", notify = false}
            else
              game.simulation.control_press{control = "select-for-blueprint", notify = false}
            end
            
          end
        },
        {
          condition = function() return game.simulation.move_cursor({position = {-3, 0}}) end,
          action = function()
            
            if player.input_method ~= defines.input_method.game_controller then
              game.simulation.control_up{control = "select-for-blueprint", notify = false}
            else
              game.simulation.control_press{control = "select-for-blueprint", notify = false}
            end
          end
        },
  
        {
          condition = function() return game.simulation.move_cursor({position = {-8, 0}}) end,
          action = function()
            if player.input_method ~= defines.input_method.game_controller then
              game.simulation.control_down{control = "use-item", notify = true}
            else
              game.simulation.control_press{control = "use-item", notify = true}
            end
            group.set_command{
              type = defines.command.attack,
              target = chest}
          end
        },
        { condition = story_elapsed_check(3) },
        {
          condition = function() return game.simulation.move_cursor({position = {15, 5}}) end,
          action = function() 
            
            if player.input_method ~= defines.input_method.game_controller then
              game.simulation.control_down{control = "use-item", notify = true}
            else
              game.simulation.control_press{control = "use-item", notify = true}
            end
            
            group.set_command{
              type = defines.command.go_to_location,
              destination = {x=15, y=5},
              radius = 2,
              distraction = defines.distraction.none}
            group.start_moving()
          end
        },
       

        {
          condition = story_elapsed_check(0.5),
          action = function() player.clear_cursor() end
        },
        { condition = function() return game.simulation.move_cursor({position = player.position}) end },
        {
          condition = story_elapsed_check(2),
          action = function()
            for k, v in pairs (game.surfaces[1].find_entities_filtered{}) do
              v.destroy()
            end
          end
        },
        {
          condition = story_elapsed_check(1),
          action = function() story_jump_to(storage.story, "start") end
        }
      }
    }
    tip_story_init(story_table)
  ]]
}


return simulations
