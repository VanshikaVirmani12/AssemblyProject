#####################################################################
#
# CSCB58 Winter 2022 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Vanshika Virmani, 1006865251, virmani2, v.virmani@mail.utoronto.ca
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4 (update this as needed)
# - Unit height in pixels: 4 (update this as needed)
# - Display width in pixels: 256 (update this as needed)
# - Display height in pixels: 256 (update this as needed)
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1 - Done
# - Milestone 2 - Done
# - Milestone 3 - Done
#
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features)
# 1. (Moving Objects: I have a power up (green plus) and an enemy (red cross) that are continuously moving across the columns. )
# 2. (Health/ Score: I have a score at the top right corner of my game, which shows the number of coins the player has collected. 
#		     This score gets updated when the player collects coins, and it is shown on the screen during the game, 
#		     and after the game over or win screen.)
# 3. (Pick Up Effects: I have 3 different pick ups with 3 different effects in my game. I have a green plus which makes my player jump
#		       higher than usual. I have a red cross that makes my player jump lower than usual. I also yellow coins that
#		       increases the score of the game if the player collects it. )
# 4. (Fail Condition: If my player falls off the screen, then I fail the game, and there is a game over screen.)
# 5. (Winning Condition: If my player collects 2 coins, which makes the score reach to 2, I win the game. There is a 'Win' screen.)
# 6. (Disappearing Platforms: One of my platform disappears and reappears over some interval of time in the game.)
#
# Link to video demonstration for final submission:
# - https://play.library.utoronto.ca/watch/d85cd28776b42f99fc7d742362756250
#
# Are you OK with us sharing the video with people outside course staff?
# - yes!!! 
# https://github.com/VanshikaVirmani12/AssemblyProject/blob/main/game.asm
#
# Any additional information that the TA needs to know:
# - Hope you enjoy the game :)
#
#####################################################################

.eqv BASE_ADDRESS 0x10008000
.eqv PLAYER1 0x1000A62C
.eqv CHECK_KEY 0xffff0000
.eqv LAST_ADDRESS 0x1000BFFC
.eqv WAIT_CLOCK 200
.eqv LOWER_JUMP -3840
.eqv HIGHER_JUMP -7680
.eqv LOWEST_JUMP -2560
.eqv STARTING_POWER_UP 0x1000B164
.eqv STARTING_ENEMY 0x1000AAC4

.data

# $s0 = old player address
# $s1 = current player position
# $s2 = Starting enemy position
# $s3 = starting power up 
# $s6 = jump size
# $s7 = last address 
# $s4 = storing value for check key
# $s5 = checking value for collision 

# $a1 = plyer-power-ups for winning condition
# $t6 = storing iteration for pixel while clearing screen 
# $t1 = address of coin
.text

.eqv COLOR_RED 0xff0000
.eqv COLOR_PLAYER_BLUE 0x00aaff
.eqv COLOR_RED 0xff0000
.eqv COLOR_GREEN 0x00ff00
.eqv COLOR_BLUE 0x00ff00
.eqv COLOR_MUSTARD 0xeeb882
.eqv COLOR_GREY 0xb4b7b4
.eqv COLOR_PLAYER_BLUE 0x00aaff
.eqv COLOR_BLACK 0x000000
.eqv COLOR_PINK 0xffaaff
.eqv COLOR_WHITE 0xffffff
.eqv COLOR_YELLOW 0xffff00

main: 

li $t0, BASE_ADDRESS # $t0 stores the base address for display
li $s7, LAST_ADDRESS
li $s6, LOWER_JUMP
li $s3, STARTING_POWER_UP 
li $s2, STARTING_ENEMY
li $a1, 0


