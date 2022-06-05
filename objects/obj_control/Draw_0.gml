/// @description draw

//check if grid exists
if(!surface_exists(grid_surf)){
	grid_surf = surface_create(view_wport[0], view_hport[0]);
	if(buffer_exists(grid_buff)){
		//reset grid
		buffer_set_surface(grid_buff, grid_surf, 0);
	}
	else{
		//first draw grid
		surface_set_target(grid_surf);
		draw_clear_alpha(c_white, 0);
		draw_set_color(c_white);
		for(var i = 0; i < grid_ys; ++i){
			draw_line(0, i*grid_cell, view_wport[0], i*grid_cell);
		}
		for(var i = 0; i < grid_xs; ++i){
			draw_line(i*grid_cell, 0, i*grid_cell, view_hport[0]);
		}
		surface_reset_target();
		grid_buff = buffer_create(view_wport[0]*view_hport[0]*4, buffer_fast, 1);
		buffer_get_surface(grid_buff, grid_surf, 0);
	}
}
draw_surface(grid_surf, 0, 0);

//draw all alive beings
for(var i = 0; i < grid_ys; ++i){
	for(var j = 0; j < grid_xs; ++j){
		var being = get_being(j, i);
		if(is_struct(being) && being.alive){
			draw_sprite(spr_being, 0, j*grid_cell, i*grid_cell);
		}
	}
}

if(paused){
	draw_set_color(c_red);
	draw_text(0, 0, "paused");
}
