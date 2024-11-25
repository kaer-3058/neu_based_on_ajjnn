data modify storage io_neu player.painting.points set value []
data modify storage io_neu player.painting.max_point set value {x:2147483647,y:2147483647,z:2147483647}
data modify storage io_neu player.painting.min_point set value {x:-2147483648,y:-2147483648,z:-2147483648}

execute positioned 0. 0. 0. run tp 9e6925b-2-6224-0-f0d3ffc170ff ^ ^ ^1
data modify storage io_neu temp set value {}
data modify storage io_neu temp.x set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0]
data modify storage io_neu temp.y set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[1]
data modify storage io_neu temp.z set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2]

data modify storage io_neu player.painting.points append from storage io_neu temp
data modify storage io_neu player.painting.max_point set from storage io_neu temp
data modify storage io_neu player.painting.min_point set from storage io_neu temp
