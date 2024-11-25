scoreboard players set @s rc 0

# get center point
execute store result score #x_max num run data get storage io player.painting.max_point.x 10000
execute store result score #y_max num run data get storage io player.painting.max_point.y 10000
execute store result score #z_max num run data get storage io player.painting.max_point.z 10000
execute store result score #x_min num run data get storage io player.painting.min_point.x 10000
execute store result score #y_min num run data get storage io player.painting.min_point.y 10000
execute store result score #z_min num run data get storage io player.painting.min_point.z 10000
execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0] double 0.00005 run scoreboard players operation #x_max num += #x_min num
execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[1] double 0.00005 run scoreboard players operation #y_max num += #y_min num
execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2] double 0.00005 run scoreboard players operation #z_max num += #z_min num
execute at 9e6925b-2-6224-0-f0d3ffc170ff facing 0. 0. 0. positioned 0. 0. 0. run tp 9e6925b-2-6224-0-f0d3ffc170ff ^ ^ ^1

execute store result score #xn num run data get entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0] 1000
execute store result score #yn num run data get entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[1] 1000
execute store result score #zn num run data get entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2] 1000

execute positioned 0. 0. 0. run tp 9e6925b-2-6224-0-f0d3ffc170ff ^1 ^ ^
execute store result score #xu num run data get entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0] 1000
execute store result score #zu num run data get entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2] 1000

execute positioned 0. 0. 0. run tp 9e6925b-2-6224-0-f0d3ffc170ff ^ ^-1 ^
execute store result score #xv num run data get entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0] 1000
execute store result score #yv num run data get entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[1] 1000
execute store result score #zv num run data get entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2] 1000

execute store result score loop num run data get storage io player.painting.points
function neu-n_4c61:paint/player/painting_end/loop

data modify storage io player.painting.points set value []
data modify storage io_neu player.painting.points set value []


#绘制和转换完成了，在这里开始准备把点转化为01布尔值矩阵

data modify storage large_number:math sort_int.input set from storage kaer_test1 temp_out_int_x
function neu-n_4c61:int_ascending_order/start
data modify storage kaer_test1 temp_sort_x set from storage large_number:math sort_int.output
execute store result score #temp_min_x int run data get storage kaer_test1 temp_sort_x[0]

data modify storage large_number:math sort_int.input set from storage kaer_test1 temp_out_int_y
function neu-n_4c61:int_ascending_order/start
data modify storage kaer_test1 temp_sort_y set from storage large_number:math sort_int.output
execute store result score #temp_min_y int run data get storage kaer_test1 temp_sort_y[0]

data modify storage kaer_test1 temp_relative_x set value []
data modify storage kaer_test1 temp_relative_y set value []
execute if data storage kaer_test1 temp_out_int_x[0] run function neu-n_4c61:paint/player/painting_end/math/loop3
execute if data storage kaer_test1 temp_out_int_y[0] run function neu-n_4c61:paint/player/painting_end/math/loop4

data modify storage large_number:math sort_int.input set value []
data modify storage large_number:math sort_int.input append from storage kaer_test1 temp_relative_x[]
data modify storage large_number:math sort_int.input append from storage kaer_test1 temp_relative_y[]
function neu-n_4c61:int_ascending_order/start

execute store result score #int_+decimal.input2 int run data get storage large_number:math sort_int.output[-1]
function neu-n_4c61:int_8decimal/start
data modify storage kaer_test1 temp_factor set from storage large_number:math int_more_decimal_out


data modify storage kaer_test1 temp_grid_xy set value []
execute if data storage kaer_test1 temp_relative_x[0] run function neu-n_4c61:paint/player/painting_end/math/loop1

#字符居中

data modify storage large_number:math sort_int.input set value []
data modify storage large_number:math sort_int.input append from storage kaer_test1 temp_grid_xy[].x
function neu-n_4c61:int_ascending_order/start
execute store result score #temp_min_x int run data get storage large_number:math sort_int.output[0]
execute store result score #temp_max_x int run data get storage large_number:math sort_int.output[-1]

data modify storage large_number:math sort_int.input set value []
data modify storage large_number:math sort_int.input append from storage kaer_test1 temp_grid_xy[].y
function neu-n_4c61:int_ascending_order/start
execute store result score #temp_min_y int run data get storage large_number:math sort_int.output[0]
execute store result score #temp_max_y int run data get storage large_number:math sort_int.output[-1]

scoreboard players operation #temp_max_x int -= #temp_min_x int
scoreboard players set #dx int 28
scoreboard players operation #dx int -= #temp_max_x int
scoreboard players operation #dx int /= 2 const

scoreboard players operation #temp_max_y int -= #temp_min_y int
scoreboard players set #dy int 28
scoreboard players operation #dy int -= #temp_max_y int
scoreboard players operation #dy int /= 2 const

data modify storage kaer_test1 temp1 set value []
execute if data storage kaer_test1 temp_grid_xy[0] run function neu-n_4c61:paint/player/painting_end/math/loop2
data modify storage kaer_test1 temp_grid_xy set from storage kaer_test1 temp1

#fill 0 0 -6 28 28 -6 air
#execute if data storage kaer_test1 temp1[0] run function neu-n_4c61:paint/player/painting_end/math/loop5

