-- Check for Recipe Overhaul, and if true, establish the fundamental complex recipes
if settings.startup["vanillaLoaders-recipes-loaderOverhaul"].value == true then
	-- Check for presence of LoaderRedux, and check if we are supposed to use LoaderRedux recipes. If true, stop here.
	if mods["LoaderRedux"] and settings.startup["vanillaLoaders-recipes-loaderReduxCompliant"].value == true then return end
	
	-- Create the complex Vanilla loader recipes
	data:extend({
		{	name = "loader",		 -- Loader (Yellow)
			type = "recipe",
			enabled = false,
			energy_required = 5,
			ingredients = 
			{
				{"electronic-circuit", 5},
				{"transport-belt", 	   5},
				{"iron-gear-wheel",	  16},
				{"inserter", 		   4}
			},
			result_count = 1,
			result = "loader",
		},
		{	name = "fast-loader",	 -- Fast Loader (Red)
			type = "recipe",			
			enabled = false,
			energy_required = 5,
			ingredients = 
			{
				{"electronic-circuit", 10},
				{"loader", 				1},
				{"iron-gear-wheel",    24},
				{"fast-transport-belt", 5}
			},
			result_count = 1,
			result = "fast-loader",
		},
		{	name = "express-loader", -- Express Loader (Blue)
			type = "recipe",
			category = "crafting-with-fluid",
			enabled = false,
			energy_required = 5,
			ingredients = 
			{
				{"advanced-circuit", 	  10},
				{"fast-loader", 		   1},
				{"iron-gear-wheel", 	  32},
				{"express-transport-belt", 5},
				{amount = 40,name = "lubricant",type = "fluid"}
			},
			result_count = 1,
			result = "express-loader",
		}
	})
	
	-- Check for presense of Bob's Logistics
	if mods["boblogistics"] then
		-- Check to see if we're using Bob's Logistics transport belt overhaul, and if so, create Bob-style loader base recipes.
		if settings.startup["bobmods-logistics-beltoverhaul"].value == true then
			data:extend({
				{	name = "loader",		 -- Loader (Yellow) (Bob Overhaul Base)
					type = "recipe",					
					enabled = false,
					energy_required = 5,
					ingredients = 
					{
						{"electronic-circuit", 5},
						{"transport-belt", 	   5},
						{"iron-gear-wheel",    6},
						{"iron-plate", 		   6}
					},
					result_count = 1,
					result = "loader",
				},
				{	name = "fast-loader",	 -- Fast Loader (Red) (Bob Overhaul Base)
					type = "recipe",					
					enabled = false,
					energy_required = 5,
					ingredients = 
					{
						{"electronic-circuit",  5},
						{"fast-transport-belt", 5},
						{"iron-gear-wheel",  	6},
						{"steel-plate", 	 	6}
					},
					result_count = 1,
					result = "fast-loader",
				},
				{	name = "express-loader", -- Express Loader (Blue) (Bob Overhaul Base)
					type = "recipe",					
					enabled = false,
					energy_required = 5,
					ingredients = 
					{
						{"advanced-circuit", 	   5},
						{"express-transport-belt", 5},
						{"iron-gear-wheel",    	   6},
						{"steel-plate", 	       6}
					},
					result_count = 1,
					result = "express-loader",
				},
				{	name = "purple-loader",  -- Turbo Loader (Purple) (Bob Overhaul Base)
					type = "recipe",					
					enabled = false,
					energy_required = 5,
					ingredients = 
					{
						{"processing-unit", 	 5},
						{"turbo-transport-belt", 5},
						{"iron-gear-wheel",  	 6},
						{"steel-plate", 	 	 6}
					},
					result_count = 1,
					result = "purple-loader",
				},
				{	name = "green-loader",	 -- Ultimate Loader (Green) (Bob Overhaul Base)
					type = "recipe",					
					enabled = false,
					energy_required = 5,
					ingredients = 
					{
						{"processing-unit", 		5},
						{"ultimate-transport-belt", 5},
						{"iron-gear-wheel", 		6},
						{"steel-plate", 			6}
					},
					result_count = 1,
					result = "green-loader",
				},
			})			

			-- Now that recipes have been created and initialized in their base-complex form, 
			-- check for whether we want to include inserters.
			if settings.startup["vanillaLoaders-recipes-includeInserters"].value == true then
				-- Check if we're using Bob's Logistics inserter overhaul
				if settings.startup["bobmods-logistics-inserteroverhaul"].value == true then
					-- Add overhauled inserters to loader recipes.
					bobmods.lib.recipe.add_ingredient("loader",         {"yellow-filter-inserter",		  5})
					bobmods.lib.recipe.add_ingredient("fast-loader",    {"red-stack-filter-inserter",	  5})
					bobmods.lib.recipe.add_ingredient("express-loader", {"stack-filter-inserter",		  5})
					bobmods.lib.recipe.add_ingredient("purple-loader",  {"turbo-stack-filter-inserter",	  5})
					bobmods.lib.recipe.add_ingredient("green-loader",   {"express-stack-filter-inserter", 5})
				else
					-- Add default inserters to loader recipes.
					bobmods.lib.recipe.add_ingredient("loader",         {"inserter", 			   5})
					bobmods.lib.recipe.add_ingredient("fast-loader",    {"long-handed-inserter",   5})
					bobmods.lib.recipe.add_ingredient("express-loader", {"fast-inserter", 		   5})
					bobmods.lib.recipe.add_ingredient("purple-loader",  {"stack-inserter",  	   5})
					bobmods.lib.recipe.add_ingredient("green-loader",   {"express-stack-inserter", 5})
				end
			end

			-- Check if we want to require the previous tier in the recipes, if so, make changes.
			if settings.startup["bobmods-logistics-beltrequireprevious"].value == true then
				bobmods.lib.recipe.add_ingredient("loader",         {"basic-loader",     1})
				bobmods.lib.recipe.add_ingredient("loader",         {"iron-gear-wheel", 10})
				bobmods.lib.recipe.add_ingredient("loader",         {"iron-plate",   	 4})
				
				bobmods.lib.recipe.add_ingredient("fast-loader",    {"loader", 		   	 1})
				bobmods.lib.recipe.add_ingredient("fast-loader",    {"iron-gear-wheel", 10})
				bobmods.lib.recipe.add_ingredient("fast-loader",    {"steel-plate",		 4})
				
				bobmods.lib.recipe.add_ingredient("express-loader", {"fast-loader",      1})
				bobmods.lib.recipe.add_ingredient("express-loader", {"iron-gear-wheel", 10})
				bobmods.lib.recipe.add_ingredient("express-loader", {"steel-plate",      4})
				
				bobmods.lib.recipe.add_ingredient("purple-loader",  {"express-loader",   1})
				bobmods.lib.recipe.add_ingredient("purple-loader",  {"iron-gear-wheel", 10})
				bobmods.lib.recipe.add_ingredient("purple-loader",  {"steel-plate",      4})
				
				bobmods.lib.recipe.add_ingredient("green-loader",   {"purple-loader",    1})
				bobmods.lib.recipe.add_ingredient("green-loader",   {"iron-gear-wheel", 10})
				bobmods.lib.recipe.add_ingredient("green-loader",   {"steel-plate",      4})
			end			
			
		else 
		-- Create the complex Bob's Logistics loader recipies
		data:extend({
			{	name = "purple-loader",	-- Turbo Loader (Purple)
				type = "recipe",
				category = "crafting-with-fluid",				
				enabled = false,
				energy_required = 5,
				ingredients = 
				{
					{"processing-unit", 	10},
					{"express-loader",   	 1},
					{"iron-gear-wheel", 	48},
					{"turbo-transport-belt", 5},
					{amount = 80,name = "lubricant",type = "fluid"}
				},
				result_count = 1,
				result = "purple-loader",
			},
			{	name = "green-loader",  -- Ultimate Loader (Green)
				type = "recipe",
				category = "crafting-with-fluid",				
				enabled = false,
				energy_required = 5,
				ingredients = 
				{
					{"processing-unit", 	   10},
					{"purple-loader", 		    1},
					{"iron-gear-wheel", 	   60},
					{"ultimate-transport-belt", 5},
					{amount = 120,name = "lubricant",type = "fluid"}
				},
				result_count = 1,
				result = "green-loader",
			}
		})
		end	
	end
end