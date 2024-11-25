gamerule maxCommandChainLength 2147483647
gamerule maxCommandForkCount 2147483647

scoreboard objectives add int dummy
scoreboard objectives add const dummy
scoreboard objectives add num dummy
scoreboard objectives add nu_neu_m dummy
scoreboard objectives add rc dummy
scoreboard players reset @a rc

scoreboard players set canva_distance num 3000000
scoreboard players set canva_distance nu_neu_m 3000000

#常量
scoreboard players set -1 const -1
scoreboard players set 0 const 0
scoreboard players set 1 const 1
scoreboard players set 2 const 2
scoreboard players set 3 const 3
scoreboard players set 4 const 4
scoreboard players set 5 const 5
scoreboard players set 6 const 6
scoreboard players set 7 const 7
scoreboard players set 8 const 8
scoreboard players set 9 const 9

scoreboard players set 10 const 10
scoreboard players set 100 const 100
scoreboard players set 1000 const 1000
scoreboard players set 10000 const 10000
scoreboard players set 100000 const 100000
scoreboard players set 1000000 const 1000000
scoreboard players set 10000000 const 10000000
scoreboard players set 100000000 const 100000000
scoreboard players set 1000000000 const 1000000000
scoreboard players set -2 const -2
scoreboard players set -3 const -3
scoreboard players set -360 const -360
scoreboard players set -1000 const -1000
scoreboard players set -10000 const -10000
scoreboard players set -2147483648 const -2147483648

scoreboard players set 12 const 12
scoreboard players set 16 const 16
scoreboard players set 17 const 17
scoreboard players set 18 const 18
scoreboard players set 20 const 20
scoreboard players set 22 const 22
scoreboard players set 24 const 24
scoreboard players set 25 const 25
scoreboard players set 30 const 30
scoreboard players set 36 const 36
scoreboard players set 40 const 40
scoreboard players set 45 const 45
scoreboard players set 60 const 60
scoreboard players set 72 const 72
scoreboard players set 119 const 119
scoreboard players set 180 const 180
scoreboard players set 250 const 250
scoreboard players set 256 const 256
scoreboard players set 360 const 360
scoreboard players set 400 const 400
scoreboard players set 405 const 405
scoreboard players set 425 const 425
scoreboard players set 559 const 559
scoreboard players set 600 const 600
scoreboard players set 1535 const 1535
scoreboard players set 1625 const 1625
scoreboard players set 2000 const 2000
scoreboard players set 2500 const 2500
scoreboard players set 2776 const 2776
scoreboard players set 3162 const 3162
scoreboard players set 3125 const 3125
scoreboard players set 3600 const 3600
scoreboard players set 4000 const 4000
scoreboard players set 4096 const 4096
scoreboard players set 4214 const 4214
scoreboard players set 4750 const 4750
scoreboard players set 5000 const 5000
scoreboard players set 20000 const 20000
scoreboard players set 24703 const 24703
scoreboard players set 32768 const 32768
scoreboard players set 40000 const 40000
scoreboard players set 50436 const 50436
scoreboard players set 57121 const 57121
scoreboard players set 62831 const 62831
scoreboard players set 65536 const 65536
scoreboard players set 79249 const 79249
scoreboard players set 90000 const 90000
scoreboard players set 400000 const 400000
scoreboard players set 520000 const 520000
scoreboard players set 900000 const 900000
scoreboard players set 1048576 const 1048576
scoreboard players set 1800000 const 1800000
scoreboard players set 3600000 const 3600000
scoreboard players set 16777216 const 16777216
scoreboard players set 268435456 const 268435456
scoreboard players set 360000000 const 360000000

data modify storage kaer_test1 store_sort_int_inp_1 set value []
data modify storage kaer_test1 store_sort_int_inp_y set value []
data modify storage kaer_test1 store_sort_int_inp_1_step set value []
scoreboard players set #ajnn_RUNNING int 0

execute in minecraft:overworld run forceload add -1 -1 1 1
execute in minecraft:overworld run forceload add -29999982 22022220

# 9e6925b-2-6224-0-f0d3ffc170ff
execute in minecraft:overworld run summon marker .0 .0 .0 {UUID:[I;166105691,156196,61651,-4099841]}

execute store result score #valid num run data modify storage io player merge value {_:true}
execute if score #valid num matches 0 run data modify storage io player set value {}
data remove storage io player._

execute store result score #valid nu_neu_m run data modify storage io_neu player merge value {_:true}
execute if score #valid nu_neu_m matches 0 run data modify storage io_neu player set value {}
data remove storage io_neu player._
