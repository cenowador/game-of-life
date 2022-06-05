/// @description iterate

if(!paused){
	for(var i = 0; i < grid_ys; ++i){
		for(var j = 0; j < grid_xs; ++j){
			iterate(get_being(j, i));
		}
	}
	iteration_end();
}
alarm[0] = room_speed/2;
