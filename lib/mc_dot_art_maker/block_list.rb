module MCDotArtMaker
  class BlockList
    include Enumerable
    # include Singleton
    def initialize(jar_path = nil)
      @loader = MCDotArtMaker::TextureLoader.new(jar_path)
      @blocks = []

      # できるだけ多くのブロックを使ったバージョン

      # block :stone, '1', 'stone.png'
      # block :granite, '1:1', 'stone_granite.png'
      # block :polished_granite, '1:2', 'stone_granite_smooth.png'
      # block :diorite, '1:3', 'stone_diorite.png'
      # block :polished_diorite, '1:4', 'stone_diorite_smooth.png'
      # block :andesite, '1:5', 'stone_andesite.png'
      # block :polished_andesite, '1:6', 'stone_andesite_smooth.png'
      # # block :grass, '2', ''
      # # テクスチャがグレースケールでたぶんバイオームごとに色を変えてる
      # block :dirt, '3', 'dirt.png'
      # block :coarse_dirt, '3:1', 'coarse_dirt.png'
      # block :podzol, '3:2', 'dirt_podzol_top.png'
      # block :cobblestone, '4', 'cobblestone.png'
      # block :oak_wood_plank, '5', 'planks_oak.png'
      # block :spruce_wood_plank, '5:1', 'planks_spruce.png'
      # block :birch_wood_plank, '5:2', 'planks_birch.png'
      # block :jungle_wood_plank, '5:3', 'planks_jungle.png'
      # block :acacia_wood_plank, '5:4', 'planks_acacia.png'
      # block :dark_oak_wood_plank, '5:5', 'planks_big_oak.png'
      #
      # block :bedrock, '7', 'bedrock.png'
      #
      # block :sand, '12', 'sand.png'
      # block :red_sand, '12:1', 'red_sand.png'
      # block :gravel, '13', 'gravel.png'
      # block :gold_ore, '14', 'gold_ore.png'
      # block :iron_ore, '15', 'iron_ore.png'
      # block :coal_ore, '16', 'coal_ore.png'
      # block :oak_wood, '17', 'log_oak_top.png' # TODO: テクスチャ注意
      # # block :spruce_wood, '17:1', 'spruce_wood.png'
      # # block :birch_wood, '17:2', 'birch_wood.png'
      # # block :jungle_wood, '17:3', 'jungle_wood.png'
      #
      # # block :oak_leaves, '18', 'oak_leaves.png'
      # # block :spruce_leaves, '18:1', 'spruce_leaves.png'
      # # block :birch_leaves, '18:2', 'birch_leaves.png'
      # # block :jungle_leaves, '18:3', 'jungle_leaves.png'
      # # テクスチャがグレースケールでたぶんバイオームごとに色を変えてる
      # block :sponge, '19', 'sponge.png'
      # block :wet_sponge, '19:1', 'sponge_wet.png'
      # block :glass, '20', 'glass.png'
      # block :lapis_lazuli_ore, '21', 'lapis_ore.png'
      # block :lapis_lazuli_block, '22', 'lapis_block.png'
      # block :dispenser, '23', 'dispenser_front_vertical.png'
      # block :sandstone, '24', 'sandstone_top.png'
      # # block :chiseled_sandstone, '24:1', 'chiseled_sandstone.png'
      # # block :smooth_sandstone, '24:2', 'smooth_sandstone.png'
      # block :note_block, '25', 'noteblock.png'
      #
      # block :white_wool,'35','wool_colored_white.png'
      # block :orange_wool,'35:1','wool_colored_orange.png'
      # block :magenta_wool,'35:2','wool_colored_magenta.png'
      # block :light_blue_wool,'35:3','wool_colored_light_blue.png'
      # block :yellow_wool,'35:4','wool_colored_yellow.png'
      # block :lime_wool,'35:5','wool_colored_lime.png'
      # block :pink_wool,'35:6','wool_colored_pink.png'
      # block :gray_wool,'35:7','wool_colored_gray.png'
      # block :silver_wool,'35:8','wool_colored_silver.png'
      # block :cyan_wool,'35:9','wool_colored_cyan.png'
      # block :purple_wool,'35:10','wool_colored_purple.png'
      # block :blue_wool,'35:11','wool_colored_blue.png'
      # block :brown_wool,'35:12','wool_colored_brown.png'
      # block :green_wool,'35:13','wool_colored_green.png'
      # block :red_wool,'35:14','wool_colored_red.png'
      # block :black_wool,'35:15','wool_colored_black.png'
      #
      # block :gold_block, '41', 'gold_block.png'
      # block :iron_block, '42', 'iron_block.png'
      # block :double_stone_slab, '43', 'stone_slab_top.png'
      # # block :double_sandstone_slab, '43:1', 'double_sandstone_slab.png'
      # # block :double_wooden_slab, '43:2', 'double_wooden_slab.png'
      # # block :double_cobblestone_slab, '43:3', 'double_cobblestone_slab.png'
      # # block :double_brick_slab, '43:4', 'double_brick_slab.png'
      # # block :double_stone_brick_slab, '43:5', 'double_stone_brick_slab.png'
      # # block :double_nether_brick_slab, '43:6', 'double_nether_brick_slab.png'
      # # block :double_quartz_slab, '43:7', 'double_quartz_slab.png'
      #
      # block :bricks, '45', 'brick.png'
      # block :tnt, '46', 'tnt_top.png'
      # # block :bookshelf, '47', 'bookshelf.png'
      # block :moss_stone, '48', 'cobblestone_mossy.png'
      # block :obsidian, '49', 'obsidian.png'
      #
      # block :diamond_ore, '56', 'diamond_ore.png'
      # block :diamond_block, '57', 'diamond_block.png'
      # block :crafting_table, '58', 'crafting_table_top.png'
      #
      # block :farmland, '60', 'farmland_dry.png'
      #
      # block :redstone_ore, '73', 'redstone_ore.png'
      #
      # block :snow, '78', 'snow.png'
      # block :ice, '79', 'ice.png'
      # # block :snow_block, '80', 'snow_block.png'
      #
      # block :clay, '82', 'clay.png'
      #
      # block :jukebox, '84', 'jukebox_top.png'
      #
      # block :pumpkin, '86', 'pumpkin_top.png'
      # block :netherrack, '87', 'netherrack.png'
      # block :soul_sand, '88', 'soul_sand.png'
      # block :glowstone, '89', 'glowstone.png'
      #
      # # block :jack_o_lantern, '91', 'jack_o_lantern.png'
      # block :cake_block, '92', 'cake_top.png'
      #
      # block :white_stained_glass, '95', 'glass_white.png'
      # block :orange_stained_glass, '95:1', 'glass_orange.png'
      # block :magenta_stained_glass, '95:2', 'glass_magenta.png'
      # block :light_blue_stained_glass, '95:3', 'glass_light_blue.png'
      # block :yellow_stained_glass, '95:4', 'glass_yellow.png'
      # block :lime_stained_glass, '95:5', 'glass_lime.png'
      # block :pink_stained_glass, '95:6', 'glass_pink.png'
      # block :gray_stained_glass, '95:7', 'glass_gray.png'
      # block :silver_stained_glass, '95:8', 'glass_silver.png'
      # block :cyan_stained_glass, '95:9', 'glass_cyan.png'
      # block :purple_stained_glass, '95:10', 'glass_purple.png'
      # block :blue_stained_glass, '95:11', 'glass_blue.png'
      # block :brown_stained_glass, '95:12', 'glass_brown.png'
      # block :green_stained_glass, '95:13', 'glass_green.png'
      # block :red_stained_glass, '95:14', 'glass_red.png'
      # block :black_stained_glass, '95:15', 'glass_black.png'
      #
      # # block :stone_monster_egg, '97', 'stone_monster_egg.png'
      # # block :cobblestone_monster_egg, '97:1', 'cobblestone_monster_egg.png'
      # # block :stone_brick_monster_egg, '97:2', 'stone_brick_monster_egg.png'
      # # block :mossy_stone_brick_monster_egg, '97:3', 'mossy_stone_brick_monster_egg.png'
      # # block :cracked_stone_brick_monster_egg, '97:4', 'cracked_stone_brick_monster_egg.png'
      # # block :chiseled_stone_brick_monster_egg, '97:5', 'chiseled_stone_brick_monster_egg.png'
      # block :stone_bricks, '98', 'stonebrick.png'
      # block :mossy_stone_bricks, '98:1', 'stonebrick_mossy.png'
      # block :cracked_stone_bricks, '98:2', 'stonebrick_cracked.png'
      # block :chiseled_stone_bricks, '98:3', 'stonebrick_carved.png'
      # block :brown_mushroom_block, '99', 'mushroom_block_skin_brown.png'
      # block :red_mushroom_block, '100', 'mushroom_block_skin_red.png'
      #
      # block :melon_block, '103', 'melon_top.png'
      #
      # block :mycelium, '110', 'mycelium_top.png'
      #
      # block :nether_brick, '112', 'nether_brick.png'
      # block :end_portal_frame, '120', 'endframe_top.png'
      # block :end_stone, '121', 'end_stone.png'
      #
      # # block :double_oak_wood_slab, '125', 'double_oak_wood_slab.png'
      # # block :double_spruce_wood_slab, '125:1', 'double_spruce_wood_slab.png'
      # # block :double_birch_wood_slab, '125:2', 'double_birch_wood_slab.png'
      # # block :double_jungle_wood_slab, '125:3', 'double_jungle_wood_slab.png'
      # # block :double_acacia_wood_slab, '125:4', 'double_acacia_wood_slab.png'
      # # block :double_dark_oak_wood_slab, '125:5', 'double_dark_oak_wood_slab.png'
      #
      # block :emerald_ore, '129', 'emerald_ore.png'
      #
      # block :emerald_block, '133', 'emerald_block.png'
      #
      # block :command_block, '137', 'command_block.png'
      #
      # block :redstone_block, '152', 'redstone_block.png'
      # block :nether_quartz_ore, '153', 'quartz_ore.png'
      # block :quartz_block, '155', 'quartz_block_top.png'
      # block :chiseled_quartz_block, '155:1', 'quartz_block_chiseled_top.png'
      # block :pillar_quartz_block, '155:2', 'quartz_block_lines_top.png'
      #
      # block :dropper, '158', 'dropper_front_vertical.png'
      # block :white_stained_clay, '159', 'hardened_clay_stained_white.png'
      # block :orange_stained_clay, '159:1', 'hardened_clay_stained_orange.png'
      # block :magenta_stained_clay, '159:2', 'hardened_clay_stained_magenta.png'
      # block :light_blue_stained_clay, '159:3', 'hardened_clay_stained_light_blue.png'
      # block :yellow_stained_clay, '159:4', 'hardened_clay_stained_yellow.png'
      # block :lime_stained_clay, '159:5', 'hardened_clay_stained_lime.png'
      # block :pink_stained_clay, '159:6', 'hardened_clay_stained_pink.png'
      # block :gray_stained_clay, '159:7', 'hardened_clay_stained_gray.png'
      # block :silver_stained_clay, '159:8', 'hardened_clay_stained_silver.png'
      # block :cyan_stained_clay, '159:9', 'hardened_clay_stained_cyan.png'
      # block :purple_stained_clay, '159:10', 'hardened_clay_stained_purple.png'
      # block :blue_stained_clay, '159:11', 'hardened_clay_stained_blue.png'
      # block :brown_stained_clay, '159:12', 'hardened_clay_stained_brown.png'
      # block :green_stained_clay, '159:13', 'hardened_clay_stained_green.png'
      # block :red_stained_clay, '159:14', 'hardened_clay_stained_red.png'
      # block :black_stained_clay, '159:15', 'hardened_clay_stained_black.png'
      # block :white_stained_glass_pane, '160', 'glass_white.png'
      # block :orange_stained_glass_pane, '160:1', 'glass_orange.png'
      # block :magenta_stained_glass_pane, '160:2', 'glass_magenta.png'
      # block :light_blue_stained_glass_pane, '160:3', 'glass_light_blue.png'
      # block :yellow_stained_glass_pane, '160:4', 'glass_yellow.png'
      # block :lime_stained_glass_pane, '160:5', 'glass_lime.png'
      # block :pink_stained_glass_pane, '160:6', 'glass_pink.png'
      # block :gray_stained_glass_pane, '160:7', 'glass_gray.png'
      # block :silver_stained_glass_pane, '160:8', 'glass_silver.png'
      # block :cyan_stained_glass_pane, '160:9', 'glass_cyan.png'
      # block :purple_stained_glass_pane, '160:10', 'glass_purple.png'
      # block :blue_stained_glass_pane, '160:11', 'glass_blue.png'
      # block :brown_stained_glass_pane, '160:12', 'glass_brown.png'
      # block :green_stained_glass_pane, '160:13', 'glass_green.png'
      # block :red_stained_glass_pane, '160:14', 'glass_red.png'
      # block :black_stained_glass_pane, '160:15', 'glass_black.png'
      # # block :acacia_leaves, '161', 'acacia_leaves.png'
      # # block :dark_oak_leaves, '161:1', 'dark_oak_leaves.png'
      # # block :acacia_wood, '162', 'acacia_wood.png'
      # block :dark_oak_wood, '162:1', 'log_big_oak_top.png'
      #
      # block :slime_block, '165', 'slime.png'
      #
      # # block :prismarine, '168', 'prismarine.png'
      # # TODO: 複数フレームでアニメーションあり
      # block :prismarine_bricks, '168:1', 'prismarine_bricks.png'
      # block :dark_prismarine, '168:2', 'prismarine_dark.png'
      # # block :sea_lantern, '169', 'sea_lantern.png'
      # # TODO: 複数フレームでアニメーションあり
      # block :hay_bale, '170', 'hay_block_top.png'
      #
      # block :hardened_clay, '172', 'hardened_clay.png'
      # block :block_of_coal, '173', 'coal_block.png'
      # block :packed_ice, '174', 'ice_packed.png'
      #
      # block :red_sandstone, '179', 'red_sandstone_top.png'
      # block :chiseled_red_sandstone, '179:1', 'red_sandstone_carved.png'
      # block :smooth_red_sandstone, '179:2', 'red_sandstone_smooth.png'
      # # block :double_red_sandstone_slab, '181', 'double_red_sandstone_slab.png'



      # http://imgur.com/a/MTv0r
      # このカラーパレットを採用したバージョン
      # block :stone, '1', 'stone.png'
      # block :granite, '1:1', 'stone_granite.png'
      # block :polished_granite, '1:2', 'stone_granite_smooth.png'
      # block :diorite, '1:3', 'stone_diorite.png'
      # block :polished_diorite, '1:4', 'stone_diorite_smooth.png'
      # block :andesite, '1:5', 'stone_andesite.png'
      # block :polished_andesite, '1:6', 'stone_andesite_smooth.png'
      #
      # block :dirt, '3', 'dirt.png'
      # block :coarse_dirt, '3:1', 'coarse_dirt.png'
      # block :podzol, '3:2', 'dirt_podzol_top.png'
      # block :cobblestone, '4', 'cobblestone.png'
      block :oak_wood_plank, '5', 'planks_oak.png'
      block :spruce_wood_plank, '5:1', 'planks_spruce.png'
      block :birch_wood_plank, '5:2', 'planks_birch.png'
      block :jungle_wood_plank, '5:3', 'planks_jungle.png'
      # block :acacia_wood_plank, '5:4', 'planks_acacia.png'
      # block :dark_oak_wood_plank, '5:5', 'planks_big_oak.png'
      #
      # block :bedrock, '7', 'bedrock.png'
      #
      # block :sand, '12', 'sand.png'
      # block :red_sand, '12:1', 'red_sand.png'
      # block :gravel, '13', 'gravel.png'
      # block :gold_ore, '14', 'gold_ore.png'
      # block :iron_ore, '15', 'iron_ore.png'
      # block :coal_ore, '16', 'coal_ore.png'
      # block :oak_wood, '17', 'log_oak_top.png' # TODO: テクスチャ注意
      block :sponge, '19', 'sponge.png'
      # block :wet_sponge, '19:1', 'sponge_wet.png'
      # block :glass, '20', 'glass.png'
      # block :lapis_lazuli_ore, '21', 'lapis_ore.png'
      block :lapis_lazuli_block, '22', 'lapis_block.png'
      # block :dispenser, '23', 'dispenser_front_vertical.png'
      block :sandstone, '24', 'sandstone_top.png'
      # block :note_block, '25', 'noteblock.png'
      #
      #
      block :white_wool,'35','wool_colored_white.png'
      #
      block :orange_wool,'35:1','wool_colored_orange.png'
      #
      block :magenta_wool,'35:2','wool_colored_magenta.png'
      #
      block :light_blue_wool,'35:3','wool_colored_light_blue.png'
      #
      block :yellow_wool,'35:4','wool_colored_yellow.png'
      #
      block :lime_wool,'35:5','wool_colored_lime.png'
      block :pink_wool,'35:6','wool_colored_pink.png'
      #
      block :gray_wool,'35:7','wool_colored_gray.png'
      #
      block :silver_wool,'35:8','wool_colored_silver.png'
      block :cyan_wool,'35:9','wool_colored_cyan.png'
      #
      block :purple_wool,'35:10','wool_colored_purple.png'
      #
      block :blue_wool,'35:11','wool_colored_blue.png'
      block :brown_wool,'35:12','wool_colored_brown.png'
      block :green_wool,'35:13','wool_colored_green.png'
      #
      block :red_wool,'35:14','wool_colored_red.png'
      #
      block :black_wool,'35:15','wool_colored_black.png'
      #
      block :gold_block, '41', 'gold_block.png'
      block :iron_block, '42', 'iron_block.png'
      # block :double_stone_slab, '43', 'stone_slab_top.png'
      #
      block :bricks, '45', 'brick.png'
      # block :tnt, '46', 'tnt_top.png'
      #
      # block :moss_stone, '48', 'cobblestone_mossy.png'
      block :obsidian, '49', 'obsidian.png'
      #
      # block :diamond_ore, '56', 'diamond_ore.png'
      block :diamond_block, '57', 'diamond_block.png'
      # block :crafting_table, '58', 'crafting_table_top.png'
      #
      # block :farmland, '60', 'farmland_dry.png'
      #
      # block :redstone_ore, '73', 'redstone_ore.png'
      #
      # block :snow, '78', 'snow.png'
      block :ice, '79', 'ice.png'
      #
          block :clay, '82', 'clay.png'
      #
      # block :jukebox, '84', 'jukebox_top.png'
      #
      # block :pumpkin, '86', 'pumpkin_top.png'
      # block :netherrack, '87', 'netherrack.png'
          block :soul_sand, '88', 'soul_sand.png'
      block :glowstone, '89', 'glowstone.png'
      #
      # block :cake_block, '92', 'cake_top.png'
      #
      # block :white_stained_glass, '95', 'glass_white.png'
      # block :orange_stained_glass, '95:1', 'glass_orange.png'
      # block :magenta_stained_glass, '95:2', 'glass_magenta.png'
      # block :light_blue_stained_glass, '95:3', 'glass_light_blue.png'
      # block :yellow_stained_glass, '95:4', 'glass_yellow.png'
      # block :lime_stained_glass, '95:5', 'glass_lime.png'
      # block :pink_stained_glass, '95:6', 'glass_pink.png'
      # block :gray_stained_glass, '95:7', 'glass_gray.png'
      # block :silver_stained_glass, '95:8', 'glass_silver.png'
      # block :cyan_stained_glass, '95:9', 'glass_cyan.png'
      # block :purple_stained_glass, '95:10', 'glass_purple.png'
      # block :blue_stained_glass, '95:11', 'glass_blue.png'
      # block :brown_stained_glass, '95:12', 'glass_brown.png'
      # block :green_stained_glass, '95:13', 'glass_green.png'
      # block :red_stained_glass, '95:14', 'glass_red.png'
      # block :black_stained_glass, '95:15', 'glass_black.png'
      #
      # block :stone_bricks, '98', 'stonebrick.png'
      block :mossy_stone_bricks, '98:1', 'stonebrick_mossy.png'
      # block :cracked_stone_bricks, '98:2', 'stonebrick_cracked.png'
      block :chiseled_stone_bricks, '98:3', 'stonebrick_carved.png'
      # block :brown_mushroom_block, '99', 'mushroom_block_skin_brown.png'
      # block :red_mushroom_block, '100', 'mushroom_block_skin_red.png'
      #
      block :melon_block, '103', 'melon_top.png'
      #
      # block :mycelium, '110', 'mycelium_top.png'
      #
      block :nether_brick, '112', 'nether_brick.png'
      # block :end_portal_frame, '120', 'endframe_top.png'
      # block :end_stone, '121', 'end_stone.png'
      #
      # block :emerald_ore, '129', 'emerald_ore.png'
      #
      block :emerald_block, '133', 'emerald_block.png'
      #
      # block :command_block, '137', 'command_block.png'
      #
      block :redstone_block, '152', 'redstone_block.png'
      # block :nether_quartz_ore, '153', 'quartz_ore.png'
      # block :quartz_block, '155', 'quartz_block_top.png'
      block :chiseled_quartz_block, '155:1', 'quartz_block_chiseled_top.png'
      # block :pillar_quartz_block, '155:2', 'quartz_block_lines_top.png'
      #
      # block :dropper, '158', 'dropper_front_vertical.png'

      #
      block :white_stained_clay, '159', 'hardened_clay_stained_white.png'
      block :orange_stained_clay, '159:1', 'hardened_clay_stained_orange.png'
      #
      block :magenta_stained_clay, '159:2', 'hardened_clay_stained_magenta.png'
      block :light_blue_stained_clay, '159:3', 'hardened_clay_stained_light_blue.png'
      block :yellow_stained_clay, '159:4', 'hardened_clay_stained_yellow.png'
      block :lime_stained_clay, '159:5', 'hardened_clay_stained_lime.png'
      #
      block :pink_stained_clay, '159:6', 'hardened_clay_stained_pink.png'
      #
      block :gray_stained_clay, '159:7', 'hardened_clay_stained_gray.png'
      #
      block :silver_stained_clay, '159:8', 'hardened_clay_stained_silver.png'
      block :cyan_stained_clay, '159:9', 'hardened_clay_stained_cyan.png'
      block :purple_stained_clay, '159:10', 'hardened_clay_stained_purple.png'
      block :blue_stained_clay, '159:11', 'hardened_clay_stained_blue.png'
      block :brown_stained_clay, '159:12', 'hardened_clay_stained_brown.png'
      block :green_stained_clay, '159:13', 'hardened_clay_stained_green.png'
      block :red_stained_clay, '159:14', 'hardened_clay_stained_red.png'
      block :black_stained_clay, '159:15', 'hardened_clay_stained_black.png'
      # block :white_stained_glass_pane, '160', 'glass_white.png'
      # block :orange_stained_glass_pane, '160:1', 'glass_orange.png'
      # block :magenta_stained_glass_pane, '160:2', 'glass_magenta.png'
      # block :light_blue_stained_glass_pane, '160:3', 'glass_light_blue.png'
      # block :yellow_stained_glass_pane, '160:4', 'glass_yellow.png'
      # block :lime_stained_glass_pane, '160:5', 'glass_lime.png'
      # block :pink_stained_glass_pane, '160:6', 'glass_pink.png'
      # block :gray_stained_glass_pane, '160:7', 'glass_gray.png'
      # block :silver_stained_glass_pane, '160:8', 'glass_silver.png'
      # block :cyan_stained_glass_pane, '160:9', 'glass_cyan.png'
      # block :purple_stained_glass_pane, '160:10', 'glass_purple.png'
      # block :blue_stained_glass_pane, '160:11', 'glass_blue.png'
      # block :brown_stained_glass_pane, '160:12', 'glass_brown.png'
      # block :green_stained_glass_pane, '160:13', 'glass_green.png'
      # block :red_stained_glass_pane, '160:14', 'glass_red.png'
      # block :black_stained_glass_pane, '160:15', 'glass_black.png'
      # block :dark_oak_wood, '162:1', 'log_big_oak_top.png'
      #
      # block :slime_block, '165', 'slime.png'
      #
      # block :prismarine_bricks, '168:1', 'prismarine_bricks.png'
      # block :dark_prismarine, '168:2', 'prismarine_dark.png'
      block :hay_bale, '170', 'hay_block_top.png'
      #
      block :hardened_clay, '172', 'hardened_clay.png'
      block :block_of_coal, '173', 'coal_block.png'
      # block :packed_ice, '174', 'ice_packed.png'
      #
      # block :red_sandstone, '179', 'red_sandstone_top.png'
      # block :chiseled_red_sandstone, '179:1', 'red_sandstone_carved.png'
      # block :smooth_red_sandstone, '179:2', 'red_sandstone_smooth.png'

    end
    def add(b)
      @blocks << b
    end
    alias_method  :<<,:add

    def size
      @blocks.size
    end
    alias_method :length,:size

    def each
      @blocks.each do |b|
        yield b
      end
    end

    def color_palette
      # Make color palette
      new_image = Magick::Image.new(@blocks.size,1){ self.background_color = "white" }
      @blocks.each_with_index do |block,index|
        new_image.pixel_color(index,0,block.to_rmagic_color)
      end
      new_image
    end

    private
    def block(name, id_data_label, filename)
      # Add blocks to @blocks
      # image = Magick::ImageList.new(File.expand_path("../textures/#{filename}", __FILE__)).first
      image = @loader.load_texture(filename)

      color = calc_average_color(image)
      id = id_data_label.split(':')[0].to_i
      data = id_data_label.split(':')[1].to_i

      block = Block.new(name,id, data,color, image)
      @blocks << block
      MCDotArtMaker.puts "Block #{name} registered: #{color}"
    end

    def calc_average_color(image)
      pixels = image.get_pixels(0,0,image.columns,image.rows)

      sum_r = pixels.reduce(0) do |a,elem|
        a+elem.red/257
      end
      ave_r = sum_r/pixels.size

      sum_g = pixels.reduce(0) do |a,elem|
        a+elem.green/257
      end
      ave_g = sum_g/pixels.size

      sum_b = pixels.reduce(0) do |a,elem|
        a+elem.blue/257
      end
      ave_b = sum_b/pixels.size

      Color::RGB.new(ave_r, ave_g, ave_b)
    end
  end
end
