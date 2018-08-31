//Do sanity checks to make sure the space is on the board and not occupied by
//another piece of the same color.
var space, grid;

var piece = argument[0];
var xoffset = argument[1];
var yoffset = argument[2];
if(argument_count > 3)
    grid = argument[3];
else
    grid = global.board;
//Check if it's actually on the board... duh
if(piece.gridx + xoffset >= 0 && piece.gridx + xoffset <= 7 &&
    piece.gridy + yoffset >= 0 && piece.gridy + yoffset <= 7)
{
    space = grid[# piece.gridx+xoffset, piece.gridy+yoffset];
    if(space == noone || space.color != piece.color)
    {
        //If we're checking the actual board and not a simulated copy of it,
        //then check if this move would result in the king going into check.
        if(grid != global.board || !scr_move_is_check(piece, xoffset, yoffset))
            return true;
    }
}
return false;
