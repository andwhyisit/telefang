INCLUDE "telefang.inc"

SECTION "Pause Menu SMS Utils", ROMX[$7028], BANK[$4]
PauseMenu_SMSListingInputHandler::
    ld a, [H_JPInput_Changed]
    and 1
    jr z, .checkBBtn
    
.selectSMSText
    ld a, 3
    ld [byte_FFA1], a
    
    ld e, $2D
    call PauseMenu_LoadMenuMap0
    call PauseMenu_ClearArrowMetasprites
    
    ld hl, $9400
    ld b, $20
    call PauseMenu_ClearInputTiles
    
    ld a, $F0
    ld [W_Status_NumericalTileIndex], a
    call Status_ExpandNumericalTiles
    
    ld a, $85
    ld [W_MainScript_WindowBorderAttribs], a
    call PauseMenu_SelectTextStyle
    
    ld a, $40
    ld [W_MainScript_TileBaseIdx], a
    call PhoneTexts_DrawSMSFromMessages
    
    jp System_ScheduleNextSubSubState
    
.checkBBtn
    ld a, [H_JPInput_Changed]
    and 2
    jr z, .listingNavCheck
    
.dismissMenu
    ld a, 4
    ld [byte_FFA1], a
    
    xor a
    ld [W_MainScript_TextStyle], a
    
    ld a, 7
    ld [W_SystemSubSubState], a
    
    ret

.listingNavCheck
    ld a, [W_MelodyEdit_DataCount]
    cp 1
    ret z
    
    ld a, [W_JPInput_TypematicBtns]
    and $10
    jr z, .prevTraverseCheck
    
.moveToNext
    ld a, 2
    ld [byte_FFA1], a
    
    ld a, [W_MelodyEdit_DataCount]
    dec a
    ld b, a
    
    ld a, [W_MelodyEdit_DataCurrent]
    cp b
    jr nz, .noLoadFF
    
    ld a, $FF
.noLoadFF
    inc a
    ld [W_MelodyEdit_DataCurrent], a
    jp PauseMenu_DrawSMSListingEntry
    
.prevTraverseCheck
    ld a, [W_JPInput_TypematicBtns]
    and $10
    jr z, .idle
    
.moveToPrev
    ld a, 2
    ld [byte_FFA1], a
    
    ld a, [W_MelodyEdit_DataCount]
    dec a
    ld b, a
    
    ld a, [W_MelodyEdit_DataCurrent]
    cp b
    jr nz, .noLoadEnd
    
    ld a, [W_MelodyEdit_DataCount]
.noLoadEnd
    inc a
    ld [W_MelodyEdit_DataCurrent], a
    jp PauseMenu_DrawSMSListingEntry

.idle
    ret

PauseMenu_DrawSMSListingEntry::
    ld b, a
    ld a, [W_MelodyEdit_DataCount]
    dec a
    sub b
    
    ld e, a
    ld d, 0
    sla e
    rl d
    sla e
    rl d
    ld hl, $CD90
    add hl, de
    
    ld a, [hli]
    dec a
    ld c, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld e, a
    
    push de
    call PauseMenu_CallsMenuDrawDenjuuNickname
    pop de
    push de
    
    ld a, d
    call Status_DecimalizeStatValue
    
    ld hl, $9962
    call PauseMenu_DrawTwoDigits
    
    pop de
    ld a, e
    call Status_DecimalizeStatValue
    
    ld hl, $9965
    call PauseMenu_DrawTwoDigits
    
    ld a, [W_MelodyEdit_DataCurrent]
    inc a
    call Status_DecimalizeStatValue
    
    ld hl, $99E2
    call PauseMenu_DrawTwoDigits
    
    ld a, [W_MelodyEdit_DataCount]
    call Status_DecimalizeStatValue
    
    ld hl, $99E5
    jp PauseMenu_DrawTwoDigits