if settings.startup["bbr_fix_expensive"].value then
	data.raw["recipe"]["bbr-rail-wood"].ingredients = {{"rail",1},{"wood",5}}
	data.raw["recipe"]["bbr-rail-iron"].ingredients = {{"rail",1},{"iron-plate",5}}
	data.raw["recipe"]["bbr-rail-brick"].ingredients = {{"rail",1},{"stone-brick",5}}
else
	data.raw["recipe"]["bbr-rail-wood"].ingredients = {{"rail",1},{"wood",1}}
	data.raw["recipe"]["bbr-rail-iron"].ingredients = {{"rail",1},{"iron-plate",1}}
	data.raw["recipe"]["bbr-rail-brick"].ingredients = {{"rail",1},{"stone-brick",1}}
end