li $t6, BASE_ADDRESS

	li $s1, PLAYER1			#s1 stores player location 
	li $s0, BASE_ADDRESS
	
	initialise_object: 
	
	#draw player
	li $t7, COLOR_PLAYER_BLUE
	sw $t7, 0($s1) #color blue
	sw $t7, 256($s1)
	sw $t7, 512($s1)
	sw $t7, 4($s1) #color blue
	sw $t7, 260($s1)
	sw $t7, 516($s1)
	sw $t7, 8($s1) #color blue
	sw $t7, 264($s1)
	sw $t7, 520($s1)
	
	
	#PLATFORM 1
	#address = (9, 41) 

	li $t4, COLOR_MUSTARD

	sw $t4, 10532($t0) # paint the first (bottom-left) unit mustard.
	sw $t4, 10536($t0) 
	sw $t4, 10540($t0)
	sw $t4, 10544($t0) 
	sw $t4, 10548($t0) 
	sw $t4, 10552($t0) 
	sw $t4, 10556($t0)
	sw $t4, 10560($t0)
		
		#PLATFORM 2
	#address = (12, 52) 

	#sw $t4, 13400($t0) # paint the first (bottom-left) unit red.

	li $t4, COLOR_MUSTARD
	sw $t4, 13404($t0) 
	sw $t4, 13408($t0) 
	sw $t4, 13412($t0) 
	sw $t4, 13416($t0) 
	sw $t4, 13420($t0) 
	sw $t4, 13424($t0) 
	sw $t4, 13428($t0)
	sw $t4, 13432($t0)
	sw $t4, 13436($t0)
	sw $t4, 13440($t0)

	#PLATFORM 3
	#address = (45, 45) 
	li $t4, COLOR_MUSTARD
	
	sw $t4, 11700($t0) # paint the first (bottom-left) unit red.
	sw $t4, 11704($t0) 
	sw $t4, 11708($t0) 
	sw $t4, 11712($t0) 
	sw $t4, 11716($t0)
	sw $t4, 11720($t0)
	sw $t4, 11724($t0)
	sw $t4, 11728($t0)
	
	#Object 1: Enemy
	#address = (49, 42) 

	li $t5, COLOR_RED
	li $s2, STARTING_ENEMY
	
	sw $t5, 10944($t0) 
	sw $t5, 10952($t0) 
	sw $t5, 11204($t0)
	sw $t5, 11456($t0) 
	sw $t5, 11464($t0)
	
	#Object 2: Power Up 
	#address = (23, 49) 

	li $t2, COLOR_GREEN
	li $s3, STARTING_POWER_UP 
	
	sw $t2, 12644($t0) 
	sw $t2, 12900($t0)
	sw $t2, 12896($t0)
	sw $t2, 12904($t0)
	sw $t2, 13156($t0)
	
		
	#Object 3: Coin
	#address = (49, 22)
	li $t2, COLOR_YELLOW
	addi $t1, $t0, 5828 
	 
	 sw $t2, 0($t1)
	 sw $t2, 252($t1)
	 sw $t2, 256($t1)
	 sw $t2, 260($t1)
	 sw $t2, 508($t1)
	 sw $t2, 512($t1)
	 sw $t2, 516($t1)
	 sw $t2, 768($t1)
	 
	
	main_loop:
	beq $a1, $zero, draw_zero
	li $t4, 1
	beq $a1, $t4, draw_one
	li $t4, 2
	beq $a1, $t4, draw_two
	
	
	moving_objects:
	b move_enemy_right
	
	check_player_falling: 
	# $s1 stores current player addrress
	# $t4 stores value of 3 rows below current player (so left side)
	# $t3 stores value of 3 rows below  on right side
	
	#check if player is currently standing on platform, if not, branch to falling
	
	bge $s1, $s7, end
	
	check_platform:
	addi $t4, $zero, 768
	addi $t4, $t4, 8
	add $t4, $t4, $s1
	lw $t4, 0($t4)
	
	addi $t3, $zero, 768
	add $t3, $t3, $s1
	lw $t3, 0($t3)
	
	beq $t4, COLOR_MUSTARD, check_collision
	beq $t3, COLOR_MUSTARD, check_collision
	
	# collision with coin
	beq $s1, $t1, pick_coin
	addi $s5, $s1, 4
	addi $s5, $s5, 768
	beq $s5, $t1, pick_coin
	addi $s5, $s1, -4
	addi $s5, $s5, 768
	beq $s5, $t1, pick_coin
	addi $s5, $s1, 8
	addi $s5, $s5, 768
	beq $s5, $t1, pick_coin
	
	falling_condition:
	b falling
	
	#check for collision
	check_collision:
	addi $s5, $s1, 4
	beq $s5, $s3, power_up
	addi $s5, $s1, 12
	beq $s5, $s3, power_up
	addi $s5, $s1, 8
	beq $s5, $s3, power_up
	move $s5, $s1
	beq $s5, $s3, power_up
	addi $s5, $s1, 768
	beq $s5, $s3, power_up
	addi $s5, $s1, 4
	addi $s5, $s5, 768
	beq $s5, $s3, power_up
	addi $s5, $s1, 8
	addi $s5, $s5, 768
	beq $s5, $s3, power_up
	
	
	addi $s5, $s1, 4
	beq $s5, $s2, enemy_trap
	addi $s5, $s1, 8
	beq $s5, $s2, enemy_trap
	addi $s5, $s1, 12
	beq $s5, $s2, enemy_trap
	move $s5, $s1
	beq $s5, $s2, enemy_trap
	addi $s5, $s1, 768
	beq $s5, $s2, enemy_trap
	addi $s5, $s1, 4
	addi $s5, $s5, 768
	beq $s5, $s2, enemy_trap
	addi $s5, $s1, 8
	addi $s5, $s5, 768
	beq $s5, $s2, enemy_trap
	
	#check key input from users
	check_key:
	li $a3, CHECK_KEY
	lw $s4, 0($a3)	
	bne $s4, 1, main_loop    	#check if $t9 is 1, that means key has been pressed
	b keypress

	main_draw: 
	move $a2, $s1
	b erase_player
	
	end: 
	li $t2, COLOR_WHITE

        sw $t2, 3888($t0)
        sw $t2, 3892($t0)
        sw $t2, 4136($t0)
        sw $t2, 4140($t0)
        sw $t2, 4388($t0)
        sw $t2, 4392($t0)
        sw $t2, 4436($t0)
        sw $t2, 4440($t0)
        sw $t2, 4468($t0)
        sw $t2, 4492($t0)
        sw $t2, 4496($t0)
        sw $t2, 4512($t0)
        sw $t2, 4516($t0)
        sw $t2, 4520($t0)
        sw $t2, 4524($t0)
        sw $t2, 4528($t0)
        sw $t2, 4532($t0)
        sw $t2, 4640($t0)
        sw $t2, 4644($t0)
        sw $t2, 4688($t0)
        sw $t2, 4692($t0)
        sw $t2, 4696($t0)
        sw $t2, 4724($t0)
        sw $t2, 4728($t0)
        sw $t2, 4744($t0)
        sw $t2, 4748($t0)
        sw $t2, 4752($t0)
        sw $t2, 4768($t0)
        sw $t2, 4896($t0)
        sw $t2, 4944($t0)
        sw $t2, 4952($t0)
        sw $t2, 4956($t0)
        sw $t2, 4980($t0)
        sw $t2, 4984($t0)
        sw $t2, 4988($t0)
        sw $t2, 5000($t0)
        sw $t2, 5008($t0)
        sw $t2, 5024($t0)
        sw $t2, 5148($t0)
        sw $t2, 5152($t0)
        sw $t2, 5168($t0)
        sw $t2, 5172($t0)
        sw $t2, 5196($t0)
        sw $t2, 5200($t0)
        sw $t2, 5212($t0)
        sw $t2, 5236($t0)
        sw $t2, 5244($t0)
        sw $t2, 5248($t0)
        sw $t2, 5252($t0)
        sw $t2, 5256($t0)
        sw $t2, 5264($t0)
        sw $t2, 5280($t0)
        sw $t2, 5404($t0)
        sw $t2, 5416($t0)
        sw $t2, 5420($t0)
        sw $t2, 5424($t0)
        sw $t2, 5428($t0)
        sw $t2, 5452($t0)
        sw $t2, 5468($t0)
        sw $t2, 5472($t0)
        sw $t2, 5492($t0)
        sw $t2, 5504($t0)
        sw $t2, 5508($t0)
        sw $t2, 5520($t0)
        sw $t2, 5536($t0)
        sw $t2, 5660($t0)
        sw $t2, 5684($t0)
        sw $t2, 5708($t0)
        sw $t2, 5712($t0)
        sw $t2, 5716($t0)
        sw $t2, 5720($t0)
        sw $t2, 5724($t0)
        sw $t2, 5728($t0)
        sw $t2, 5748($t0)
        sw $t2, 5760($t0)
        sw $t2, 5776($t0)
        sw $t2, 5792($t0)
        sw $t2, 5796($t0)
        sw $t2, 5800($t0)
        sw $t2, 5804($t0)
        sw $t2, 5808($t0)
        sw $t2, 5916($t0)
        sw $t2, 5920($t0)
        sw $t2, 5940($t0)
        sw $t2, 5960($t0)
        sw $t2, 5964($t0)
        sw $t2, 5984($t0)
        sw $t2, 6004($t0)
        sw $t2, 6032($t0)
        sw $t2, 6048($t0)
        sw $t2, 6176($t0)
        sw $t2, 6180($t0)
        sw $t2, 6192($t0)
        sw $t2, 6196($t0)
        sw $t2, 6216($t0)
        sw $t2, 6240($t0)
        sw $t2, 6260($t0)
        sw $t2, 6288($t0)
        sw $t2, 6304($t0)
        sw $t2, 6436($t0)
        sw $t2, 6440($t0)
        sw $t2, 6444($t0)
        sw $t2, 6448($t0)
        sw $t2, 6452($t0)
        sw $t2, 6468($t0)
        sw $t2, 6472($t0)
        sw $t2, 6496($t0)
        sw $t2, 6500($t0)
        sw $t2, 6516($t0)
        sw $t2, 6544($t0)
        sw $t2, 6560($t0)
        sw $t2, 6708($t0)
        sw $t2, 6724($t0)
        sw $t2, 6756($t0)
        sw $t2, 6772($t0)
        sw $t2, 6800($t0)
        sw $t2, 6816($t0)
        sw $t2, 6820($t0)
        sw $t2, 6824($t0)
        sw $t2, 6828($t0)
        sw $t2, 6832($t0)
        sw $t2, 6836($t0)
        sw $t2, 6964($t0)
        sw $t2, 8808($t0)
        sw $t2, 9008($t0)
        sw $t2, 9012($t0)
        sw $t2, 9016($t0)
        sw $t2, 9020($t0)
        sw $t2, 9024($t0)
        sw $t2, 9040($t0)
        sw $t2, 9044($t0)
        sw $t2, 9064($t0)
        sw $t2, 9080($t0)
        sw $t2, 9084($t0)
        sw $t2, 9088($t0)
        sw $t2, 9092($t0)
        sw $t2, 9108($t0)
        sw $t2, 9112($t0)
        sw $t2, 9116($t0)
        sw $t2, 9120($t0)
        sw $t2, 9260($t0)
        sw $t2, 9264($t0)
        sw $t2, 9276($t0)
        sw $t2, 9280($t0)
        sw $t2, 9284($t0)
        sw $t2, 9300($t0)
        sw $t2, 9316($t0)
        sw $t2, 9320($t0)
        sw $t2, 9336($t0)
        sw $t2, 9364($t0)
        sw $t2, 9376($t0)
        sw $t2, 9516($t0)
        sw $t2, 9540($t0)
        sw $t2, 9556($t0)
        sw $t2, 9560($t0)
        sw $t2, 9572($t0)
        sw $t2, 9592($t0)
        sw $t2, 9620($t0)
        sw $t2, 9628($t0)
        sw $t2, 9632($t0)
        sw $t2, 9772($t0)
        sw $t2, 9796($t0)
        sw $t2, 9816($t0)
        sw $t2, 9824($t0)
        sw $t2, 9828($t0)
        sw $t2, 9848($t0)
        sw $t2, 9852($t0)
        sw $t2, 9856($t0)
        sw $t2, 9876($t0)
        sw $t2, 9880($t0)
        sw $t2, 9884($t0)
        sw $t2, 10028($t0)
        sw $t2, 10052($t0)
        sw $t2, 10072($t0)
        sw $t2, 10076($t0)
        sw $t2, 10080($t0)
        sw $t2, 10104($t0)
        sw $t2, 10132($t0)
        sw $t2, 10140($t0)
        sw $t2, 10144($t0)
        sw $t2, 10284($t0)
        sw $t2, 10304($t0)
        sw $t2, 10308($t0)
        sw $t2, 10332($t0)
        sw $t2, 10360($t0)
        sw $t2, 10388($t0)
        sw $t2, 10400($t0)
        sw $t2, 10404($t0)
        sw $t2, 10540($t0)
        sw $t2, 10544($t0)
        sw $t2, 10548($t0)
        sw $t2, 10552($t0)
        sw $t2, 10556($t0)
        sw $t2, 10560($t0)
        sw $t2, 10588($t0)
        sw $t2, 10616($t0)
        sw $t2, 10620($t0)
        sw $t2, 10624($t0)
        sw $t2, 10628($t0)
        sw $t2, 10644($t0)
        sw $t2, 10660($t0)
        
	restart:
	li $v0, 32
	li $a0, 1500
	syscall
	
	#bne $s4, 0x70, end_game
	b fill
	
	winning_condition:
	
	
	li $t2, COLOR_WHITE
	
	sw $t2, 3736($t0)
        sw $t2, 3892($t0)
        sw $t2, 3920($t0)
        sw $t2, 3944($t0)
        sw $t2, 3964($t0)
        sw $t2, 3968($t0)
        sw $t2, 3992($t0)
        sw $t2, 4148($t0)
        sw $t2, 4176($t0)
        sw $t2, 4200($t0)
        sw $t2, 4220($t0)
        sw $t2, 4224($t0)
        sw $t2, 4228($t0)
        sw $t2, 4248($t0)
        sw $t2, 4404($t0)
        sw $t2, 4432($t0)
        sw $t2, 4456($t0)
        sw $t2, 4476($t0)
        sw $t2, 4484($t0)
        sw $t2, 4488($t0)
        sw $t2, 4504($t0)
        sw $t2, 4660($t0)
        sw $t2, 4688($t0)
        sw $t2, 4712($t0)
        sw $t2, 4732($t0)
        sw $t2, 4748($t0)
        sw $t2, 4760($t0)
        sw $t2, 4916($t0)
        sw $t2, 4928($t0)
        sw $t2, 4944($t0)
        sw $t2, 4968($t0)
        sw $t2, 4988($t0)
        sw $t2, 5004($t0)
        sw $t2, 5008($t0)
        sw $t2, 5016($t0)
        sw $t2, 5172($t0)
        sw $t2, 5180($t0)
        sw $t2, 5184($t0)
        sw $t2, 5196($t0)
        sw $t2, 5224($t0)
        sw $t2, 5244($t0)
        sw $t2, 5264($t0)
        sw $t2, 5268($t0)
        sw $t2, 5272($t0)
        sw $t2, 5428($t0)
        sw $t2, 5432($t0)
        sw $t2, 5436($t0)
        sw $t2, 5440($t0)
        sw $t2, 5444($t0)
        sw $t2, 5452($t0)
        sw $t2, 5480($t0)
        sw $t2, 5500($t0)
        sw $t2, 5524($t0)
        sw $t2, 5528($t0)
        sw $t2, 5684($t0)
        sw $t2, 5688($t0)
        sw $t2, 5700($t0)
        sw $t2, 5708($t0)
        sw $t2, 5736($t0)
        sw $t2, 5756($t0)
        sw $t2, 5784($t0)
        sw $t2, 5940($t0)
        sw $t2, 5956($t0)
        sw $t2, 5960($t0)
        sw $t2, 5964($t0)
        sw $t2, 5992($t0)
        sw $t2, 6012($t0)
        sw $t2, 6040($t0)
        sw $t2, 6196($t0)
        sw $t2, 6216($t0)
        sw $t2, 6220($t0)
        sw $t2, 6268($t0)
        sw $t2, 6296($t0)
        
        li $v0, 32
	li $a0, 2000
	syscall
	
	end_game: 
	li $v0, 10								
	syscall
	
	

