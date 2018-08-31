//Get an array of all moves for a given piece
var piece, moves, grid, enemy;
if(argument_count > 0)
    piece = argument[0];
else
    piece = id;
if(argument_count > 1)
    grid = argument[1];
else
    grid = global.board;
    
//First, fill the array with 0 (assume all invalid)
for(var i = 0; i < 8; i++)
{
    for(var j = 0; j < 8; j++)
    {
        moves[j, i] = 0;
    }
}

switch(piece.object_index)
{
    case obj_king:
        if(scr_space_valid(piece, -1, -1, grid)) moves[piece.gridx-1, piece.gridy-1] = 1;
        if(scr_space_valid(piece, -1, 0, grid)) moves[piece.gridx-1, piece.gridy] = 1;
        if(scr_space_valid(piece, -1, 1, grid)) moves[piece.gridx-1, piece.gridy+1] = 1;
        if(scr_space_valid(piece, 0, -1, grid)) moves[piece.gridx, piece.gridy-1] = 1;
        if(scr_space_valid(piece, 0, 1, grid)) moves[piece.gridx, piece.gridy+1] = 1;
        if(scr_space_valid(piece, 1, -1, grid)) moves[piece.gridx+1, piece.gridy-1] = 1;
        if(scr_space_valid(piece, 1, 0, grid)) moves[piece.gridx+1, piece.gridy] = 1;
        if(scr_space_valid(piece, 1, 1, grid)) moves[piece.gridx+1, piece.gridy+1] = 1;
        break;
    case obj_queen:
        for(var dir = 0; dir < 360; dir += 45)
        {
            var xdir = sign(lengthdir_x(1, dir));
            var ydir = sign(lengthdir_y(1, dir));
            var xoffset = xdir;
            var yoffset = ydir;
            while(scr_space_valid(piece, xoffset, yoffset, grid))
            {
                moves[piece.gridx+xoffset, piece.gridy+yoffset] = 1;
                //You can move to an enemy space, but not through them
                if(scr_space_has_enemy(piece, xoffset, yoffset, grid))
                    break;
                
                xoffset += xdir;
                yoffset += ydir;
            }
        }
        break;
    case obj_rook:
        for(var dir = 0; dir < 360; dir += 90)
        {
            var xdir = sign(lengthdir_x(1, dir));
            var ydir = sign(lengthdir_y(1, dir));
            var xoffset = xdir;
            var yoffset = ydir;
            while(scr_space_valid(piece, xoffset, yoffset, grid))
            {
                moves[piece.gridx+xoffset, piece.gridy+yoffset] = 1;
                //You can move to an enemy space, but not through them
                if(scr_space_has_enemy(piece, xoffset, yoffset, grid))
                    break;
                
                xoffset += xdir;
                yoffset += ydir;
            }
        }
        break;
    case obj_knight:
        if(scr_space_valid(piece, -2, -1, grid)) moves[piece.gridx-2, piece.gridy-1] = 1;
        if(scr_space_valid(piece, -1, -2, grid)) moves[piece.gridx-1, piece.gridy-2] = 1;
        if(scr_space_valid(piece, 2, -1, grid)) moves[piece.gridx+2, piece.gridy-1] = 1;
        if(scr_space_valid(piece, 1, -2, grid)) moves[piece.gridx+1, piece.gridy-2] = 1;
        if(scr_space_valid(piece, -2, 1, grid)) moves[piece.gridx-2, piece.gridy+1] = 1;
        if(scr_space_valid(piece, -1, 2, grid)) moves[piece.gridx-1, piece.gridy+2] = 1;
        if(scr_space_valid(piece, 2, 1, grid)) moves[piece.gridx+2, piece.gridy+1] = 1;
        if(scr_space_valid(piece, 1, 2, grid)) moves[piece.gridx+1, piece.gridy+2] = 1;
        break;
    case obj_bishop:
        for(var dir = 45; dir < 360; dir += 90)
        {
            var xdir = sign(lengthdir_x(1, dir));
            var ydir = sign(lengthdir_y(1, dir));
            var xoffset = xdir;
            var yoffset = ydir;
            while(scr_space_valid(piece, xoffset, yoffset, grid))
            {
                moves[piece.gridx+xoffset, piece.gridy+yoffset] = 1;
                //You can move to an enemy space, but not through them
                if(scr_space_has_enemy(piece, xoffset, yoffset, grid))
                    break;
                
                xoffset += xdir;
                yoffset += ydir;
            }
        }
        break;
    case obj_pawn:
        if(scr_space_valid(piece, 0, color_sign, grid) && !scr_space_has_enemy(piece, 0, color_sign, grid))
            moves[piece.gridx, piece.gridy+color_sign] = 1;
        if(scr_space_has_enemy(piece, -1, color_sign, grid)) moves[piece.gridx-1, piece.gridy+color_sign] = 1;
        if(scr_space_has_enemy(piece, 1, color_sign, grid)) moves[piece.gridx+1, piece.gridy+color_sign] = 1;
        if(first_move)
        {
            if(scr_space_valid(piece, 0, color_sign*2, grid) && !scr_space_has_enemy(piece, 0, color_sign*2, grid)
                && scr_space_valid(piece, 0, color_sign, grid) && !scr_space_has_enemy(piece, 0, color_sign, grid))
                moves[piece.gridx, piece.gridy+color_sign*2] = 1;
        }
        //En passant capture
        if(scr_space_has_enemy(piece, -1, 0, grid))
        {
            enemy = grid[# piece.gridx-1, piece.gridy];
            if(enemy.object_index == obj_pawn && enemy.moved_two
                && scr_space_valid(piece, -1, color_sign, grid))
                moves[piece.gridx-1, piece.gridy+color_sign] = 1;
        }
        if(scr_space_has_enemy(piece, 1, 0, grid))
        {
            enemy = grid[# piece.gridx+1, piece.gridy]
            if(enemy.object_index == obj_pawn && enemy.moved_two
                && scr_space_valid(piece, 1, color_sign, grid))
                moves[piece.gridx+1, piece.gridy+color_sign] = 1;
        }
        break;
}

return moves;
