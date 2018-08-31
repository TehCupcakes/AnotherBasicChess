var xindex = argument0;
var yindex = argument1;
var obj = argument2;
var color = argument3;
var new = instance_create(0, 0, obj);
new.color = color;
new.color_sign = -(color*2 - 1);
scr_set_position(new, xindex, yindex);

return new;
