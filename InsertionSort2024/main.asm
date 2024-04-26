TITLE InsertionSort implementation algorithm in assembly x86   
; Implementation in C : https://www.geeksforgeeks.org/insertion-sort/?ref=shm
; Insertion Sort animation  : https://www.youtube.com/watch?v=JU767SDMDvA
COMMENT @	   
;// Function to sort an array using
;// insertion sort
;void insertionSort(int arr[], int n)
;{
;    int i, key, j;
;    for (i = 1; i < n; i++) {
;        key = arr[i];
;        j = i - 1;
;
;        // Move elements of arr[0..i-1],
;        // that are greater than key, 
;        // to one position ahead of their
;        // current position
;        while (j >= 0 && arr[j] > key) {
;            arr[j + 1] = arr[j];
;            j = j - 1;
;        }
;        arr[j + 1] = key;
;    }
;}
;
;// A utility function to print an array
;// of size n
;void printArray(int arr[], int n)
;{
;    int i;
;    for (i = 0; i < n; i++)
;        cout << arr[i] << " ";
;    cout << endl;
;}
;
;// Driver code
;int main()
;{
;    int arr[] = { 12, 11, 13, 5, 6 };
;    int N = sizeof(arr) / sizeof(arr[0]);
;
;    insertionSort(arr, N);
;    printArray(arr, N);
;
;    return 0;
;}
@
INCLUDE Irvine32.inc


.data
array DWORD 12, 11, 13, 5, 6
message1 BYTE "Sorted array: ",0dh,0ah, 0	    ; new line in windows OS is a combination
												;of two characters 0xD and 0xA
												;0xA linefeed (\n),
												;0xD carriage return(\r),
delimeter BYTE ", ",0

.code
; -- Swap function --
; Description : This function swaps the values of two integers given as pointers.
; Input : EBP+8 -> Pointer to the first integer
;         EBP+12 -> Pointer to the second integer
; Output : The values of the two integers are swapped.
swap PROC
push ebp
mov ebp,esp
pushad

mov edi ,[ebp+8]
mov eax , [edi]  ; eax <- *a

mov esi ,[ebp+12]
mov ebx , [esi]  ; ebx <- *b

mov [esi],eax    ; *b <- *a
mov [edi],ebx    ; *a <- *b

popad
mov esp,ebp
pop ebp
ret 8
swap ENDP

printArray Proc
push ebp
mov ebp, esp
pushad

;void printArray(int arr[], int size)
;{
;    int i;
;    for (i = 0; i < size; i++)

	 ;initialization
	 mov ebx,0 ; i = 0 loop counter
	 mov edi, [ebp + 8] ; array base address
	 mov edx, [ebp +12]
	 dec edx	; edx <- size - 1
	 jmp COND
	 ;body
	 BODY:
	;cout << " " << arr[i];
	    mov eax, [edi + ebx * 4] ; eax <- array[i] 
		call WriteHex 		
		; check if it is the last element		
		cmp ebx, edx ; i == size-1
		je STEP
		push edx
		mov edx, OFFSET delimeter
		call WriteString
		pop edx
	 ;step
	 STEP:
		inc ebx
	 ;condition		
	 COND:
	    cmp ebx, [ebp + 12] ; i < size
		jl BODY
		call Crlf

popad
mov esp, ebp
pop ebp
ret
printArray Endp
main PROC

exit
main ENDP
END main



