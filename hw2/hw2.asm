.data
Arr: .space 400
sizedisplay: .asciiz  "Enter Array Size\n"
enternumber: .asciiz  "Enter number:\n"	
entertarget: .asciiz "Enter Target Number:\n"
returnVal: .space 4
possi: .asciiz "Possible"
notpossi: .asciiz "Not possible"
.text
#arr load into $t0
la $t0,Arr#arr la t0

main:
#show arrsize 
li $v0,4
la $a0,sizedisplay
syscall

#get the arraysize
li $v0,5
syscall

#store size into $t2
add $t2,$v0,$zero  # t2 array size 
move $t1,$zero	# t1 i			
sll $t6, $t2, 2	#t6 array size mult t2 2	

#show target number 
li $v0,4
la $a0,entertarget
syscall
#get the target
li $v0,5
syscall
add $a2,$v0,$zero


#-------------------------------------------------------------------
#loop fill array
while1:#for(int i = 0; i < arraySize; ++i)
#cond if(i=size)
beq $t1,$t6,func
#show enter number 
#li $v0,4
#la $a0,enternumber
#syscall
#get the number
li $v0,5
syscall
#fill array with number
move $t4,$v0
#cin >> arr[i]
sw  $t4,Arr($t1) 

addi $t1,$t1,4
j while1

func:
	beq $v0, 1, print
	beq $v0, 0, print1
	move $a0,$t0 # no longer $a0 ARR
	move $a1,$t2 # no longer # $a1 arraysize
	# $a2 targetbumber
	
	jal ChecknumPossibility
	
print:#cout << "Possible!" 
	li $v0,4
	la $a0,possi
	syscall
			
	li $v0,10
	syscall
print1:#cout << "Not possible!"
	li $v0,4
	la $a0,notpossi
	syscall
			
	li $v0,10
	syscall	
	
#-------------------------------------------------------------



ChecknumPossibility:


	addi $sp, $sp, -12 # adjust stack for 4 items
	sw $ra, 8($sp) # save return address
	
	sw $a1, 4($sp) #save arraysize	
	sw $a2, 0($sp)	#save targetnumber
	
	beq $a2, $zero, ifreturn1
	
	addi $t7,$zero,1 #t7 =1
	sub $a1,$a1,$t7 # array size - 1
	sll $s5, $a1, 2
	add $s5, $s5, $t0
	
	
	
	lw $t3,0($s5)
	slt $t8,$a2,$t3
	beq $t8, 1, ifreturn0
	bne $a2, $zero, REC1
	beq $a1, $zero, ifreturn0
	
	addi $sp, $sp, 12 # pop 3 items from stack
	jr $ra # and return 1 

		
REC1:	
	#lw $ra, 8($sp) # save Arr
	#lw $a1, 4($sp) #save arraysize	
	#lw $a2, 0($sp)	#save targetnumber
	sll $s5, $a1, 2
	add $s5, $s5, $t0
	
	lw $t3,0($s5) # get array element  $s0 num(targetnumber)-arr[array size]
	sub $t5,$a2,$t3#
	move $a2,$t5 # new targetnmber
	#addi $sp, $sp, 12 # pop 3 items from stack
	jal ChecknumPossibility
	#addi $sp, $sp, 12 # pop 3 items from stack
	
REC2:	
	#lw $ra, 8($sp) # save Arr
	#lw $a1, 4($sp) #save arraysize	
	#lw $a2, 0($sp)	#save targetnumber

	addi $sp, $sp, 12
	lw $ra, 8($sp) # save Arr
	lw $a1, 4($sp) #save arraysize	
	lw $a2, 0($sp)	#save targetnumber
	sub $a1,$a1,$t7 # array size - 1 
	jal ChecknumPossibility
	#addi $sp, $sp, 12 # pop 3 items from stack
	
	
	
ifreturn1:
	#lw $ra, 8($sp) # save Arr
	#lw $a1, 4($sp) #save arraysize	
	#lw $a2, 0($sp)	#save targetnumber
	addi $v0, $zero, 1 # if so, result is 1
	
	j func # and return 1	
	#addi $sp, $sp, 12 # pop 3 items from stack
	
ifreturn0:	
	move $v0, $zero # if so, result is 0
	j func
	lw $ra, 8($sp) # save Arr
	lw $a1, 4($sp) #save arraysize	
	lw $a2, 0($sp)	#save targetnumber
	addi $sp, $sp, 12 # pop 16 items from stack
	jr $ra # and return 0

	
	
		
	
#print result
	
	
	
#show array for test control
#print:
#lw $t5,0($t0) 
#li $v0,1
#move $a0,$t5
#syscall



	
