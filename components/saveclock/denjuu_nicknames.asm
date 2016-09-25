INCLUDE "registers.inc"
INCLUDE "components/saveclock/save_format.inc"

SECTION "Save/Clock Nickname Staging Area", WRAM0[$C9E1]
W_SaveClock_NicknameStaging:: ds M_SaveClock_DenjuuNicknameStagingSize

SECTION "Banked Call Site for Save/Clock Load Denjuu Nickname", ROM0[$065A]
Banked_SaveClock_LoadDenjuuNickname::
	ld a, [W_CurrentBank]
	push af
	ld a, BANK(SaveClock_LoadDenjuuNickname)
	rst $10
	call SaveClock_LoadDenjuuNickname
	pop af
	rst $10
	ret

SECTION "Save/Clock Load Denjuu Nickname", ROMX[$4E12], BANK[$29]
SaveClock_LoadDenjuuNickname::
	ld hl, -SaveClock_StatisticsArray & $FFFF
	add hl, de
	srl h
	rr l
	srl h
	rr l
	ld b, h
	ld c, l
	srl h
	rr l
	add hl, bc ;HL = the original denjuu index * 6
	ld de, SaveClock_NicknameArray
	add hl, de
	
	;Manual SRAM unlock
	ld a, $A
	ld [REG_MBC3_SRAMENABLE], a
	ld a, 2
	ld [REG_MBC3_SRAMBANK], a
	
	ld de, W_SaveClock_NicknameStaging
	ld c, M_SaveClock_DenjuuNicknameSize
	
.stageLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .stageLoop
	
	;Add null terminator
	ld a, $E0
	ld [de], a
	
	;Manual SRAM lock
	ld a, 0
	ld [REG_MBC3_SRAMENABLE], a
	
	ret