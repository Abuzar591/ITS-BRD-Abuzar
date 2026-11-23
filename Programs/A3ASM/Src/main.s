;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base
VariableA          DCW 0x1234
VariableB          DCW 0x4711

VariableC          DCD  0

MeinHalbwortFeld   DCW 0x22 , 0x3e , -52, 78 , 0x27 , 0x45

MeinWortFeld       DCD 0x12345678 , 0x9dca5986
                   DCD -872415232 , 1308622848
                   DCD 0x27000000
                   DCD 0x45000000

MeinTextFeld       DCB "ABab0123",0

                   EXPORT VariableA
                   EXPORT VariableB
                   EXPORT VariableC
                   EXPORT MeinHalbwortFeld
                   EXPORT MeinWortFeld
                   EXPORT MeinTextFeld

;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard
main            PROC
                bl    initITSboard                 ; HW Initialisieren

; Laden von Konstanten in Register
;Lädt #0x12 in Register 0 laden
                mov   r0,#0x12                      ; Anw-01
;Lädt #-123 in Register 1
                mov   r1,#-128                      ; Anw-02
;Lädt #0x12345678 in Register 2
                ldr   r2,=0x12345678                ; Anw-03

; Zugriff auf Variable
;Lädt VariableA in Register 0
                ldr   r0,=VariableA                 ; Anw-04
;Lädt den Halbwert von Register 0 in Register 1
                ldrh  r1,[r0]                       ; Anw-05
;Lädt den Wert von Register 0 in Register 2
                ldr   r2,[r0]                       ; Anw-06
;Lädt VariableC in Register 0
                ldr   r0,=VariableC                 ; Anw-07
;Speichert den Wert von Register 2 in VariableC
                str   r2,[r0,#VariableC-VariableA]  ; Anw-07

; Zugriff auf Felder (Speicherzellen)
;Lädt MeinHalbwortFeld in Register 0
                ldr   r0,=MeinHalbwortFeld          ; Anw-08
;Lädt den Halbwert von Register 0 in Register 1
                ldrh  r1,[r0]                       ; Anw-09
;Lädt den Halbwert von Register 0 in Register 2 + 2
                ldrh  r2,[r0,#2]                    ; Anw-10
;Lädt den Wert von Register 0 in Register 3 + 10
                mov   r3,#10                        ; Anw-11
;Lädt den Halbwert von Register 0 und Register 3 in Register 4
                ldrh  r4,[r0,r3]                    ; Anw-12
;Lädt den Halbwert von Register 0 in Register 5 + 2
                ldrh  r5,[r0,#2]!                   ; Anw-13
;Lädt den Halbwert von Register 0 in Register 6 + 2               
                ldrh  r6,[r0,#2]!                   ; Anw-14
;Speichert den Halbwert von Register 6 in Register 0 + 2
                strh  r6,[r0,#2]!                   ; Anw-15

; Addition und Subtraktion von unsigned / signed Integer-Werten
;Lädt MeinWortFeld in Register 0
                ldr  r0,=MeinWortFeld               ; Anw-16
;Lädt den Wert von Register 0 in Register 1
                ldr  r1,[r0]                        ; Anw-17
;Lädt den Wert von Register 0 + 4 in Register 2
                ldr  r2,[r0,#4]                     ; Anw-18 
;Addiert Register 1 und Register 2 und speichert das Ergebnis in Register 3
                adds r3,r1,r2                       ; Anw-19
;Lädt den Wert von Register 0 + 8 in Register 4
                ldr  r4,[r0,#8]                     ; Anw-20
;Lädt den Wert von Register 0 + 12 in Register 5
                ldr  r5,[r0,#12]                    ; Anw-21
;Subtrahiert Register 5 von Register 4 und speichert das Ergebnis in Register 6                
                subs r6,r4,r5                       ; Anw-22
;Lädt den Wert von Register 0 + 16 in Register 7
                ldr  r7,[r0,#16]                    ; Anw-23
;Lädt den Wert von Register 0 + 20 in Register 8
                ldr  r8,[r0,#20]                    ; Anw-24
;Subtrahiert Register 8 von Register 7 und speichert das Ergebnis in Register 9
                subs r9,r7,r8                       ; Anw-25

forever         b   forever                         ; Anw-26
                ENDP
                END