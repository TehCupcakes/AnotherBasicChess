var color_sign, yindex, yoffset;

var grid = argument0; //The ds_grid to insert into
var size = argument1; //grid size (px)
var offset = argument2; //border size (px)
for(var color = COLOR.gold; color <= COLOR.silver; color++)
{
    yindex = 7 * color;
    grid[# 0, yindex] = scr_create_piece(0, yindex, obj_rook, color);
    grid[# 1, yindex] = scr_create_piece(1, yindex, obj_bishop, color);
    grid[# 2, yindex] = scr_create_piece(2, yindex, obj_knight, color);
    grid[# 3, yindex] = scr_create_piece(3, yindex, obj_queen, color);
    grid[# 4, yindex] = scr_create_piece(4, yindex, obj_king, color);
    grid[# 5, yindex] = scr_create_piece(5, yindex, obj_knight, color);
    grid[# 6, yindex] = scr_create_piece(6, yindex, obj_bishop, color);
    grid[# 7, yindex] = scr_create_piece(7, yindex, obj_rook, color);
    
    //Create pawns
    for(var i = 0; i < 8; i++)
    {
        yindex = 7 * color - (color*2 - 1);
        grid[# i, yindex] = scr_create_piece(i, yindex, obj_pawn, color);
    }
}

//Initialize all other values in the grid to "noone"
for(var yy = 2; yy < 6; yy++)
{
    for(var xx = 0; xx < 8; xx++)
    {
        grid[# xx, yy] = noone;
    }
}
