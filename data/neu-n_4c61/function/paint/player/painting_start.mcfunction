scoreboard players set #ajnn_RUNNING int 0

data modify storage io player.painting.output set value []
data modify storage kaer_test1 temp_out_int_x set value []
data modify storage kaer_test1 temp_out_int_y set value []

execute positioned 0. 0. 0. run tp 9e6925b-2-6224-0-f0d3ffc170ff ^ ^ ^1
data modify storage io temp set value {}
data modify storage io temp.x set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0]
data modify storage io temp.y set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[1]
data modify storage io temp.z set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2]

data modify storage io player.painting.points set value []
data modify storage io player.painting.points append from storage io temp
data modify storage io player.painting.max_point set from storage io temp
data modify storage io player.painting.min_point set from storage io temp
