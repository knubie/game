module(..., package.seeall)

--[[ TODO in the sprite sheet-- don't put space between sprite frames, only need to specify number of frames then
     TODO load all this data from a csv
     TODO dynamically load this data from  assets/classes/$class_name/$state_name.png ]]--

cammy = {
	-- name,            width, height, y,    x of each frame
	{  "idle",          78,    93,     482,  {70,160,248,334,421,503}},
	{  "walk_forward",  75,    104,    587,  {74,152,231,309,389,468,551,631,708,788}},
	{  "walk_backward", 79,    106,    715,  {92, 172, 257, 355, 452, 557, 662, 769, 874, 978}},
	{  "crouch",        78,    89,     840,  {96, 187, 270}},
	{  "neutral_jump",  65,    132,    962,  {92, 162, 236, 305, 379, 453, 524}},
	{  "forward_jump",  122,   113,    1182, {94,223,366,506,645,782}}, --912
	{  "backward_jump", 122,   113,    1182, {782,645,506,366,223,94}},
	{  "sjab",          119,   96,     1631, {109,230,109}},
	{  "light_hit",     85,    94,     3742, {98,11}}
} 