scoreboard players set #max ajjnn -2147483648
scoreboard players set #count ajjnn 0
execute store result score #length ajjnn run data get storage ajjnn:math v1

execute if score #count ajjnn < #length ajjnn run function ajjnn:control/math/argmax_vector_elements