erase_player: 
	li $t7, COLOR_BLACK
	sw $t7, 0($s0) 
	sw $t7, 256($s0)
	sw $t7, 512($s0)
	sw $t7, 4($s0) #color blue
	sw $t7, 260($s0)
	sw $t7, 516($s0)
	sw $t7, 8($s0) #color blue
	sw $t7, 264($s0)
	sw $t7, 520($s0)

draw_player:
	li $t7, COLOR_PLAYER_BLUE
	sw $t7, 0($a2) #color blue
	sw $t7, 256($a2)
	sw $t7, 512($a2)
	sw $t7, 4($a2) #color blue
	sw $t7, 260($a2)
	sw $t7, 516($a2)
	sw $t7, 8($a2) #color blue
	sw $t7, 264($a2)
	sw $t7, 520($a2)
	
	sleep:
	li $v0, 32
	li $a0, 66
	syscall
	
	b check_key
	
draw_left_edge_8: 
	move $s0, $s1
	addi $s1, $s1, -8
	move $a2, $s1
	b erase_player
	
draw_left_edge_4: 
	move $s0, $s1
	addi $s1, $s1, -4
	move $a2, $s1
	b erase_player

draw_right_edge_4:
	move $s0, $s1
	addi $s1, $s1, 4
	move $a2, $s1
	b erase_player

