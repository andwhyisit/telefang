M_AdviceSetup: MACRO
    ld a, [W_PreviousBank]
    push af
    ld a, [W_CurrentBank]
    push af

    ld a, BANK(@)
    ld [W_PreviousBank], a
    ld [W_CurrentBank], a

    ei ;REMOVE THIS EI ON PAIN OF DEATH^WTERRIBLE EMULATOR BUGS
    
    ;Caller pushes HL to stack before calling, this is how you get it back.
    ld hl, sp+6
    ld a, [hli]
    ld h, [hl]
    ld l, a
ENDM

M_AdviceTeardown: MACRO
    di
    pop af
    ld [W_CurrentBank], a
    pop af
    ld [W_PreviousBank], a
ENDM