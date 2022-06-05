/// @description Insert description here
if(ds_exists(grid_beings, ds_type_grid)){
	ds_grid_destroy(grid_beings);
	grid_beings = noone;
}
if(ds_exists(grid_beings_next, ds_type_grid)){
	ds_grid_destroy(grid_beings_next);
	grid_beings_next = noone;
}
if(surface_exists(grid_surf)){
	surface_free(grid_surf);
	grid_surf = noone;	
}

if(buffer_exists(grid_buff)){
	buffer_delete(grid_buff);
	grid_buff = noone;	
}