draw_right_edge_8:
	move $s0, $s1
	addi $s1, $s1, 8
	move $a2, $s1
	b erase_player

falling: 
	# no platform under the player, fall
	#check if we're on the bottom-most row
	#bgt $s1, $s7, end
	
	# collision with coin
	beq $s1, $t1, pick_coin
	
	
falling_more:
	move $s0, $s1
	addi $s1, $s1, 256
	move $a2, $s1
	b erase_player
	
keypress: 
	lw $s4, 4($a3)
	beq $s4, 0x61, respond_to_a # ASCII code of 'a' is 0x61 or 97 in decimal
	beq $s4, 0x64, respond_to_d
	beq $s4, 0x77, respond_to_w
	beq $s4, 0x70, respond_to_p
	
respond_to_a:
	li $t2, 256
	div $s2, $t2
	mfhi $t9
	li $t7, 4
	li $t3, 8
	beq $t9, $zero, main_loop
	beq $t9, $t7, draw_left_edge_4
	beq $t9, $t3, draw_left_edge_8
	
	#check if moving left collides into platform
	move $t9, $s1
	addi $t9, $t9, -8
	lw $t9, 0($t9)
	beq $t9, COLOR_MUSTARD, main_loop
	
	move $t9, $s1
	addi $t9, $t9, -8
	lw $t9, 256($t9)
	beq $t9, COLOR_MUSTARD, main_loop
	
	move $t9, $s1
	addi $t9, $t9, -8
	lw $t9, 512($t9)
	beq $t9, COLOR_MUSTARD, main_loop
	
	move $s0, $s1 #Store old position in $s0
	addi $s1, $s1, -8
	move $a2, $s1
	b erase_player
	
