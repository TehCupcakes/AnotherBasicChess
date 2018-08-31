var space, grid;

var piece = argument[0];
var xoffset = argument[1];
var yoffset = argument[2];
if(argument_count > 3)
    grid = argument[3];
else
    grid = global.board;
if(scr_space_valid(piece, xoffset, yoffset, grid))
{
    space = grid[# piece.gridx+xoffset, piece.gridy+yoffset];
    if(space != noone && space.color != piece.color)
        return true;
}
return false;
