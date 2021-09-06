local base_recipe = {}
-- grab rail recipe ingredients except stone
for _,component in pairs(data.raw["recipe"]["rail"].ingredients) do
	cname = component[1] or component["name"]
	camount = component[2] or component["amount"]
	if cname ~= "stone" then
		table.insert(base_recipe,{cname,camount})
	end
end

data.raw["recipe"]["bbr-rail-wood"].ingredients = table.deepcopy(base_recipe)
data.raw["recipe"]["bbr-rail-iron"].ingredients = table.deepcopy(base_recipe)
data.raw["recipe"]["bbr-rail-brick"].ingredients = table.deepcopy(base_recipe)

multiplier = settings.startup["bbr-fix-cost"].value

if multiplier>0 then
	table.insert(data.raw["recipe"]["bbr-rail-wood"].ingredients,{"wood",multiplier})
	table.insert(data.raw["recipe"]["bbr-rail-iron"].ingredients,{"iron-plate",multiplier})
	table.insert(data.raw["recipe"]["bbr-rail-brick"].ingredients,{"stone-brick",multiplier})
else
	table.insert(data.raw["recipe"]["bbr-rail-wood"].ingredients,{"wood",1})
	table.insert(data.raw["recipe"]["bbr-rail-iron"].ingredients,{"iron-plate",1})
	table.insert(data.raw["recipe"]["bbr-rail-brick"].ingredients,{"stone-brick",1})
end