respond_to_d:
	li $t7, 256
	li $t2, 244
	li $t3, 240
	li $t4, 236
	div $s1, $t7
	mfhi $t9
	beq $t9, $t2, main_loop
	beq $t9, $t3, draw_right_edge_4
	beq $t9, $t4, draw_right_edge_8
	
	#check if moving right collides into platform
	move $t9, $s1
	addi $t9, $t9, 16
	lw $t9, 0($t9)
	beq $t9, COLOR_MUSTARD, main_loop
	
	move $t9, $s1
	addi $t9, $t9, 16
	lw $t9, 256($t9)
	beq $t9, COLOR_MUSTARD, main_loop
	
	move $t9, $s1
	addi $t9, $t9, 16
	lw $t9, 512($t9)
	beq $t9, COLOR_MUSTARD, main_loop
	
	move $s0, $s1 #Store old position in $s0
	addi $s1, $s1, 8
	move $a2, $s1
	b erase_player
	
respond_to_w:
	ble $s1, $t0, main_loop #to check if the player is already in the first row, can't go more up
	# if player is not standing on a platform, don't allow for jump
	
	addi $t4, $zero, 768
	addi $t4, $t4, 8
	add $t4, $t4, $s1
	lw $t4, 0($t4)
	
	addi $t3, $zero, 768
	add $t3, $t3, $s1
	lw $t3, 0($t3)
		
	beq $t4, COLOR_MUSTARD, jump_condition
	beq $t3, COLOR_MUSTARD, jump_condition
	
	b main_loop #if not on platform, then will not jump
	
	jump_condition:
	move $s0, $s1 #Store old position in $s0
	add $s1, $s1, $s6
	move $a2, $s1
	b erase_player

