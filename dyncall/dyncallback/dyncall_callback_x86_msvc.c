// lib: dyncall_callback
// file: dyncall_callback_x86_msvc.c
// description: callback thunk entry
// platform: x86
// source: Microsoft Visual C++ inline assembly

#define DCThunk_size       16
#define DCArgs_size        20
#define DCValue_size        8

#define CTX_thunk           0
#define CTX_phandler		   16
#define CTX_pargsvt			   20
#define CTX_stack_cleanup  24
#define CTX_userdata		   28

#define frame_arg0		      8
#define frame_ret			      4
#define frame_parent		    0
#define frame_CTX			     -4
#define frame_DCArgs		  -24
#define frame_DCValue		  -32

void __declspec(naked) dcCallbackThunkEntry()
{
  __asm {

	push ebp
	mov  ebp, esp

	// local variable frame_CTX
	push eax			; EAX = CTX*

	// initialize DCArgs
	push 0				; fast_count
	push edx			; fast_data[1]
	push ecx			; fast_data[0]
	lea  ecx, [ebp+frame_arg0]	;   compute arg stack address
	push ecx			; stack_ptr
	push [eax+CTX_pargsvt]		; virtual table*

	mov  ecx, esp			; ECX = DCArgs*

	// initialze DCValue
	push 0
	push 0

	mov  edx, esp			; EDX = DCValue*

	// call handler (context
	push [eax+CTX_userdata]	; userdata
	push edx			; DCValue*
	push ecx			; DCArgs*
	push eax			; DCCallback*
	call [eax+CTX_phandler]

	// cleanup stack

	mov  esp, ebp		; reset esp to frame
  pop  ecx        ; skip parent frame
  pop  ecx        ; load return address
	mov  edx, [ebp+frame_CTX]
	add  esp, [edx+CTX_stack_cleanup] ; cleanup stack
	push ecx		    ; push back return address
	lea  edx, [ebp+frame_DCValue]
	mov  ebp, [ebp]	; EBP = parent frame

	// handle return value

	cmp al, 'd'
	je return_f64
	cmp al, 'f'
	je return_f32
	cmp al, 'L'
	je return_i64
	cmp al, 'i'
	je return_i32
	ret

return_i32:
	mov  eax, [edx]
	ret

return_i64:
	mov  eax, [edx]
	mov  edx, [edx+4]
	ret

return_f32:
	fld dword ptr [edx]
	ret

return_f64:
	fld qword ptr [edx]
	ret

  } 
}