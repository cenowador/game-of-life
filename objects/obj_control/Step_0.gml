/// @description get if must spawn

if(keyboard_check_pressed(vk_space))
	paused = !paused;

if(mouse_check_button(mb_left)){
	var px = floor(mouse_x/grid_cell);
	var py = floor(mouse_y/grid_cell);
	spawn(px, py);
	spawn_next(px, py);
}