respond_to_p:
	b end
	
pick_coin:
	addi $a1, $a1, 1 #incrememnt score by 1
	
	erase_coin:
	li $t2, COLOR_BLACK
	 
	 sw $t2, 0($t1)
	 sw $t2, 252($t1)
	 sw $t2, 256($t1)
	 sw $t2, 260($t1)
	 sw $t2, 508($t1)
	 sw $t2, 512($t1)
	 sw $t2, 516($t1)
	 sw $t2, 768($t1)
	  	
	 li $v0, 32
	 li $a0, 200
	 syscall
	 
	 redraw_coin:
	 addi $t1, $t0, 7208
	 li $t2, COLOR_YELLOW
	 
	 sw $t2, 0($t1)
	 sw $t2, 252($t1)
	 sw $t2, 256($t1)
	 sw $t2, 260($t1)
	 sw $t2, 508($t1)
	 sw $t2, 512($t1)
	 sw $t2, 516($t1)
	 sw $t2, 768($t1)
	 
	 b falling_more
	 
disappear_platform:
	#PLATFORM 1
	#address = (9, 41) 

	li $t2, COLOR_BLACK

	sw $t2, 10532($t0) # paint the first (bottom-left) unit mustard.
	sw $t2, 10536($t0) 
	sw $t2, 10540($t0)
	sw $t2, 10544($t0) 
	sw $t2, 10548($t0) 
	sw $t2, 10552($t0) 
	sw $t2, 10556($t0)
	sw $t2, 10560($t0)

	b erase_enemy

reappear_platform:

	li $t2, COLOR_MUSTARD

	sw $t2, 10532($t0) # paint the first (bottom-left) unit mustard.
	sw $t2, 10536($t0) 
	sw $t2, 10540($t0)
	sw $t2, 10544($t0) 
	sw $t2, 10548($t0) 
	sw $t2, 10552($t0) 
	sw $t2, 10556($t0)
	sw $t2, 10560($t0)

	b erase_enemy


move_enemy_right:
	addi $t3, $s2, 260 #right edge of power up 
	li $t2, 256
	li $t4, 252
	div $t3, $t2
	mfhi $t9
	beq $t9, $t4, move_enemy_left
	addi $t3, $t0, 10832
	addi $t2, $t0, 10932
	move $t4, $s2 #Store old position in $s0
	addi $s2, $s2, 4
	move $t5, $s2
	beq $t3, $s2, disappear_platform
	beq $t2, $s2, reappear_platform
	b erase_enemy
	
move_enemy_left:
	move $t4, $s2
	addi $s2, $t0, 10752
	move $t5, $s2
	b erase_enemy
	