#转换为28*28的01布尔值矩阵
function neu-n_4c61:paint/player/painting_end/math/matrix
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:28}] run data modify storage kaer_test1 temp1[0] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:28}] run data modify storage kaer_test1 temp1[1] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:28}] run data modify storage kaer_test1 temp1[2] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:28}] run data modify storage kaer_test1 temp1[3] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:28}] run data modify storage kaer_test1 temp1[4] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:28}] run data modify storage kaer_test1 temp1[5] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:28}] run data modify storage kaer_test1 temp1[6] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:28}] run data modify storage kaer_test1 temp1[7] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:28}] run data modify storage kaer_test1 temp1[8] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:28}] run data modify storage kaer_test1 temp1[9] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:28}] run data modify storage kaer_test1 temp1[10] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:28}] run data modify storage kaer_test1 temp1[11] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:28}] run data modify storage kaer_test1 temp1[12] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:28}] run data modify storage kaer_test1 temp1[13] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:28}] run data modify storage kaer_test1 temp1[14] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:28}] run data modify storage kaer_test1 temp1[15] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:28}] run data modify storage kaer_test1 temp1[16] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:28}] run data modify storage kaer_test1 temp1[17] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:28}] run data modify storage kaer_test1 temp1[18] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:28}] run data modify storage kaer_test1 temp1[19] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:28}] run data modify storage kaer_test1 temp1[20] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:28}] run data modify storage kaer_test1 temp1[21] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:28}] run data modify storage kaer_test1 temp1[22] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:28}] run data modify storage kaer_test1 temp1[23] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:28}] run data modify storage kaer_test1 temp1[24] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:28}] run data modify storage kaer_test1 temp1[25] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:28}] run data modify storage kaer_test1 temp1[26] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:28}] run data modify storage kaer_test1 temp1[27] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:27}] run data modify storage kaer_test1 temp1[28] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:27}] run data modify storage kaer_test1 temp1[29] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:27}] run data modify storage kaer_test1 temp1[30] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:27}] run data modify storage kaer_test1 temp1[31] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:27}] run data modify storage kaer_test1 temp1[32] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:27}] run data modify storage kaer_test1 temp1[33] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:27}] run data modify storage kaer_test1 temp1[34] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:27}] run data modify storage kaer_test1 temp1[35] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:27}] run data modify storage kaer_test1 temp1[36] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:27}] run data modify storage kaer_test1 temp1[37] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:27}] run data modify storage kaer_test1 temp1[38] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:27}] run data modify storage kaer_test1 temp1[39] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:27}] run data modify storage kaer_test1 temp1[40] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:27}] run data modify storage kaer_test1 temp1[41] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:27}] run data modify storage kaer_test1 temp1[42] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:27}] run data modify storage kaer_test1 temp1[43] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:27}] run data modify storage kaer_test1 temp1[44] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:27}] run data modify storage kaer_test1 temp1[45] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:27}] run data modify storage kaer_test1 temp1[46] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:27}] run data modify storage kaer_test1 temp1[47] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:27}] run data modify storage kaer_test1 temp1[48] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:27}] run data modify storage kaer_test1 temp1[49] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:27}] run data modify storage kaer_test1 temp1[50] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:27}] run data modify storage kaer_test1 temp1[51] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:27}] run data modify storage kaer_test1 temp1[52] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:27}] run data modify storage kaer_test1 temp1[53] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:27}] run data modify storage kaer_test1 temp1[54] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:27}] run data modify storage kaer_test1 temp1[55] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:26}] run data modify storage kaer_test1 temp1[56] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:26}] run data modify storage kaer_test1 temp1[57] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:26}] run data modify storage kaer_test1 temp1[58] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:26}] run data modify storage kaer_test1 temp1[59] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:26}] run data modify storage kaer_test1 temp1[60] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:26}] run data modify storage kaer_test1 temp1[61] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:26}] run data modify storage kaer_test1 temp1[62] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:26}] run data modify storage kaer_test1 temp1[63] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:26}] run data modify storage kaer_test1 temp1[64] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:26}] run data modify storage kaer_test1 temp1[65] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:26}] run data modify storage kaer_test1 temp1[66] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:26}] run data modify storage kaer_test1 temp1[67] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:26}] run data modify storage kaer_test1 temp1[68] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:26}] run data modify storage kaer_test1 temp1[69] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:26}] run data modify storage kaer_test1 temp1[70] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:26}] run data modify storage kaer_test1 temp1[71] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:26}] run data modify storage kaer_test1 temp1[72] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:26}] run data modify storage kaer_test1 temp1[73] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:26}] run data modify storage kaer_test1 temp1[74] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:26}] run data modify storage kaer_test1 temp1[75] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:26}] run data modify storage kaer_test1 temp1[76] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:26}] run data modify storage kaer_test1 temp1[77] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:26}] run data modify storage kaer_test1 temp1[78] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:26}] run data modify storage kaer_test1 temp1[79] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:26}] run data modify storage kaer_test1 temp1[80] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:26}] run data modify storage kaer_test1 temp1[81] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:26}] run data modify storage kaer_test1 temp1[82] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:26}] run data modify storage kaer_test1 temp1[83] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:25}] run data modify storage kaer_test1 temp1[84] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:25}] run data modify storage kaer_test1 temp1[85] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:25}] run data modify storage kaer_test1 temp1[86] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:25}] run data modify storage kaer_test1 temp1[87] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:25}] run data modify storage kaer_test1 temp1[88] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:25}] run data modify storage kaer_test1 temp1[89] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:25}] run data modify storage kaer_test1 temp1[90] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:25}] run data modify storage kaer_test1 temp1[91] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:25}] run data modify storage kaer_test1 temp1[92] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:25}] run data modify storage kaer_test1 temp1[93] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:25}] run data modify storage kaer_test1 temp1[94] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:25}] run data modify storage kaer_test1 temp1[95] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:25}] run data modify storage kaer_test1 temp1[96] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:25}] run data modify storage kaer_test1 temp1[97] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:25}] run data modify storage kaer_test1 temp1[98] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:25}] run data modify storage kaer_test1 temp1[99] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:25}] run data modify storage kaer_test1 temp1[100] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:25}] run data modify storage kaer_test1 temp1[101] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:25}] run data modify storage kaer_test1 temp1[102] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:25}] run data modify storage kaer_test1 temp1[103] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:25}] run data modify storage kaer_test1 temp1[104] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:25}] run data modify storage kaer_test1 temp1[105] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:25}] run data modify storage kaer_test1 temp1[106] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:25}] run data modify storage kaer_test1 temp1[107] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:25}] run data modify storage kaer_test1 temp1[108] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:25}] run data modify storage kaer_test1 temp1[109] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:25}] run data modify storage kaer_test1 temp1[110] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:25}] run data modify storage kaer_test1 temp1[111] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:24}] run data modify storage kaer_test1 temp1[112] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:24}] run data modify storage kaer_test1 temp1[113] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:24}] run data modify storage kaer_test1 temp1[114] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:24}] run data modify storage kaer_test1 temp1[115] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:24}] run data modify storage kaer_test1 temp1[116] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:24}] run data modify storage kaer_test1 temp1[117] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:24}] run data modify storage kaer_test1 temp1[118] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:24}] run data modify storage kaer_test1 temp1[119] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:24}] run data modify storage kaer_test1 temp1[120] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:24}] run data modify storage kaer_test1 temp1[121] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:24}] run data modify storage kaer_test1 temp1[122] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:24}] run data modify storage kaer_test1 temp1[123] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:24}] run data modify storage kaer_test1 temp1[124] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:24}] run data modify storage kaer_test1 temp1[125] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:24}] run data modify storage kaer_test1 temp1[126] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:24}] run data modify storage kaer_test1 temp1[127] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:24}] run data modify storage kaer_test1 temp1[128] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:24}] run data modify storage kaer_test1 temp1[129] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:24}] run data modify storage kaer_test1 temp1[130] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:24}] run data modify storage kaer_test1 temp1[131] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:24}] run data modify storage kaer_test1 temp1[132] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:24}] run data modify storage kaer_test1 temp1[133] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:24}] run data modify storage kaer_test1 temp1[134] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:24}] run data modify storage kaer_test1 temp1[135] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:24}] run data modify storage kaer_test1 temp1[136] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:24}] run data modify storage kaer_test1 temp1[137] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:24}] run data modify storage kaer_test1 temp1[138] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:24}] run data modify storage kaer_test1 temp1[139] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:23}] run data modify storage kaer_test1 temp1[140] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:23}] run data modify storage kaer_test1 temp1[141] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:23}] run data modify storage kaer_test1 temp1[142] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:23}] run data modify storage kaer_test1 temp1[143] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:23}] run data modify storage kaer_test1 temp1[144] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:23}] run data modify storage kaer_test1 temp1[145] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:23}] run data modify storage kaer_test1 temp1[146] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:23}] run data modify storage kaer_test1 temp1[147] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:23}] run data modify storage kaer_test1 temp1[148] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:23}] run data modify storage kaer_test1 temp1[149] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:23}] run data modify storage kaer_test1 temp1[150] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:23}] run data modify storage kaer_test1 temp1[151] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:23}] run data modify storage kaer_test1 temp1[152] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:23}] run data modify storage kaer_test1 temp1[153] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:23}] run data modify storage kaer_test1 temp1[154] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:23}] run data modify storage kaer_test1 temp1[155] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:23}] run data modify storage kaer_test1 temp1[156] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:23}] run data modify storage kaer_test1 temp1[157] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:23}] run data modify storage kaer_test1 temp1[158] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:23}] run data modify storage kaer_test1 temp1[159] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:23}] run data modify storage kaer_test1 temp1[160] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:23}] run data modify storage kaer_test1 temp1[161] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:23}] run data modify storage kaer_test1 temp1[162] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:23}] run data modify storage kaer_test1 temp1[163] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:23}] run data modify storage kaer_test1 temp1[164] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:23}] run data modify storage kaer_test1 temp1[165] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:23}] run data modify storage kaer_test1 temp1[166] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:23}] run data modify storage kaer_test1 temp1[167] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:22}] run data modify storage kaer_test1 temp1[168] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:22}] run data modify storage kaer_test1 temp1[169] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:22}] run data modify storage kaer_test1 temp1[170] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:22}] run data modify storage kaer_test1 temp1[171] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:22}] run data modify storage kaer_test1 temp1[172] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:22}] run data modify storage kaer_test1 temp1[173] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:22}] run data modify storage kaer_test1 temp1[174] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:22}] run data modify storage kaer_test1 temp1[175] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:22}] run data modify storage kaer_test1 temp1[176] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:22}] run data modify storage kaer_test1 temp1[177] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:22}] run data modify storage kaer_test1 temp1[178] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:22}] run data modify storage kaer_test1 temp1[179] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:22}] run data modify storage kaer_test1 temp1[180] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:22}] run data modify storage kaer_test1 temp1[181] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:22}] run data modify storage kaer_test1 temp1[182] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:22}] run data modify storage kaer_test1 temp1[183] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:22}] run data modify storage kaer_test1 temp1[184] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:22}] run data modify storage kaer_test1 temp1[185] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:22}] run data modify storage kaer_test1 temp1[186] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:22}] run data modify storage kaer_test1 temp1[187] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:22}] run data modify storage kaer_test1 temp1[188] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:22}] run data modify storage kaer_test1 temp1[189] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:22}] run data modify storage kaer_test1 temp1[190] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:22}] run data modify storage kaer_test1 temp1[191] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:22}] run data modify storage kaer_test1 temp1[192] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:22}] run data modify storage kaer_test1 temp1[193] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:22}] run data modify storage kaer_test1 temp1[194] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:22}] run data modify storage kaer_test1 temp1[195] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:21}] run data modify storage kaer_test1 temp1[196] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:21}] run data modify storage kaer_test1 temp1[197] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:21}] run data modify storage kaer_test1 temp1[198] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:21}] run data modify storage kaer_test1 temp1[199] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:21}] run data modify storage kaer_test1 temp1[200] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:21}] run data modify storage kaer_test1 temp1[201] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:21}] run data modify storage kaer_test1 temp1[202] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:21}] run data modify storage kaer_test1 temp1[203] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:21}] run data modify storage kaer_test1 temp1[204] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:21}] run data modify storage kaer_test1 temp1[205] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:21}] run data modify storage kaer_test1 temp1[206] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:21}] run data modify storage kaer_test1 temp1[207] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:21}] run data modify storage kaer_test1 temp1[208] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:21}] run data modify storage kaer_test1 temp1[209] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:21}] run data modify storage kaer_test1 temp1[210] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:21}] run data modify storage kaer_test1 temp1[211] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:21}] run data modify storage kaer_test1 temp1[212] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:21}] run data modify storage kaer_test1 temp1[213] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:21}] run data modify storage kaer_test1 temp1[214] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:21}] run data modify storage kaer_test1 temp1[215] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:21}] run data modify storage kaer_test1 temp1[216] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:21}] run data modify storage kaer_test1 temp1[217] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:21}] run data modify storage kaer_test1 temp1[218] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:21}] run data modify storage kaer_test1 temp1[219] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:21}] run data modify storage kaer_test1 temp1[220] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:21}] run data modify storage kaer_test1 temp1[221] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:21}] run data modify storage kaer_test1 temp1[222] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:21}] run data modify storage kaer_test1 temp1[223] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:20}] run data modify storage kaer_test1 temp1[224] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:20}] run data modify storage kaer_test1 temp1[225] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:20}] run data modify storage kaer_test1 temp1[226] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:20}] run data modify storage kaer_test1 temp1[227] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:20}] run data modify storage kaer_test1 temp1[228] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:20}] run data modify storage kaer_test1 temp1[229] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:20}] run data modify storage kaer_test1 temp1[230] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:20}] run data modify storage kaer_test1 temp1[231] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:20}] run data modify storage kaer_test1 temp1[232] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:20}] run data modify storage kaer_test1 temp1[233] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:20}] run data modify storage kaer_test1 temp1[234] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:20}] run data modify storage kaer_test1 temp1[235] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:20}] run data modify storage kaer_test1 temp1[236] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:20}] run data modify storage kaer_test1 temp1[237] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:20}] run data modify storage kaer_test1 temp1[238] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:20}] run data modify storage kaer_test1 temp1[239] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:20}] run data modify storage kaer_test1 temp1[240] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:20}] run data modify storage kaer_test1 temp1[241] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:20}] run data modify storage kaer_test1 temp1[242] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:20}] run data modify storage kaer_test1 temp1[243] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:20}] run data modify storage kaer_test1 temp1[244] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:20}] run data modify storage kaer_test1 temp1[245] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:20}] run data modify storage kaer_test1 temp1[246] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:20}] run data modify storage kaer_test1 temp1[247] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:20}] run data modify storage kaer_test1 temp1[248] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:20}] run data modify storage kaer_test1 temp1[249] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:20}] run data modify storage kaer_test1 temp1[250] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:20}] run data modify storage kaer_test1 temp1[251] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:19}] run data modify storage kaer_test1 temp1[252] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:19}] run data modify storage kaer_test1 temp1[253] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:19}] run data modify storage kaer_test1 temp1[254] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:19}] run data modify storage kaer_test1 temp1[255] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:19}] run data modify storage kaer_test1 temp1[256] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:19}] run data modify storage kaer_test1 temp1[257] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:19}] run data modify storage kaer_test1 temp1[258] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:19}] run data modify storage kaer_test1 temp1[259] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:19}] run data modify storage kaer_test1 temp1[260] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:19}] run data modify storage kaer_test1 temp1[261] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:19}] run data modify storage kaer_test1 temp1[262] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:19}] run data modify storage kaer_test1 temp1[263] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:19}] run data modify storage kaer_test1 temp1[264] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:19}] run data modify storage kaer_test1 temp1[265] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:19}] run data modify storage kaer_test1 temp1[266] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:19}] run data modify storage kaer_test1 temp1[267] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:19}] run data modify storage kaer_test1 temp1[268] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:19}] run data modify storage kaer_test1 temp1[269] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:19}] run data modify storage kaer_test1 temp1[270] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:19}] run data modify storage kaer_test1 temp1[271] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:19}] run data modify storage kaer_test1 temp1[272] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:19}] run data modify storage kaer_test1 temp1[273] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:19}] run data modify storage kaer_test1 temp1[274] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:19}] run data modify storage kaer_test1 temp1[275] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:19}] run data modify storage kaer_test1 temp1[276] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:19}] run data modify storage kaer_test1 temp1[277] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:19}] run data modify storage kaer_test1 temp1[278] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:19}] run data modify storage kaer_test1 temp1[279] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:18}] run data modify storage kaer_test1 temp1[280] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:18}] run data modify storage kaer_test1 temp1[281] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:18}] run data modify storage kaer_test1 temp1[282] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:18}] run data modify storage kaer_test1 temp1[283] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:18}] run data modify storage kaer_test1 temp1[284] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:18}] run data modify storage kaer_test1 temp1[285] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:18}] run data modify storage kaer_test1 temp1[286] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:18}] run data modify storage kaer_test1 temp1[287] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:18}] run data modify storage kaer_test1 temp1[288] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:18}] run data modify storage kaer_test1 temp1[289] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:18}] run data modify storage kaer_test1 temp1[290] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:18}] run data modify storage kaer_test1 temp1[291] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:18}] run data modify storage kaer_test1 temp1[292] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:18}] run data modify storage kaer_test1 temp1[293] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:18}] run data modify storage kaer_test1 temp1[294] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:18}] run data modify storage kaer_test1 temp1[295] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:18}] run data modify storage kaer_test1 temp1[296] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:18}] run data modify storage kaer_test1 temp1[297] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:18}] run data modify storage kaer_test1 temp1[298] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:18}] run data modify storage kaer_test1 temp1[299] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:18}] run data modify storage kaer_test1 temp1[300] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:18}] run data modify storage kaer_test1 temp1[301] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:18}] run data modify storage kaer_test1 temp1[302] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:18}] run data modify storage kaer_test1 temp1[303] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:18}] run data modify storage kaer_test1 temp1[304] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:18}] run data modify storage kaer_test1 temp1[305] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:18}] run data modify storage kaer_test1 temp1[306] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:18}] run data modify storage kaer_test1 temp1[307] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:17}] run data modify storage kaer_test1 temp1[308] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:17}] run data modify storage kaer_test1 temp1[309] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:17}] run data modify storage kaer_test1 temp1[310] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:17}] run data modify storage kaer_test1 temp1[311] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:17}] run data modify storage kaer_test1 temp1[312] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:17}] run data modify storage kaer_test1 temp1[313] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:17}] run data modify storage kaer_test1 temp1[314] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:17}] run data modify storage kaer_test1 temp1[315] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:17}] run data modify storage kaer_test1 temp1[316] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:17}] run data modify storage kaer_test1 temp1[317] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:17}] run data modify storage kaer_test1 temp1[318] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:17}] run data modify storage kaer_test1 temp1[319] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:17}] run data modify storage kaer_test1 temp1[320] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:17}] run data modify storage kaer_test1 temp1[321] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:17}] run data modify storage kaer_test1 temp1[322] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:17}] run data modify storage kaer_test1 temp1[323] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:17}] run data modify storage kaer_test1 temp1[324] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:17}] run data modify storage kaer_test1 temp1[325] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:17}] run data modify storage kaer_test1 temp1[326] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:17}] run data modify storage kaer_test1 temp1[327] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:17}] run data modify storage kaer_test1 temp1[328] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:17}] run data modify storage kaer_test1 temp1[329] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:17}] run data modify storage kaer_test1 temp1[330] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:17}] run data modify storage kaer_test1 temp1[331] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:17}] run data modify storage kaer_test1 temp1[332] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:17}] run data modify storage kaer_test1 temp1[333] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:17}] run data modify storage kaer_test1 temp1[334] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:17}] run data modify storage kaer_test1 temp1[335] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:16}] run data modify storage kaer_test1 temp1[336] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:16}] run data modify storage kaer_test1 temp1[337] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:16}] run data modify storage kaer_test1 temp1[338] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:16}] run data modify storage kaer_test1 temp1[339] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:16}] run data modify storage kaer_test1 temp1[340] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:16}] run data modify storage kaer_test1 temp1[341] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:16}] run data modify storage kaer_test1 temp1[342] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:16}] run data modify storage kaer_test1 temp1[343] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:16}] run data modify storage kaer_test1 temp1[344] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:16}] run data modify storage kaer_test1 temp1[345] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:16}] run data modify storage kaer_test1 temp1[346] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:16}] run data modify storage kaer_test1 temp1[347] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:16}] run data modify storage kaer_test1 temp1[348] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:16}] run data modify storage kaer_test1 temp1[349] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:16}] run data modify storage kaer_test1 temp1[350] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:16}] run data modify storage kaer_test1 temp1[351] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:16}] run data modify storage kaer_test1 temp1[352] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:16}] run data modify storage kaer_test1 temp1[353] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:16}] run data modify storage kaer_test1 temp1[354] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:16}] run data modify storage kaer_test1 temp1[355] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:16}] run data modify storage kaer_test1 temp1[356] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:16}] run data modify storage kaer_test1 temp1[357] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:16}] run data modify storage kaer_test1 temp1[358] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:16}] run data modify storage kaer_test1 temp1[359] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:16}] run data modify storage kaer_test1 temp1[360] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:16}] run data modify storage kaer_test1 temp1[361] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:16}] run data modify storage kaer_test1 temp1[362] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:16}] run data modify storage kaer_test1 temp1[363] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:15}] run data modify storage kaer_test1 temp1[364] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:15}] run data modify storage kaer_test1 temp1[365] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:15}] run data modify storage kaer_test1 temp1[366] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:15}] run data modify storage kaer_test1 temp1[367] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:15}] run data modify storage kaer_test1 temp1[368] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:15}] run data modify storage kaer_test1 temp1[369] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:15}] run data modify storage kaer_test1 temp1[370] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:15}] run data modify storage kaer_test1 temp1[371] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:15}] run data modify storage kaer_test1 temp1[372] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:15}] run data modify storage kaer_test1 temp1[373] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:15}] run data modify storage kaer_test1 temp1[374] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:15}] run data modify storage kaer_test1 temp1[375] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:15}] run data modify storage kaer_test1 temp1[376] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:15}] run data modify storage kaer_test1 temp1[377] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:15}] run data modify storage kaer_test1 temp1[378] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:15}] run data modify storage kaer_test1 temp1[379] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:15}] run data modify storage kaer_test1 temp1[380] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:15}] run data modify storage kaer_test1 temp1[381] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:15}] run data modify storage kaer_test1 temp1[382] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:15}] run data modify storage kaer_test1 temp1[383] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:15}] run data modify storage kaer_test1 temp1[384] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:15}] run data modify storage kaer_test1 temp1[385] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:15}] run data modify storage kaer_test1 temp1[386] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:15}] run data modify storage kaer_test1 temp1[387] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:15}] run data modify storage kaer_test1 temp1[388] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:15}] run data modify storage kaer_test1 temp1[389] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:15}] run data modify storage kaer_test1 temp1[390] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:15}] run data modify storage kaer_test1 temp1[391] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:14}] run data modify storage kaer_test1 temp1[392] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:14}] run data modify storage kaer_test1 temp1[393] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:14}] run data modify storage kaer_test1 temp1[394] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:14}] run data modify storage kaer_test1 temp1[395] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:14}] run data modify storage kaer_test1 temp1[396] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:14}] run data modify storage kaer_test1 temp1[397] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:14}] run data modify storage kaer_test1 temp1[398] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:14}] run data modify storage kaer_test1 temp1[399] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:14}] run data modify storage kaer_test1 temp1[400] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:14}] run data modify storage kaer_test1 temp1[401] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:14}] run data modify storage kaer_test1 temp1[402] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:14}] run data modify storage kaer_test1 temp1[403] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:14}] run data modify storage kaer_test1 temp1[404] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:14}] run data modify storage kaer_test1 temp1[405] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:14}] run data modify storage kaer_test1 temp1[406] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:14}] run data modify storage kaer_test1 temp1[407] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:14}] run data modify storage kaer_test1 temp1[408] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:14}] run data modify storage kaer_test1 temp1[409] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:14}] run data modify storage kaer_test1 temp1[410] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:14}] run data modify storage kaer_test1 temp1[411] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:14}] run data modify storage kaer_test1 temp1[412] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:14}] run data modify storage kaer_test1 temp1[413] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:14}] run data modify storage kaer_test1 temp1[414] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:14}] run data modify storage kaer_test1 temp1[415] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:14}] run data modify storage kaer_test1 temp1[416] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:14}] run data modify storage kaer_test1 temp1[417] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:14}] run data modify storage kaer_test1 temp1[418] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:14}] run data modify storage kaer_test1 temp1[419] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:13}] run data modify storage kaer_test1 temp1[420] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:13}] run data modify storage kaer_test1 temp1[421] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:13}] run data modify storage kaer_test1 temp1[422] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:13}] run data modify storage kaer_test1 temp1[423] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:13}] run data modify storage kaer_test1 temp1[424] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:13}] run data modify storage kaer_test1 temp1[425] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:13}] run data modify storage kaer_test1 temp1[426] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:13}] run data modify storage kaer_test1 temp1[427] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:13}] run data modify storage kaer_test1 temp1[428] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:13}] run data modify storage kaer_test1 temp1[429] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:13}] run data modify storage kaer_test1 temp1[430] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:13}] run data modify storage kaer_test1 temp1[431] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:13}] run data modify storage kaer_test1 temp1[432] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:13}] run data modify storage kaer_test1 temp1[433] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:13}] run data modify storage kaer_test1 temp1[434] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:13}] run data modify storage kaer_test1 temp1[435] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:13}] run data modify storage kaer_test1 temp1[436] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:13}] run data modify storage kaer_test1 temp1[437] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:13}] run data modify storage kaer_test1 temp1[438] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:13}] run data modify storage kaer_test1 temp1[439] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:13}] run data modify storage kaer_test1 temp1[440] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:13}] run data modify storage kaer_test1 temp1[441] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:13}] run data modify storage kaer_test1 temp1[442] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:13}] run data modify storage kaer_test1 temp1[443] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:13}] run data modify storage kaer_test1 temp1[444] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:13}] run data modify storage kaer_test1 temp1[445] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:13}] run data modify storage kaer_test1 temp1[446] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:13}] run data modify storage kaer_test1 temp1[447] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:12}] run data modify storage kaer_test1 temp1[448] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:12}] run data modify storage kaer_test1 temp1[449] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:12}] run data modify storage kaer_test1 temp1[450] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:12}] run data modify storage kaer_test1 temp1[451] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:12}] run data modify storage kaer_test1 temp1[452] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:12}] run data modify storage kaer_test1 temp1[453] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:12}] run data modify storage kaer_test1 temp1[454] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:12}] run data modify storage kaer_test1 temp1[455] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:12}] run data modify storage kaer_test1 temp1[456] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:12}] run data modify storage kaer_test1 temp1[457] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:12}] run data modify storage kaer_test1 temp1[458] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:12}] run data modify storage kaer_test1 temp1[459] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:12}] run data modify storage kaer_test1 temp1[460] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:12}] run data modify storage kaer_test1 temp1[461] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:12}] run data modify storage kaer_test1 temp1[462] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:12}] run data modify storage kaer_test1 temp1[463] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:12}] run data modify storage kaer_test1 temp1[464] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:12}] run data modify storage kaer_test1 temp1[465] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:12}] run data modify storage kaer_test1 temp1[466] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:12}] run data modify storage kaer_test1 temp1[467] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:12}] run data modify storage kaer_test1 temp1[468] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:12}] run data modify storage kaer_test1 temp1[469] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:12}] run data modify storage kaer_test1 temp1[470] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:12}] run data modify storage kaer_test1 temp1[471] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:12}] run data modify storage kaer_test1 temp1[472] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:12}] run data modify storage kaer_test1 temp1[473] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:12}] run data modify storage kaer_test1 temp1[474] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:12}] run data modify storage kaer_test1 temp1[475] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:11}] run data modify storage kaer_test1 temp1[476] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:11}] run data modify storage kaer_test1 temp1[477] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:11}] run data modify storage kaer_test1 temp1[478] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:11}] run data modify storage kaer_test1 temp1[479] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:11}] run data modify storage kaer_test1 temp1[480] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:11}] run data modify storage kaer_test1 temp1[481] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:11}] run data modify storage kaer_test1 temp1[482] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:11}] run data modify storage kaer_test1 temp1[483] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:11}] run data modify storage kaer_test1 temp1[484] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:11}] run data modify storage kaer_test1 temp1[485] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:11}] run data modify storage kaer_test1 temp1[486] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:11}] run data modify storage kaer_test1 temp1[487] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:11}] run data modify storage kaer_test1 temp1[488] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:11}] run data modify storage kaer_test1 temp1[489] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:11}] run data modify storage kaer_test1 temp1[490] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:11}] run data modify storage kaer_test1 temp1[491] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:11}] run data modify storage kaer_test1 temp1[492] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:11}] run data modify storage kaer_test1 temp1[493] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:11}] run data modify storage kaer_test1 temp1[494] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:11}] run data modify storage kaer_test1 temp1[495] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:11}] run data modify storage kaer_test1 temp1[496] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:11}] run data modify storage kaer_test1 temp1[497] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:11}] run data modify storage kaer_test1 temp1[498] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:11}] run data modify storage kaer_test1 temp1[499] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:11}] run data modify storage kaer_test1 temp1[500] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:11}] run data modify storage kaer_test1 temp1[501] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:11}] run data modify storage kaer_test1 temp1[502] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:11}] run data modify storage kaer_test1 temp1[503] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:10}] run data modify storage kaer_test1 temp1[504] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:10}] run data modify storage kaer_test1 temp1[505] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:10}] run data modify storage kaer_test1 temp1[506] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:10}] run data modify storage kaer_test1 temp1[507] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:10}] run data modify storage kaer_test1 temp1[508] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:10}] run data modify storage kaer_test1 temp1[509] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:10}] run data modify storage kaer_test1 temp1[510] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:10}] run data modify storage kaer_test1 temp1[511] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:10}] run data modify storage kaer_test1 temp1[512] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:10}] run data modify storage kaer_test1 temp1[513] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:10}] run data modify storage kaer_test1 temp1[514] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:10}] run data modify storage kaer_test1 temp1[515] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:10}] run data modify storage kaer_test1 temp1[516] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:10}] run data modify storage kaer_test1 temp1[517] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:10}] run data modify storage kaer_test1 temp1[518] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:10}] run data modify storage kaer_test1 temp1[519] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:10}] run data modify storage kaer_test1 temp1[520] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:10}] run data modify storage kaer_test1 temp1[521] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:10}] run data modify storage kaer_test1 temp1[522] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:10}] run data modify storage kaer_test1 temp1[523] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:10}] run data modify storage kaer_test1 temp1[524] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:10}] run data modify storage kaer_test1 temp1[525] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:10}] run data modify storage kaer_test1 temp1[526] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:10}] run data modify storage kaer_test1 temp1[527] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:10}] run data modify storage kaer_test1 temp1[528] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:10}] run data modify storage kaer_test1 temp1[529] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:10}] run data modify storage kaer_test1 temp1[530] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:10}] run data modify storage kaer_test1 temp1[531] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:9}] run data modify storage kaer_test1 temp1[532] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:9}] run data modify storage kaer_test1 temp1[533] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:9}] run data modify storage kaer_test1 temp1[534] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:9}] run data modify storage kaer_test1 temp1[535] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:9}] run data modify storage kaer_test1 temp1[536] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:9}] run data modify storage kaer_test1 temp1[537] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:9}] run data modify storage kaer_test1 temp1[538] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:9}] run data modify storage kaer_test1 temp1[539] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:9}] run data modify storage kaer_test1 temp1[540] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:9}] run data modify storage kaer_test1 temp1[541] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:9}] run data modify storage kaer_test1 temp1[542] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:9}] run data modify storage kaer_test1 temp1[543] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:9}] run data modify storage kaer_test1 temp1[544] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:9}] run data modify storage kaer_test1 temp1[545] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:9}] run data modify storage kaer_test1 temp1[546] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:9}] run data modify storage kaer_test1 temp1[547] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:9}] run data modify storage kaer_test1 temp1[548] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:9}] run data modify storage kaer_test1 temp1[549] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:9}] run data modify storage kaer_test1 temp1[550] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:9}] run data modify storage kaer_test1 temp1[551] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:9}] run data modify storage kaer_test1 temp1[552] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:9}] run data modify storage kaer_test1 temp1[553] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:9}] run data modify storage kaer_test1 temp1[554] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:9}] run data modify storage kaer_test1 temp1[555] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:9}] run data modify storage kaer_test1 temp1[556] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:9}] run data modify storage kaer_test1 temp1[557] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:9}] run data modify storage kaer_test1 temp1[558] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:9}] run data modify storage kaer_test1 temp1[559] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:8}] run data modify storage kaer_test1 temp1[560] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:8}] run data modify storage kaer_test1 temp1[561] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:8}] run data modify storage kaer_test1 temp1[562] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:8}] run data modify storage kaer_test1 temp1[563] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:8}] run data modify storage kaer_test1 temp1[564] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:8}] run data modify storage kaer_test1 temp1[565] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:8}] run data modify storage kaer_test1 temp1[566] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:8}] run data modify storage kaer_test1 temp1[567] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:8}] run data modify storage kaer_test1 temp1[568] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:8}] run data modify storage kaer_test1 temp1[569] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:8}] run data modify storage kaer_test1 temp1[570] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:8}] run data modify storage kaer_test1 temp1[571] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:8}] run data modify storage kaer_test1 temp1[572] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:8}] run data modify storage kaer_test1 temp1[573] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:8}] run data modify storage kaer_test1 temp1[574] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:8}] run data modify storage kaer_test1 temp1[575] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:8}] run data modify storage kaer_test1 temp1[576] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:8}] run data modify storage kaer_test1 temp1[577] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:8}] run data modify storage kaer_test1 temp1[578] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:8}] run data modify storage kaer_test1 temp1[579] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:8}] run data modify storage kaer_test1 temp1[580] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:8}] run data modify storage kaer_test1 temp1[581] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:8}] run data modify storage kaer_test1 temp1[582] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:8}] run data modify storage kaer_test1 temp1[583] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:8}] run data modify storage kaer_test1 temp1[584] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:8}] run data modify storage kaer_test1 temp1[585] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:8}] run data modify storage kaer_test1 temp1[586] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:8}] run data modify storage kaer_test1 temp1[587] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:7}] run data modify storage kaer_test1 temp1[588] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:7}] run data modify storage kaer_test1 temp1[589] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:7}] run data modify storage kaer_test1 temp1[590] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:7}] run data modify storage kaer_test1 temp1[591] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:7}] run data modify storage kaer_test1 temp1[592] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:7}] run data modify storage kaer_test1 temp1[593] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:7}] run data modify storage kaer_test1 temp1[594] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:7}] run data modify storage kaer_test1 temp1[595] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:7}] run data modify storage kaer_test1 temp1[596] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:7}] run data modify storage kaer_test1 temp1[597] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:7}] run data modify storage kaer_test1 temp1[598] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:7}] run data modify storage kaer_test1 temp1[599] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:7}] run data modify storage kaer_test1 temp1[600] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:7}] run data modify storage kaer_test1 temp1[601] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:7}] run data modify storage kaer_test1 temp1[602] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:7}] run data modify storage kaer_test1 temp1[603] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:7}] run data modify storage kaer_test1 temp1[604] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:7}] run data modify storage kaer_test1 temp1[605] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:7}] run data modify storage kaer_test1 temp1[606] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:7}] run data modify storage kaer_test1 temp1[607] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:7}] run data modify storage kaer_test1 temp1[608] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:7}] run data modify storage kaer_test1 temp1[609] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:7}] run data modify storage kaer_test1 temp1[610] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:7}] run data modify storage kaer_test1 temp1[611] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:7}] run data modify storage kaer_test1 temp1[612] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:7}] run data modify storage kaer_test1 temp1[613] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:7}] run data modify storage kaer_test1 temp1[614] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:7}] run data modify storage kaer_test1 temp1[615] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:6}] run data modify storage kaer_test1 temp1[616] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:6}] run data modify storage kaer_test1 temp1[617] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:6}] run data modify storage kaer_test1 temp1[618] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:6}] run data modify storage kaer_test1 temp1[619] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:6}] run data modify storage kaer_test1 temp1[620] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:6}] run data modify storage kaer_test1 temp1[621] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:6}] run data modify storage kaer_test1 temp1[622] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:6}] run data modify storage kaer_test1 temp1[623] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:6}] run data modify storage kaer_test1 temp1[624] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:6}] run data modify storage kaer_test1 temp1[625] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:6}] run data modify storage kaer_test1 temp1[626] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:6}] run data modify storage kaer_test1 temp1[627] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:6}] run data modify storage kaer_test1 temp1[628] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:6}] run data modify storage kaer_test1 temp1[629] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:6}] run data modify storage kaer_test1 temp1[630] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:6}] run data modify storage kaer_test1 temp1[631] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:6}] run data modify storage kaer_test1 temp1[632] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:6}] run data modify storage kaer_test1 temp1[633] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:6}] run data modify storage kaer_test1 temp1[634] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:6}] run data modify storage kaer_test1 temp1[635] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:6}] run data modify storage kaer_test1 temp1[636] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:6}] run data modify storage kaer_test1 temp1[637] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:6}] run data modify storage kaer_test1 temp1[638] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:6}] run data modify storage kaer_test1 temp1[639] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:6}] run data modify storage kaer_test1 temp1[640] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:6}] run data modify storage kaer_test1 temp1[641] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:6}] run data modify storage kaer_test1 temp1[642] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:6}] run data modify storage kaer_test1 temp1[643] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:5}] run data modify storage kaer_test1 temp1[644] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:5}] run data modify storage kaer_test1 temp1[645] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:5}] run data modify storage kaer_test1 temp1[646] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:5}] run data modify storage kaer_test1 temp1[647] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:5}] run data modify storage kaer_test1 temp1[648] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:5}] run data modify storage kaer_test1 temp1[649] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:5}] run data modify storage kaer_test1 temp1[650] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:5}] run data modify storage kaer_test1 temp1[651] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:5}] run data modify storage kaer_test1 temp1[652] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:5}] run data modify storage kaer_test1 temp1[653] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:5}] run data modify storage kaer_test1 temp1[654] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:5}] run data modify storage kaer_test1 temp1[655] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:5}] run data modify storage kaer_test1 temp1[656] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:5}] run data modify storage kaer_test1 temp1[657] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:5}] run data modify storage kaer_test1 temp1[658] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:5}] run data modify storage kaer_test1 temp1[659] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:5}] run data modify storage kaer_test1 temp1[660] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:5}] run data modify storage kaer_test1 temp1[661] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:5}] run data modify storage kaer_test1 temp1[662] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:5}] run data modify storage kaer_test1 temp1[663] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:5}] run data modify storage kaer_test1 temp1[664] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:5}] run data modify storage kaer_test1 temp1[665] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:5}] run data modify storage kaer_test1 temp1[666] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:5}] run data modify storage kaer_test1 temp1[667] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:5}] run data modify storage kaer_test1 temp1[668] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:5}] run data modify storage kaer_test1 temp1[669] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:5}] run data modify storage kaer_test1 temp1[670] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:5}] run data modify storage kaer_test1 temp1[671] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:4}] run data modify storage kaer_test1 temp1[672] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:4}] run data modify storage kaer_test1 temp1[673] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:4}] run data modify storage kaer_test1 temp1[674] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:4}] run data modify storage kaer_test1 temp1[675] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:4}] run data modify storage kaer_test1 temp1[676] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:4}] run data modify storage kaer_test1 temp1[677] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:4}] run data modify storage kaer_test1 temp1[678] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:4}] run data modify storage kaer_test1 temp1[679] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:4}] run data modify storage kaer_test1 temp1[680] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:4}] run data modify storage kaer_test1 temp1[681] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:4}] run data modify storage kaer_test1 temp1[682] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:4}] run data modify storage kaer_test1 temp1[683] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:4}] run data modify storage kaer_test1 temp1[684] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:4}] run data modify storage kaer_test1 temp1[685] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:4}] run data modify storage kaer_test1 temp1[686] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:4}] run data modify storage kaer_test1 temp1[687] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:4}] run data modify storage kaer_test1 temp1[688] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:4}] run data modify storage kaer_test1 temp1[689] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:4}] run data modify storage kaer_test1 temp1[690] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:4}] run data modify storage kaer_test1 temp1[691] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:4}] run data modify storage kaer_test1 temp1[692] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:4}] run data modify storage kaer_test1 temp1[693] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:4}] run data modify storage kaer_test1 temp1[694] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:4}] run data modify storage kaer_test1 temp1[695] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:4}] run data modify storage kaer_test1 temp1[696] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:4}] run data modify storage kaer_test1 temp1[697] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:4}] run data modify storage kaer_test1 temp1[698] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:4}] run data modify storage kaer_test1 temp1[699] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:3}] run data modify storage kaer_test1 temp1[700] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:3}] run data modify storage kaer_test1 temp1[701] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:3}] run data modify storage kaer_test1 temp1[702] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:3}] run data modify storage kaer_test1 temp1[703] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:3}] run data modify storage kaer_test1 temp1[704] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:3}] run data modify storage kaer_test1 temp1[705] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:3}] run data modify storage kaer_test1 temp1[706] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:3}] run data modify storage kaer_test1 temp1[707] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:3}] run data modify storage kaer_test1 temp1[708] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:3}] run data modify storage kaer_test1 temp1[709] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:3}] run data modify storage kaer_test1 temp1[710] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:3}] run data modify storage kaer_test1 temp1[711] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:3}] run data modify storage kaer_test1 temp1[712] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:3}] run data modify storage kaer_test1 temp1[713] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:3}] run data modify storage kaer_test1 temp1[714] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:3}] run data modify storage kaer_test1 temp1[715] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:3}] run data modify storage kaer_test1 temp1[716] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:3}] run data modify storage kaer_test1 temp1[717] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:3}] run data modify storage kaer_test1 temp1[718] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:3}] run data modify storage kaer_test1 temp1[719] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:3}] run data modify storage kaer_test1 temp1[720] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:3}] run data modify storage kaer_test1 temp1[721] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:3}] run data modify storage kaer_test1 temp1[722] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:3}] run data modify storage kaer_test1 temp1[723] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:3}] run data modify storage kaer_test1 temp1[724] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:3}] run data modify storage kaer_test1 temp1[725] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:3}] run data modify storage kaer_test1 temp1[726] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:3}] run data modify storage kaer_test1 temp1[727] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:2}] run data modify storage kaer_test1 temp1[728] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:2}] run data modify storage kaer_test1 temp1[729] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:2}] run data modify storage kaer_test1 temp1[730] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:2}] run data modify storage kaer_test1 temp1[731] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:2}] run data modify storage kaer_test1 temp1[732] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:2}] run data modify storage kaer_test1 temp1[733] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:2}] run data modify storage kaer_test1 temp1[734] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:2}] run data modify storage kaer_test1 temp1[735] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:2}] run data modify storage kaer_test1 temp1[736] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:2}] run data modify storage kaer_test1 temp1[737] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:2}] run data modify storage kaer_test1 temp1[738] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:2}] run data modify storage kaer_test1 temp1[739] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:2}] run data modify storage kaer_test1 temp1[740] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:2}] run data modify storage kaer_test1 temp1[741] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:2}] run data modify storage kaer_test1 temp1[742] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:2}] run data modify storage kaer_test1 temp1[743] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:2}] run data modify storage kaer_test1 temp1[744] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:2}] run data modify storage kaer_test1 temp1[745] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:2}] run data modify storage kaer_test1 temp1[746] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:2}] run data modify storage kaer_test1 temp1[747] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:2}] run data modify storage kaer_test1 temp1[748] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:2}] run data modify storage kaer_test1 temp1[749] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:2}] run data modify storage kaer_test1 temp1[750] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:2}] run data modify storage kaer_test1 temp1[751] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:2}] run data modify storage kaer_test1 temp1[752] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:2}] run data modify storage kaer_test1 temp1[753] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:2}] run data modify storage kaer_test1 temp1[754] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:2}] run data modify storage kaer_test1 temp1[755] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:1,y:1}] run data modify storage kaer_test1 temp1[756] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:2,y:1}] run data modify storage kaer_test1 temp1[757] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:3,y:1}] run data modify storage kaer_test1 temp1[758] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:4,y:1}] run data modify storage kaer_test1 temp1[759] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:5,y:1}] run data modify storage kaer_test1 temp1[760] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:6,y:1}] run data modify storage kaer_test1 temp1[761] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:7,y:1}] run data modify storage kaer_test1 temp1[762] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:8,y:1}] run data modify storage kaer_test1 temp1[763] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:9,y:1}] run data modify storage kaer_test1 temp1[764] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:10,y:1}] run data modify storage kaer_test1 temp1[765] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:11,y:1}] run data modify storage kaer_test1 temp1[766] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:12,y:1}] run data modify storage kaer_test1 temp1[767] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:13,y:1}] run data modify storage kaer_test1 temp1[768] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:14,y:1}] run data modify storage kaer_test1 temp1[769] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:15,y:1}] run data modify storage kaer_test1 temp1[770] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:16,y:1}] run data modify storage kaer_test1 temp1[771] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:17,y:1}] run data modify storage kaer_test1 temp1[772] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:18,y:1}] run data modify storage kaer_test1 temp1[773] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:19,y:1}] run data modify storage kaer_test1 temp1[774] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:20,y:1}] run data modify storage kaer_test1 temp1[775] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:21,y:1}] run data modify storage kaer_test1 temp1[776] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:22,y:1}] run data modify storage kaer_test1 temp1[777] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:23,y:1}] run data modify storage kaer_test1 temp1[778] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:24,y:1}] run data modify storage kaer_test1 temp1[779] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:25,y:1}] run data modify storage kaer_test1 temp1[780] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:26,y:1}] run data modify storage kaer_test1 temp1[781] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:27,y:1}] run data modify storage kaer_test1 temp1[782] set value 1.0 
execute if data storage kaer_test1 temp_grid_xy[{x:28,y:1}] run data modify storage kaer_test1 temp1[783] set value 1.0 
data modify storage ajjnn:data input set from storage kaer_test1 temp1
function ajjnn:_forward
