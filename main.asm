#include <stdio.h> 
#include <locale.h> 
int lab2(char xf, char yf, short zf) { 
 printf("x = %x, z = %x, y=%x\n", xf, zf, yf); 
 char x, y; 
 short z, vC, vA; 
 //Блок определения переменных 
 x = xf; y = yf; z = zf; 
 // Блок вычислений функций на C 
 vC = (x + 5 * (z + 3)) / (y - 1) + 3; 
 printf("Result in C: v = %x\n", vC); 
 //Блок вычисления функции на ассемблере 
 __asm 
 { 
 mov ax, z;// (z) в AX 
 add ax, 3;// (z+3) в AX 
 mov bx, ax;// (z+3) в BX 
 mov ax, 5;// (5) в Al 
 imul bx;// (5(z+3)) в DX:AX 
 mov bx, ax;// (5 * (z+3)) в DX : BX 
 mov cx, dx; 
 mov al, x;// (x) в AL 
 cbw;//расширяем [byte]AL до [word]AX 
 cwd;//(x) в DX:AX 
 add bx, ax; 
 adc cx, dx;// сложение со смещением 
 mov al, y;// (y) в AL 
 cbw; 
 sub ax, 1;//(y-1) в AX 
 xchg ax, bx;// меняем местам содержимое ячеек 
 mov dx, cx; 
 idiv bx;// ((x+5(z+3)) /(y-1)) в AX 
 add ax, 3;//((x+5(z+3)) /(y-1))+3 в AX 
 mov vA, ax;// помещаем результат в переменную vA 
 } 
 printf("Result in ASM: v=%x\n", vA); 
} 
int main() 
{ 
 printf("Lab 2\nSaakov Alexander\nSKB182\nVar18\n\n"); 
 lab2(-0x2, 0x8, -0x4); 
 printf("Expected result : v=%x\n", 0x2); 
 printf("\n"); 
 lab2(0x4A, -0x7C,0x5E3A); 
 printf("Expected result : v = % x\n", -0x3C2); 
 getchar(); 
 return 0; 
} 
