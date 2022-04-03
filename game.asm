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
.eqv LAST_ADDRESS 0x1000BDFC
.eqv WAIT_CLOCK 200

.data

.text
li $t0, BASE_ADDRESS # $t0 stores the base address for display
li $s7, LAST_ADDRESS
li $s6, WAIT_CLOCK
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


main: 
	li $s1, PLAYER1			#s1 stores player location 
	li $s0, BASE_ADDRESS
	
	li $s3, 0 #Collision flag

	initialise_object: 
	
	#draw player
	li $t7, COLOR_PLAYER_BLUE
	sw $t7, 0($s1) #color blue
	sw $t7, 256($s1)
	sw $t7, 512($s1)
	
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

	sw $t4, 11700($t0) # paint the first (bottom-left) unit red.
	sw $t4, 11704($t0) 
	sw $t4, 11708($t0) 
	sw $t4, 11712($t0) 
	sw $t4, 11716($t0)
	sw $t4, 11720($t0)
	sw $t4, 11724($t0)
	sw $t4, 11728($t0)
	
	main_loop:
	
	check_player_falling: 
	# $s1 stores current player addrress
	# $t4 stores value of 3 rows below current player
	
	#check if player is currently standing on platform, if not, branch to falling
	addi $t4, $zero, 768
	add $t4, $t4, $s1
	lw $t4, 0($t4)
	bne $t4, 0xeeb882, falling
	
	#check key input from users
	check_key:
	li $a3, CHECK_KEY
	lw $s4, 0($a3)	
	bne $s4, 1, main_loop    	#check if $t9 is 1, that means key has been pressed
	b keypress

	main_draw: 
	move $a2, $s1
	b erase_player
	
	b main_loop
	
	end: 
	li $v0, 10								
	syscall

erase_player: 
	li $t7, COLOR_BLACK
	sw $t7, 0($s0) 
	sw $t7, 256($s0)
	sw $t7, 512($s0)

draw_player:
	li $t7, COLOR_PLAYER_BLUE
	sw $t7, 0($a2) #color blue
	sw $t7, 256($a2)
	sw $t7, 512($a2)
	
	sleep:
	li $v0, 32
	li $a0, 200
	syscall
	
	b check_key
	
	b main_loop

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
	
respond_to_a:
	li $t1, 256
	div $s1, $t1
	mfhi $t9
	li $t2, 4
	beq $t9, $zero, main_loop
	beq $t9, $t2, main_loop
	move $s0, $s1 #Store old position in $s0
	addi $s1, $s1, -8
	move $a2, $s1
	b erase_player
	b main_loop
	
respond_to_d:
	li $t1, 256
	li $t2, 252
	li $t3, 248
	div $s1, $t1
	mfhi $t9
	beq $t9, $t2, main_loop
	beq $t9, $t3, main_loop
	move $s0, $s1 #Store old position in $s0
	addi $s1, $s1, 8
	move $a2, $s1
	b erase_player
	b main_loop
	
respond_to_w:
	ble $s1, $t0, main_loop #to check if the player is already in the first row, can't go more up
	move $s0, $s1 #Store old position in $s0
	addi $s1, $s1, -2560
	move $a2, $s1
	b erase_player
	b main_loop
	
keypress_done: 

	
	