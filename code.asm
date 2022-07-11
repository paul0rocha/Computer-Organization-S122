#include <stdio.h>

int segundos = 0;
int minutos = 0;

void print()
{
    printf("%d:%d\n", minutos,segundos);
}

int main()
{
    __asm {
        inicio:
            call[print]
                mov eax, [segundos]  ; carrega valor de segundos
                inc eax              ; incrementa de 1
                mov[segundos], eax   ; salva valor em segundos
                cmp eax, 59          ; compara com o limite de segundos : eax - 59
                jle inicio           ; se o resultado anterior for negativo volta pro começo
                jmp compara          ; se o resultado anterior for positivo avança para a comparação

        compara:
            mov eax, [minutos]       ; carrega o valor de minutos
                cmp eax, 59          ; compara com o limite de minutos : eax - 59
                jl minuto            ; se o resultado anterior for negativo avança para a contagem de minutos
                jmp reset            ; se o resultado anterior for positivo avança para o reset do tempo

        minuto:
            mov eax, [minutos]       ; carrega valor de minutos
                inc eax              ; incrementa de 1
                mov[minutos], eax    ; salva valor em minutos
                mov eax, 0           ; carrega o valor de 0 para eax
                mov[segundos], eax   ; volta o contador de segundos para 0 
                jmp inicio           ; volta para o início
        reset:
            mov eax, 0               ; carrega eax com o valor 0
            mov[segundos], eax       ; volta o contador de segundos para 0
            mov[minutos], eax        ; volta o contador de minutos para 0
            jmp inicio               ; volta para o início
    }

}