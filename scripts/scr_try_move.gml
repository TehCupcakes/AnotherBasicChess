var piece = argument0;
var xx = argument1; //The x index on the grid we want to move to
var yy = argument2; //The y index on the grid we want to move to
var arr = argument3; //Array of this piece's valid moves

piece.selected = false;
piece.unselect = false;
depth = -10;

//If it wasn't even a space on the board or it was the space this
//unit started at, the move was invalid. Just cancel it.
if(xx < 0 || xx > 7 || yy < 0 || yy > 7 ||
    (xx == piece.gridx && yy == piece.gridy) ||
    arr[xx, yy] == 0)
{
    //Return the piece to its old position.
    scr_set_position(piece, piece.gridx, piece.gridy);
    return false;
}
else
{
    //If there's an enemy at that space, "capture" them.
    var enemy = global.board[# xx, yy];
    if(enemy != noone)
    {
        with(enemy)
        {
            instance_destroy();
        }
    }

    //Determine if the piece moved two spaces (for pawns)
    var en_passant_enable = (abs(abs(piece.gridy) - abs(yy)) == 2)
    
    //Set the piece's new position and change player turns
    scr_set_position(piece, xx, yy);
    if(piece.color == COLOR.gold)
        global.player_turn = COLOR.silver;
    else
        global.player_turn = COLOR.gold;
    
    //"End turn" event (applies to all pieces, not just moved piece)
    with(par_piece)
        event_user(0);
    
    //Execute the "piece end move" event
    with(piece)
    {
        event_user(1);
        //Only the pawn stores this variable
        if(object_index == obj_pawn)
            moved_two = en_passant_enable;
    }
    
    return true;
}
