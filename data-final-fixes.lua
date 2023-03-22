-- setup id helper maps
ingredients_id_map = {old = false}
for id, item in pairs(data.raw["recipe"]["rail"].ingredients) do 
	ingredients_id_map[item[1] or item["name"]] = id
	if item[1] then
		ingredients_id_map["old"] = true
	end
end

if data.raw["recipe"]["rail"].products then
	products_id_map = {}
	print(tprint(data.raw["recipe"]["rail"]))
	for id, item in pairs(data.raw["recipe"]["rail"].products) do products_id_map[item[1] or item["name"]] = id end
end


-- mod integrations
if mods["IndustrialRevolution3"] then
	replace_item = "gravel"
else
	replace_item = "stone"
end


-- get multiplier
multiplier = settings.startup["bbr-fix-cost"].value


-- setup bridge material list
bridges = {
	{name = "wood", item = "wood"},
	{name = "iron", item = "iron-plate"},
	{name = "brick", item = "stone-brick"}
}

for _, bridge in pairs(bridges) do
	-- copy rail recipe to bridge
	data.raw["recipe"]["bbr-rail-"..bridge.name]  = table.deepcopy(data.raw["recipe"]["rail"])

	-- fix recipe name
	data.raw["recipe"]["bbr-rail-"..bridge.name].name  = "bbr-rail-"..bridge.name

	-- replace stone with multiplied bridge material
	if ingredients_id_map.old then
		data.raw["recipe"]["bbr-rail-"..bridge.name].ingredients[ingredients_id_map[replace_item]][1]  = bridge.item
		
		-- apply multiplier
		if multiplier > 1 then
			data.raw["recipe"]["bbr-rail-"..bridge.name].ingredients[ingredients_id_map[replace_item]][2]  = multiplier * data.raw["recipe"]["bbr-rail-"..bridge.name].ingredients[ingredients_id_map[replace_item]][2]
		end
	else
		data.raw["recipe"]["bbr-rail-"..bridge.name].ingredients[ingredients_id_map[replace_item]].name  = bridge.item

		-- apply multiplier
		if multiplier > 1 then
			data.raw["recipe"]["bbr-rail-"..bridge.name].ingredients[ingredients_id_map[replace_item]].amount  = multiplier * data.raw["recipe"]["bbr-rail-"..bridge.name].ingredients[ingredients_id_map[replace_item]].amount
		end
	end

	-- replace rails with bridges
	if products_id_map then
		data.raw["recipe"]["bbr-rail-"..bridge.name].products[products_id_map["rail"]].name = "bbr-rail-"..bridge.name
	else
		data.raw["recipe"]["bbr-rail-"..bridge.name].result = "bbr-rail-"..bridge.name
	end
end