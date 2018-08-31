var check_possible, white_occupied, black_occupied, moves;

//If both are down to one piece, they must be kings, thus it is a stalemate
//It is also a stalemate if there is only a knight and the two kings
if(instance_number(par_piece) == 2
    || (instance_number(par_piece) == 3 && instance_number(obj_knight) == 1))
{
    return true;
}

//As long as there is one piece besides the kings and bishop(s), it is possible
//to checkmate (excluding the one knight scenario we checked for above)
check_possible = false;
if(instance_number(obj_bishop)+instance_number(obj_king) != instance_number(par_piece))
    check_possible = true;
else
{
    //If both colors of the board have at least 1 bishop on them, it is still
    //possible to checkmate (even if they are on opposite teams, or the same team)
    white_occupied = false;
    black_occupied = false;
    with(obj_bishop)
    {
        if(gridx+gridy == 0 || (gridx+gridy) % 2 == 0)
            white_occupied = true;
        else
            black_occupied = true;
    }
    if(white_occupied && black_occupied)
        check_possible = true;
}
//If we know based on the remaining pieces that forcing checkmate is impossible,
//return true now because we know this must be a stalemate
if(!check_possible)
    return true;

//Check all pieces of the active player's color to see if they can move
with(par_piece)
{
    if(color == global.player_turn)
    {
        moves = scr_valid_moves(id, global.board);
        for(var xx = 0; xx <= 7; xx++)
        {
            for(var yy = 0; yy <= 7; yy++)
            {
                //We found a valid move! Not in stalemate
                if(moves[xx, yy] == 1)
                    return false;
            }
        }
    }
}

//They only way we reach here is if no valid moves were found from above
return true;
