    ASSUME   CS:CODE, DS:DATA
DATA   SEGMENT
;-----------------------------
  MA   DW   11, 12, 13, 14
       DW   21, 22, 23, 24
       DW   31, 32, 33, 34
  HA   EQU  3                ;行数
  LA   EQU  4                ;列数
;-----------------------------
  MB   DW   11, 21, 31, 33, 15
       DW   12, 22, 32, 42, 25
       DW   13, 23, 33, 43, 35
       DW   14, 24, 34, 44, 45
  HB   EQU  4
  LB   EQU  5
;-----------------------------
  MC   DW   HA * LB  DUP(?)
  HC   EQU  HA
  LC   EQU  LB

  HH   DW   ?
  LL   DW   ?
;-----------------------------
DATA   ENDS
;***********************************
CODE   SEGMENT

START:
    MOV   AX, DATA
    MOV   DS, AX

    CALL  CR_LF

    MOV   BX, OFFSET  MA
    MOV   CX, LA
    MOV   DX, HA
    CALL  PRINT_M

    CALL  CR_LF

    MOV   BX, OFFSET  MB
    MOV   CX, LB
    MOV   DX, HB
    CALL  PRINT_M

    CALL  CR_LF

    CALL  MUL_AB

    MOV   BX, OFFSET  MC
    MOV   CX, LC
    MOV   DX, HC
    CALL  PRINT_M

EXIT:
    MOV   AH, 4CH
    INT   21H
;******************************
PRINT_M:              ;矩阵输出
    PUSH  CX
PR2:
    MOV   AX, [BX]
    CALL  PRINT_AX
    CALL  TAB_09
    ADD   BX, 2
    LOOP  PR2
    POP   CX
    CALL  CR_LF
    DEC   DX
    JNZ   PRINT_M
RET
;******************************
PRINT_AX:
    PUSH  BX
    PUSH  CX
    PUSH  DX

    MOV   BX, 10
    MOV   CX, 0
P_LOP1:
    MOV   DX, 0
    DIV   BX
    INC   CX
    PUSH  DX
    CMP   AX, 0
    JNZ   P_LOP1
    MOV   AH, 2
P_LOP2:
    POP   DX
    ADD   DL, '0'
    INT   21H
    LOOP  P_LOP2

    POP   DX
    POP   CX
    POP   BX
RET
;******************************
CR_LF:
    PUSH  AX
    PUSH  DX
    MOV   AH, 2
    MOV   DL, 13
    INT   21H
    MOV   DL, 10
    INT   21H
    POP   DX
    POP   AX
    RET
;******************************
TAB_09:
    PUSH  AX
    PUSH  DX
    MOV   AH, 2
    MOV   DL, 9;','
    INT   21H
    POP   DX
    POP   AX
    RET
;******************************
MUL_AB:               ;矩阵相乘
    MOV   DI, 0
    MOV   HH, 0
MUL_0:
    MOV   LL, 0
;========================
MUL_1:
    MOV   BX, HH
    ADD   BX, HH
;---------------------
    MOV   SI, LL
    ADD   SI, LL
    MOV   CX, LA
MUL_2:
    MOV   AX, MA[BX]
    MOV   DX, MB[SI]
    MUL   DX
    ADD   MC[DI], AX
;-------
    ADD   BX, 2
    ADD   SI, 2 * LB
    LOOP  MUL_2
;---------------------
    ADD   DI, 2
    INC   LL
    CMP   LL, LB
    JNZ   MUL_1
;========================
    ADD   HH, LA
    CMP   HH, HA * LA
    JB    MUL_0
    RET
;******************************
CODE   ENDS
    END   START