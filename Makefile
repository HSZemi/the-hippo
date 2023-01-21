default: 0-head.rms 1-player-setup.rms 2-land-generation.rms 3-elevation-generation.rms 4-cliff-generation.rms 5-terrain-generation.rms 6-connection-generation.rms 7-objects-generation.rms
	cat $+ > the-hippo.rms

install: the-hippo.rms
	cp the-hippo.rms ~/aoe/aoe2mods/local/map_test/resources/_common/random-map-scripts/

# inner-mouth-2.rms: venv inner-mouth.png
# 	. venv/bin/activate
# 	./image-to-lands.py inner-mouth.png TERRAIN_INNER_MOUTH 1 > $@

mouth-outline.rms: venv mouth-outline.png
	. venv/bin/activate
	./image-to-lands.py mouth-outline.png TERRAIN_MOUTH_OUTLINE 2 > $@

outer-body.rms: venv outer-body.png
	. venv/bin/activate
	./image-to-lands.py outer-body.png TERRAIN_OUTER_BODY 1 > $@

rays-corner.rms: venv rays-corner.png
	. venv/bin/activate
	./image-to-lands.py rays-corner.png TERRAIN_RAYS_CORNER 2 > $@
	sed -i $@ -e 's/land_position 5 5 /land_position 5 5 \n  land_id 102/'
	sed -i $@ -e 's/land_position 96 96 /land_position 96 96 \n  land_id 103/'
	sed -i $@ -e 's/land_position 5 96 /land_position 5 96 \n  land_id 104/'
	sed -i $@ -e 's/land_position 96 5 /land_position 96 5 \n  land_id 105/'

rays-other.rms: venv rays-other.png
	. venv/bin/activate
	./image-to-lands.py rays-other.png TERRAIN_RAYS_OTHER 1 > $@

ridge.rms: venv ridge.png
	. venv/bin/activate
	./image-to-lands.py ridge.png TERRAIN_RIDGE 1 > $@
	sed -i $@ -e 's/land_position 50 50 /land_position 50 50 \n  land_id 101/'


teeth.rms: venv teeth.png
	. venv/bin/activate
	./image-to-lands.py teeth.png TERRAIN_TEETH 1 > $@
	sed -i $@ -e 's/land_position 60 28 /land_position 60 28 \n  assign_to_player 2/'
	sed -i $@ -e 's/land_position 72 40 /land_position 72 40 \n  assign_to_player 2/'
	sed -i $@ -e 's/land_position 28 60 /land_position 28 60 \n  assign_to_player 1/'
	sed -i $@ -e 's/land_position 40 72 /land_position 40 72 \n  assign_to_player 1/'


2-land-generation.rms: ridge.rms teeth.rms mouth-outline.rms outer-body.rms rays-corner.rms rays-other.rms inner-mouth.rms 
	echo "/* 2-land-generation.rms */\n<LAND_GENERATION>\nbase_terrain TERRAIN_BASE\n" > $@
	cat $+ >> $@


venv: requirements.txt
	python3 -m venv venv
	. venv/bin/activate
	pip install -r $+

clean:
	rm -f ridge.rms teeth.rms mouth-outline.rms outer-body.rms rays-corner.rms rays-other.rms the-hippo.rms
 
 clean-venv:
	rm -rf venv