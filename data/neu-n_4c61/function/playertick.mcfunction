execute unless score @s rc matches 1 run scoreboard players operation @s rc /= 2 const

execute if score @s rc matches 2 run function neu-n_4c61:paint/player/painting_start
execute if score @s rc matches 2 run function neu-n_4c61:paint_old/player/painting_start
execute if score @s rc matches 3 run function neu-n_4c61:paint/player/painting_running
execute if score @s rc matches 3 run function neu-n_4c61:paint_old/player/painting_running
execute if score @s rc matches 1 run function neu-n_4c61:paint/player/painting_end



#要求：图案必须一笔画完。在上一个图案解析完成后再画下一个。图案不要画得太大。画的时候不要仰头也不要低头。
#手绘图像的转换：Ehan写的
#神经网络模型：ajjnn
#引用：卡儿的数学库 - 整数排序、整数除法
#与ajjnn数据包冲突

#安装 ajjnn：function ajjnn:__install
#卸载 ajjnn：function ajjnn:__uninstall
#获取画笔：give @s minecraft:ink_sac[minecraft:custom_data={ajjnn:{brush:1b}},minecraft:consumable={consume_seconds:2147483647},minecraft:custom_name='[{"text":"Brush","color":"green","italic":false},{"text":" (Right Click on Canvas)","color":"gray"}]']

#为了测试数据包，已经在 EMNIST 数据集上训练了一些用于手写字符分类的简单神经网络，并将其转换为各自的 mcfunction 文件。它们是 （10 个类，96% 的准确率）、（27 个类，86% 的准确率）和 （47 个类，80% 的准确率）。可以通过指定模型的名称（例如 ）来加载模型。demo_digits.mcfunction demo_letters.mcfunction demo_balanced.mcfunction
#载入demo_digits模型：/function ajjnn:__load {model:"demo_digits"}
#载入demo_letters模型：/function ajjnn:__load {model:"demo_letters"}
#载入demo_balanced模型：/function ajjnn:__load {model:"demo_balanced"}
#获得输出：data get storage ajjnn:temp decoded

#模型1：仅数字。输出为int型0~9。
#模型2：仅大写字母。输出为字符串型大写字母。
#模型3：大小写字母和数字。无论是数字还是字母，输出都为字符串型，大写字母全支持，其中小写字母仅包括a b d e f g h n q r t
#都只支持印刷体

#检测玩家是否画完：scoreboard players get #ajnn_RUNNING int
#分数为1就是画完了。
