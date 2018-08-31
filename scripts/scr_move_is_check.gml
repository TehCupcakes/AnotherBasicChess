var grid, kingx, kingy, moves;

var check = false;

var piece = argument0;
var xoffset = argument1;
var yoffset = argument2;

//We assume the space is valid because this script is called from the script that
//has already verified it is valid.

//First, simulate what the board would be like after the move is made
grid = ds_grid_create(ds_grid_width(global.board), ds_grid_height(global.board));
ds_grid_copy(grid, global.board);
grid[# piece.gridx, piece.gridy] = noone;
grid[# piece.gridx+xoffset, piece.gridy+yoffset] = piece;

//Get the king's x and y index because we'll need this later
if(piece.object_index == obj_king)
{
    kingx = piece.gridx+xoffset;
    kingy = piece.gridy+yoffset;
}
else
{
    //Now get this player's king piece, if "piece" wasn't the king...
    with(obj_king)
    {
        if(color == global.player_turn)
        {
            kingx = gridx;
            kingy = gridy;
        }
    }
}

//Now check all the opponents pieces to see if they can move to the king's spot
with(par_piece)
{
    //If it's this player's piece, ignore it
    //Also skip this piece if it would be destroyed by the proposed move
    if(color != global.player_turn
        && (gridx != piece.gridx+xoffset || gridy != piece.gridy+yoffset
            || (xoffset == 0 && yoffset == 0)))
    {
        moves = scr_valid_moves(id, grid);
        if(moves[kingx, kingy] == 1)
        {
            check = true;
            break;
        }
    }
}

//Clean up
ds_grid_destroy(grid);

return check;