move_power_up_left: 
	addi $t3, $s3, 252 #right edge of power up 
	li $t2, 256
	div $t3, $t2
	mfhi $t9
	beq $t9, $zero, move_power_up_right
	move $t4, $s3 #Store old position in $s0
	addi $s3, $s3, -4
	move $t5, $s3
	b erase_power
	
move_power_up_right:
	move $t4, $s3
	addi $s3, $t0, 12796 #left edge of power up 
	move $t5, $s3
	b erase_power
	
erase_power:
	li $t7, COLOR_BLACK
	sw $t7, 0($t4) 
	sw $t7, 256($t4) 
	sw $t7, 252($t4) 
	sw $t7, 260($t4) 
	sw $t7, 512($t4) 

redraw_power:
	li $t7, COLOR_GREEN
	sw $t7, 0($t5) 
	sw $t7, 256($t5) 
	sw $t7, 252($t5) 
	sw $t7, 260($t5) 
	sw $t7, 512($t5) 

	li $v0, 32
	li $a0, 100
	syscall
	
	b check_player_falling
erase_enemy:
	li $t7, COLOR_BLACK
	sw $t7, -4($t4) 
	sw $t7, 4($t4)	
	sw $t7, 256($t4) 
	sw $t7, 508($t4) 
	sw $t7, 516($t4) 
	
redraw_enemy:
	li $t7, COLOR_RED
	sw $t7, -4($t5) 
	sw $t7, 4($t5)	
	sw $t7, 256($t5) 
	sw $t7, 508($t5) 
	sw $t7, 516($t5) 
	
	li $v0, 32
	li $a0, 100
	syscall
	
	b move_power_up_left
	
power_up:
	addi $s6, $zero, HIGHER_JUMP
	
erase_power_up:
	li $t7, COLOR_BLACK
	sw $t7, 0($s3) 
	sw $t7, 256($s3) 
	sw $t7, 252($s3) 
	sw $t7, 260($s3) 
	sw $t7, 512($s3) 
	
	move $s3, $t0 #address of power up now changes to base address
	li $v0, 32
	li $a0, 100
	syscall

power_up_hit_change_color:
	move $s0, $s1
	move $a2, $s1
	
	li $t7, COLOR_BLACK
	sw $t7, 0($s0) 
	sw $t7, 256($s0)
	sw $t7, 512($s0)
	sw $t7, 4($s0) #color blue
	sw $t7, 260($s0)
	sw $t7, 516($s0)
	sw $t7, 8($s0) #color blue
	sw $t7, 264($s0)
	sw $t7, 520($s0)
	
	li $v0, 32
	li $a0, 400
	syscall
	
	li $t7, COLOR_GREEN
	sw $t7, 0($a2)
	sw $t7, 256($a2)
	sw $t7, 512($a2)
	sw $t7, 4($a2) #color green
	sw $t7, 260($a2)
	sw $t7, 516($a2)
	sw $t7, 8($a2) #color green
	sw $t7, 264($a2)
	sw $t7, 520($a2)
	
	li $v0, 32
	li $a0, 400
	syscall
	
	li $t7, COLOR_BLACK
	sw $t7, 0($s0) 
	sw $t7, 256($s0)
	sw $t7, 512($s0)
	sw $t7, 4($s0) #color blue
	sw $t7, 260($s0)
	sw $t7, 516($s0)
	sw $t7, 8($s0) #color blue
	sw $t7, 264($s0)
	sw $t7, 520($s0)
	
	li $v0, 32
	li $a0, 400
	syscall
	
	b erase_player
	
enemy_trap: 
	addi $s6, $zero, LOWEST_JUMP
	
erase_enemy_trap:
	li $t7, COLOR_BLACK
	sw $t7, -4($s2) 
	sw $t7, 4($s2)	
	sw $t7, 256($s2) 
	sw $t7, 508($s2) 
	sw $t7, 516($s2) 
	
	move $s2, $t0  #address of enemy now changes to base address
	li $v0, 32
	li $a0, 100
	syscall

	
enemy_hit_change_color:
	move $s0, $s1
	move $a2, $s1
	
	li $t7, COLOR_BLACK
	sw $t7, 0($s0) 
	sw $t7, 256($s0)
	sw $t7, 512($s0)
	sw $t7, 4($s0) #color 
	sw $t7, 260($s0)
	sw $t7, 516($s0)
	sw $t7, 8($s0) #color 
	sw $t7, 264($s0)
	sw $t7, 520($s0)
	
	
	li $v0, 32
	li $a0, 400
	syscall
	
	li $t7, COLOR_RED
	sw $t7, 0($a2)
	sw $t7, 256($a2)
	sw $t7, 512($a2)
	sw $t7, 4($a2) #color red
	sw $t7, 260($a2)
	sw $t7, 516($a2)
	sw $t7, 8($a2) #color red
	sw $t7, 264($a2)
	sw $t7, 520($a2)
	
	li $v0, 32
	li $a0, 400
	syscall
	
	li $t7, COLOR_BLACK
	sw $t7, 0($s0) 
	sw $t7, 256($s0)
	sw $t7, 512($s0)
	sw $t7, 4($s0) #color 
	sw $t7, 260($s0)
	sw $t7, 516($s0)
	sw $t7, 8($s0) #color 
	sw $t7, 264($s0)
	sw $t7, 520($s0)
	
	li $v0, 32
	li $a0, 400
	syscall
	
	b erase_player
	
