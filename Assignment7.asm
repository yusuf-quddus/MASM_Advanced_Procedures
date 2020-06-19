
Title Assignment 7

COMMENT !
*****************
date: 6/11/2020
*****************
sort dword unsigned integer array in descending order
!

include irvine32.inc

; ===============================================
.data

arr dword 40 dup(?)
instruction byte "Enter up to 40 unsigned integers. To end array, enter 0: ", 0
prompt byte "Enter a number then press enter: ", 0
init_arr byte "Initial Array: ", 0
sorted_arr byte "Array Sorted in Descending Order: ", 0

; =================================================


.code
main proc
	
	;;; instructions ;;;
	mov edx, offset instruction
	call writeString
	call crlf
	mov edx, offset prompt
	call writeString
	call crlf 
	
	;;; enter elements into array ;;;
	sub esp, 4
	push offset arr
	call enter_elem
	pop ebx				; ebx = number of elements in array
	call crlf

	;;; print unsorted array ;;;
	mov edx, offset init_arr
	call writeString
	call crlf
	push ebx
	push offset arr
	call print_arr
	call crlf

	;;; sort array ;;;
	mov edx, offset sorted_arr
	call writeString
	call crlf
	push ebx
	push offset arr
	call sort_arr			; sorting array in descending order
	
	;;; print sorted array ;;;
	push ebx
	push offset arr
	call print_arr
	call crlf

   exit
main endp

; ================================================
; int enter_elem(arr_addr)
;
; Input:
;   ARR_ADDRESS THROUGH THE STACK
; Output:
;   ARR_LENGTH THROUGH THE STACK
; Operation:
;   Fill the array and count the number of elements
; =================================================

enter_elem proc
	
	push ebp
	mov ebp, esp

	push ecx
	push esi
	push eax
	push ebx
   
	xor esi, esi
	mov ebx, [ebp + 8]

	;------------------------------
	;	ecx = 40
	;	while (ecx != 0 && eax != 0) { 
	;		[code]
	;		ecx--;
	; }
	;------------------------------
	mov ecx, 40
	while01:
		call readDec
		cmp eax, 0	
		je out01
			mov [ebx], eax
			add ebx, 4
			inc esi
			dec ecx
			jnz while01
	out01:
	
	mov [ebp + 12], esi				; returns arr_len

	pop ebx
	pop eax
	pop esi
	pop ecx
	pop ebp

	ret 4
enter_elem endp



; ================================================
; void print_arr(arr_addr,arr_len)
;
; Input:
;   ARR_ADDRESS THROUGH STACK
;	ARR_LENGTH THROUGH STACK
; Output:
;   VOID
; Operation:
;  print out the array
; =================================================

print_arr proc

  push ebp
  mov ebp, esp

  push ecx
  push ebx

  mov ecx, [ebp + 12]
  mov ebx, [ebp + 8]
  L1:
	mov eax, [ebx]
	call writeDec
	mov eax, ' '
	call writeChar
	add ebx, 4
  loop L1

  pop ebx
  pop ecx
  pop ebp

  ret 8
print_arr endp



; ================================================
; void sort_arr(arr_addr,arr_len)
;
; Input:
;   ARR_ADDRESS THROUGH STACK
;	ARR_LENGTH THROUGH STACK
; Output:
;   VOID
; Operation:
;   sort the array
; =================================================

sort_arr proc

	push ebp
	mov ebp, esp
	push edx
	push ecx
	push esi
	
	;--------------------------------------------------------------
	;	for (edx = arr_len; edx != 0; edx--) {
	;		for (ecx = arr_len; ecx > 0; ecx--) {
	;			void compare_and_swap(&arr_addr, &(arr_addr++))
	;			arr_addr = arr_addr + 1
	;		}
	;	}
	;--------------------------------------------------------------
	mov edx, [ebp + 12]
	out_loop:
		mov ecx, [ebp + 12]
		mov esi, [ebp + 8]
		in_loop:
            push esi
			add esi, 4
			push esi
			call compare_and_swap
		loop in_loop
        dec edx
	jnz out_loop

	pop esi
	pop ecx
	pop edx
	pop ebp

   ret 8
sort_arr endp



; ===============================================
; void compare_and_swap(x_addr,y_addr)
;
; Input:
;   x_address
;	y_address
; Output:
;   VOID
; Operation:
;  compare and call SWAP ONLY IF Y < X 
; =================================================

compare_and_swap proc
	push ebp
	mov ebp, esp
	push eax
	push ebx
	push ecx
	push edx

	mov eax, [ebp + 8]
	mov ebx, [ebp + 12]
	mov edx, [eax]
	mov ecx, [ebx]
	cmp edx, ecx

	;------------------------------
	;	if (Y < X)
	;		void swap(x_addr, y_addr)
	;------------------------------
	jle out02
		push eax
		push ebx
		call swap
	out02:

	pop edx
	pop ecx
	pop ebx
	pop eax
	pop ebp

	ret 8
compare_and_swap endp



; =================================================
; void swap(x_addr,y_addr)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;  swap the two inputs
; =================================================

swap proc
	push ebp
	mov ebp, esp
	push ecx
	push edx
	push eax
	push ebx

	mov eax, [ebp + 8]
	mov ebx, [ebp + 12]

	;;; do swap ;;; 
	mov ecx, [eax]
	mov edx, [ebx]
	mov [ebx], ecx
	mov [eax], edx

	pop ebx
	pop eax
	pop edx
	pop ecx
	pop ebp
   
   ret 8
swap endp



end main



comment !

Enter up to 40 unsigned integers. To end array, enter 0:
Enter a number then press enter:
4
2
7
5
86
0

Initial Array:
4 2 7 5 86
Array Sorted in Descending Order:
86 7 5 4 2

C:\Users\yusuf\Desktop\Project32_VS2019\Debug\Project.exe (process 18524) exited with code 0.
Press any key to close this window . . .

!
