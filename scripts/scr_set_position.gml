var piece = argument0;
var xindex = argument1;
var yindex = argument2;
//Remove the piece from its previous position
if(piece.gridx >= 0 && piece.gridy >= 0)
    global.board[# piece.gridx, piece.gridy] = noone;

//Move the actual piece object
piece.x = xindex * obj_board.board_size + obj_board.board_offset;
piece.y = yindex * obj_board.board_size + obj_board.board_offset;

//Check for en passant capture
if(piece.object_index == obj_pawn && global.board[# xindex, yindex] == noone
    && abs(piece.gridx - xindex) == 1 && abs(piece.gridy - yindex) == 1)
{
    with(global.board[# xindex, piece.gridy])
        instance_destroy();
    global.board[# xindex, piece.gridy] = noone;
}

//Update the object's co-ordinates on the grid
piece.gridx = xindex;
piece.gridy = yindex;

//Add the piece as a reference at its new position
global.board[# xindex, yindex] = piece;
