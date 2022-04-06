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
# - Milestone 1/2/3 (choose the one the applies)
#
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features)
# 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
# ... (add more if necessary)
#
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it!
#
# Are you OK with us sharing the video with people outside course staff?
# - yes / no / yes, and please share this project github link as well!
#
# Any additional information that the TA needs to know:
# - (write here, if any)
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

# $s0 = player previous position
# $s1 = current player position
# $s2 = Starting enemy position
# $s3 = starting power up 
# $s6 = jump size
# $s7 = last address 
# $s4 = storing value for check key
# $s5 = checking value for collision 

# $t6 = storing iteration for pixel while clearing screen 

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


main: 

li $t0, BASE_ADDRESS # $t0 stores the base address for display
li $s7, LAST_ADDRESS
li $s6, LOWER_JUMP
li $s3, STARTING_POWER_UP 
li $s2, STARTING_ENEMY

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
	sw $t4, 13368($t0) 
	sw $t4, 13372($t0) 
	sw $t4, 13376($t0)
	sw $t4, 13380($t0) 
	sw $t4, 13384($t0) 
	sw $t4, 13388($t0)
	sw $t4, 13392($t0)
	sw $t4, 13404($t0) 
	sw $t4, 13408($t0) 
	sw $t4, 13412($t0) 
	sw $t4, 13416($t0) 
	sw $t4, 13420($t0) 
	sw $t4, 13424($t0) 

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
	#address = (23, 51) 

	li $t2, COLOR_GREEN
	li $s3, STARTING_POWER_UP 
	
	sw $t2, 12644($t0) 
	sw $t2, 12900($t0)
	sw $t2, 12896($t0)
	sw $t2, 12904($t0)
	sw $t2, 13156($t0)
	
	main_loop:
	
	check_player_falling: 
	# $s1 stores current player addrress
	# $t4 stores value of 3 rows below current player
	
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
	li $t1, COLOR_WHITE
	
	#print O
	li $t5,  2048
	add $t5, $t5, $t0 
	
	sw $t1, ($t5)
	sw $t1, -124($t5)
	sw $t1, -120($t5)
	sw $t1, -116($t5)
	sw $t1, 16($t5)	
	sw $t1, 144($t5)	
	sw $t1, 272($t5)
	sw $t1, 400($t5)
	sw $t1, 528($t5)
	sw $t1, 652($t5)
	sw $t1, 648($t5)
	
	sw $t1, 128($t5)
	sw $t1, 256($t5)
	sw $t1, 384($t5)
	sw $t1, 512($t5)
	sw $t1, 644($t5)
	
	#print V
	addi $t5, $t5, 24
	sw $t1, -128($t5)
	sw $t1, -112($t5)
	sw $t1, 4($t5)
	sw $t1, 12($t5)
	sw $t1, 132($t5)
	sw $t1, 140($t5)
	sw $t1, 260($t5)
	sw $t1, 268($t5)
	sw $t1, 392($t5)
	sw $t1, 520($t5)
	sw $t1, 648($t5)
	
	#print E
	addi $t5, $t5, 24
	sw $t1, ($t5)
	sw $t1, -128($t5)
	sw $t1, -124($t5)
	sw $t1, -120($t5)
	sw $t1, -116($t5)
	sw $t1, 128($t5)
	sw $t1, 256($t5)
	sw $t1, 260($t5)
	sw $t1, 264($t5)
	sw $t1, 268($t5)
	sw $t1, 384($t5)
	sw $t1, 512($t5)
	sw $t1, 640($t5)
	sw $t1, 644($t5)
	sw $t1, 648($t5)
	sw $t1, 652($t5)
	
	#print R
	addi $t5, $t5, 24
	sw $t1, ($t5)
	sw $t1, -128($t5)
	sw $t1, 128($t5)
	sw $t1, 256($t5)
	sw $t1, 384($t5)
	sw $t1, 512($t5)
	sw $t1, 640($t5)
	sw $t1, -124($t5)
	sw $t1, -120($t5)
	sw $t1, -116($t5)
	sw $t1, -112($t5)
	sw $t1, 16($t5)
	sw $t1, 144($t5)
	sw $t1, 272($t5)
	sw $t1, 268($t5)
	sw $t1, 264($t5)
	sw $t1, 392($t5)
	sw $t1, 524($t5)
	sw $t1, 656($t5)
	sw $t1, 260($t5)
	
	restart:
	li $v0, 32
	li $a0, 1500
	syscall
	
	bne $s4, 0x70, end_game
	b fill

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
	li $t1, 256
	div $s1, $t1
	mfhi $t9
	li $t2, 4
	li $t3, 8
	beq $t9, $zero, main_loop
	beq $t9, $t2, draw_left_edge_4
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
	li $t1, 256
	li $t2, 244
	li $t3, 240
	li $t4, 236
	div $s1, $t1
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
	
power_up:
	addi $s6, $zero, HIGHER_JUMP
	#b check_key
	
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
	
	#b check_key
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
		
fill: 
	li $t4, COLOR_BLACK
	sw $t4, 0($t6)
	
	beq $t6, $s7, main
	addi $t6, $t6, 4
	b fill
	

	
	
	