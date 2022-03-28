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

.data

Array:    .word   0:10


.text
li $t0, BASE_ADDRESS # $t0 stores the base address for display
li $t1, 0xff0000 # $t1 stores the red colour code
li $t2, 0x00ff00 # $t2 stores the green colour code
li $t3, 0x0000ff # $t3 stores the blue colour code
li $t4, 0xeeb882 #t4 for mustard
li $t5, 0xb4b7b4 #t5 for grey 

li $t7, 0x9c9cf3 #t7 for nice blue
li $t8, 0x000000 #$t8 for black 

main:		
la $t9, A #t9 = addr(A)
add $t6, $zero, $zero 	#$t0 holds i = 0

# address(x,y) = (y * 64 + x) * 4

# PLAYER 1
# address of player bottom left: (x, y) = 10, 40, so address = (40 * 64 + 10) * 4 = 10280
sw $t7, 10280($t0) # paint the first (bottom-left) unit red.
sw $t7, 10284($t0)
sw $t7, 10288($t0)
sw $t2, 10024($t0) # paint the first middle left (x, y) = 10, 39 green, so address = (39 * 64 + 10) * 4 = 10024
sw $t2, 10028($t0)
sw $t2, 10032($t0)
sw $t7, 9768($t0) # paint the first middle left (x, y) = 10, 38 blue, so address = (38 * 64 + 10) * 4 = 9768
sw $t7, 9772($t0)
sw $t7, 9776($t0)

#store address of Player 1 in register 
addi $t6, $t0, 9768

#PLATFORM 1
#address = (9, 41) 

sw $t4, 10532($t0) # paint the first (bottom-left) unit red.
sw $t4, 10536($t0) 
sw $t4, 10540($t0)
sw $t4, 10544($t0) 
sw $t4, 10548($t0) 

#PLATFORM 2
#address = (22, 52) 

sw $t4, 13400($t0) # paint the first (bottom-left) unit red.
sw $t4, 13404($t0) 
sw $t4, 13408($t0) 
sw $t4, 13412($t0) 
sw $t4, 13416($t0) 

#PLATFORM 3
#address = (45, 45) 

sw $t4, 11700($t0) # paint the first (bottom-left) unit red.
sw $t4, 11704($t0) 
sw $t4, 11708($t0) 
sw $t4, 11712($t0) 
sw $t4, 11716($t0) 

#Object 1: Enemy
#address = (46, 44) 

sw $t5, 11448($t0) # paint the first (bottom-left) unit red.
sw $t5, 11452($t0) 
sw $t5, 11456($t0) 
sw $t5, 11192($t0) 
sw $t5, 11196($t0) 
sw $t5, 11200($t0)
sw $t5, 10936($t0) # paint the first (bottom-left) unit red.
sw $t5, 10940($t0) 
sw $t5, 10944($t0) 


#Object 2: Power Up 
#address = (23, 51) 

sw $t2, 13148($t0) # paint the first (bottom-left) unit red.
sw $t2, 13156($t0) 
#sw $t2, 11456($t0) 
sw $t2, 12892($t0) 
#sw $t2, 11196($t0) 
sw $t2, 12900($t0)
sw $t2, 12636($t0) # paint the first (bottom-left) unit red.
sw $t2, 12640($t0) 
sw $t2, 12644($t0) 

#MILESTONE 2

#Player Movement
li $t9, 0xffff0000
lw $t8, 0($t9)
beq $t8, 1, keypress_happened

keypress_happened:
lw $t2, 4($t9) # this assumes $t9 is set to 0xfff0000 from before
beq $t2, 0x61, respond_to_a # ASCII code of 'a' is 0x61 or 97 in decimal
beq $t2, 0x64, respond_to_d

respond_to_a: #move left


addi, $t9, $t9, -12
bge $t9, $zero, move_left

move_left: 

#color old pixels black 
sw $t8, 12($t9) 
sw $t8, 16($t9)
sw $t8, 20($t9)
sw $t8, 304($t9)
sw $t8, 308($t9)
sw $t8, 312($t9)
sw $t8, 560($t9) 
sw $t8, 564($t9)
sw $t8, 568($t9)

#color new pixels blue
sw $t7, 0($t9) 
sw $t7, 4($t9)
sw $t7, 8($t9)
sw $t2, 256($t9)
sw $t2, 260($t9)
sw $t2, 264($t9)
sw $t7, 512($t9)
sw $t7, 516($t9)
sw $t7, 520($t9)

respond_to_d: #move right



li $v0, 10 # terminate the program gracefully
syscall