draw_zero:

	li $t2, COLOR_WHITE
	
        sw $t2, 720($t0)
        sw $t2, 740($t0)
        sw $t2, 744($t0)
        sw $t2, 748($t0)
        sw $t2, 972($t0)
        sw $t2, 976($t0)
        sw $t2, 980($t0)
        sw $t2, 996($t0)
        sw $t2, 1004($t0)
        sw $t2, 1228($t0)
        sw $t2, 1232($t0)
        sw $t2, 1236($t0)
        sw $t2, 1252($t0)
        sw $t2, 1260($t0)
        sw $t2, 1488($t0)
        sw $t2, 1508($t0)
        sw $t2, 1516($t0)
        sw $t2, 1764($t0)
        sw $t2, 1768($t0)
        sw $t2, 1772($t0)
        
        b moving_objects
        
draw_one:

	erase_zero:

	li $t2, COLOR_BLACK
	
        sw $t2, 720($t0)
        sw $t2, 740($t0)
        sw $t2, 744($t0)
        sw $t2, 748($t0)
        sw $t2, 972($t0)
        sw $t2, 976($t0)
        sw $t2, 980($t0)
        sw $t2, 996($t0)
        sw $t2, 1004($t0)
        sw $t2, 1228($t0)
        sw $t2, 1232($t0)
        sw $t2, 1236($t0)
        sw $t2, 1252($t0)
        sw $t2, 1260($t0)
        sw $t2, 1488($t0)
        sw $t2, 1508($t0)
        sw $t2, 1516($t0)
        sw $t2, 1764($t0)
        sw $t2, 1768($t0)
        sw $t2, 1772($t0)


	li $t2, COLOR_WHITE
    	sw $t2, 720($t0)
        sw $t2, 744($t0)
        sw $t2, 748($t0)
        sw $t2, 972($t0)
        sw $t2, 976($t0)
        sw $t2, 980($t0)
        sw $t2, 1004($t0)
        sw $t2, 1228($t0)
        sw $t2, 1232($t0)
        sw $t2, 1236($t0)
        sw $t2, 1260($t0)
        sw $t2, 1488($t0)
        sw $t2, 1516($t0)
        sw $t2, 1768($t0)
        sw $t2, 1772($t0)
        sw $t2, 1776($t0)
        
        b moving_objects
        
draw_two:

	erase_one:

	li $t2, COLOR_BLACK
    	sw $t2, 720($t0)
        sw $t2, 744($t0)
        sw $t2, 748($t0)
        sw $t2, 972($t0)
        sw $t2, 976($t0)
        sw $t2, 980($t0)
        sw $t2, 1004($t0)
        sw $t2, 1228($t0)
        sw $t2, 1232($t0)
        sw $t2, 1236($t0)
        sw $t2, 1260($t0)
        sw $t2, 1488($t0)
        sw $t2, 1516($t0)
        sw $t2, 1768($t0)
        sw $t2, 1772($t0)
        sw $t2, 1776($t0)
       

	li $t2, COLOR_WHITE
     	sw $t2, 720($t0)
        sw $t2, 736($t0)
        sw $t2, 740($t0)
        sw $t2, 744($t0)
        sw $t2, 972($t0)
        sw $t2, 976($t0)
        sw $t2, 980($t0)
        sw $t2, 1000($t0)
        sw $t2, 1004($t0)
        sw $t2, 1228($t0)
        sw $t2, 1232($t0)
        sw $t2, 1236($t0)
        sw $t2, 1252($t0)
        sw $t2, 1256($t0)
        sw $t2, 1488($t0)
        sw $t2, 1504($t0)
        sw $t2, 1508($t0)
        sw $t2, 1760($t0)
        sw $t2, 1764($t0)
        sw $t2, 1768($t0)
        sw $t2, 1772($t0)

	b winning_condition
		
fill: 
	li $t4, COLOR_BLACK
	sw $t4, 0($t6)
	
	beq $t6, $s7, main
	addi $t6, $t6, 4
	b fill