/// @description variables

paused = true;

grid_surf = noone;
grid_buff = noone;
grid_cell = 16;
grid_ys = ceil(view_hport[0]/grid_cell);
grid_xs = ceil(view_wport[0]/grid_cell);
grid_beings = ds_grid_create(grid_xs, grid_ys);
grid_beings_next = ds_grid_create(grid_xs, grid_ys);

spawn = function(_px, _py, _alive=true){
	var being = {
		alive: _alive,
		px: _px,
		py: _py
	}
	ds_grid_set(grid_beings, _px, _py, being);
	return being;
}

spawn_next = function(_px, _py, _alive=true){
	var being = {
		alive: _alive,
		px: _px,
		py: _py
	}
	ds_grid_set(grid_beings_next, _px, _py, being);
	return being;
}

get_being = function(xpos, ypos){
	if(ypos < 0 || ypos >= grid_ys || xpos < 0 || xpos >= grid_xs)
		return undefined;
	return ds_grid_get(grid_beings, xpos, ypos);
}

set_being_next = function(xpos, ypos, being){
	ds_grid_set(grid_beings_next, xpos, ypos, being);
}

iterate = function(being){
	var aliveNeighbours = 0;
	for(var i = -1; i <= 1; ++i){
		for(var j = -1; j <= 1; ++j){
			if(i == 0 && j == 0){
				continue;
			}
			var neighbour = get_being(being.px-j, being.py-i);
			if(!is_struct(neighbour))
				continue;
				
			if(neighbour.alive){
				aliveNeighbours += 1;	
			}
		}
	}
	if(being.alive){
		//Any live cell with two or three live neighbours lives on to the next generation.
		set_being_next(being.px, being.py, {
			alive: (aliveNeighbours == 2 || aliveNeighbours == 3),
			px: being.px,
			py: being.py
		});
	}
	else{
		//Any dead cell with exactly three live neighbours becomes a live cell
		set_being_next(being.px, being.py, {
			alive: (aliveNeighbours == 3),
			px: being.px,
			py: being.py
		})
	}
}

iteration_end = function(){
	ds_grid_destroy(grid_beings);
	grid_beings = grid_beings_next;
	grid_beings_next = ds_grid_create(grid_xs, grid_ys);
	ds_grid_copy(grid_beings_next, grid_beings);
}

//start
for(var i = 0; i < grid_ys; ++i){
	for(var j = 0; j < grid_xs; ++j){
		spawn(j, i, false);
		spawn_next(j, i, false);
	}
}
alarm[0] = room_speed/2;
