INCLUDE "macros.asm"

SECTION "Compressed gfx pointer table", ROMX[$4000], BANK[$6]
	dbwb $00,	$8000, 0 ; $00
	dbwb BANK(BattleMessagesGfx),	$8100, 0 ; $01
	dbwb BANK(UnknownFontGfx),	$8cd0, 0 ; $02
	dbwb BANK(IntroScreensGfx),	$9000, 0 ; $03
	dbwb BANK(IntroBonbonGfx),	$8800, 0 ; $04
	dbwb BANK(MenuOptionsGfx),	$9400, 0 ; $05
	dbwb BANK(TitleSpritesGfx),	$8000, 0 ; $06
	dbwb BANK(CutsceneConnected1Gfx),	$9000, 0 ; $07
	dbwb BANK(CutsceneConnected2Gfx),	$8800, 0 ; $08
	dbwb BANK(EvolveBgGfx),	$8b80, 0 ; $09
	dbwb BANK(TitleTitle1Gfx),	$9000, 0 ; $0a
	dbwb BANK(TitleTitle2Gfx),	$8800, 0 ; $0b
	dbwb BANK(ScreenSaveDeletedGfx),	$9000, 0 ; $0c
	dbwb BANK(MenuUnkGfx),	$8e00, 0 ; $0d
	dbwb BANK(MenuStatsGfx),	$9000, 0 ; $0e
	dbwb BANK(MenuEncounterGfx),	$9000, 0 ; $0f
	dbwb BANK(MenuBattleGfx),	$9000, 0 ; $10
	dbwb BANK(MenuMiscSpritesGfx),	$8000, 0 ; $11
	dbwb BANK(MenuTotalGfx),	$8f00, 0 ; $12
	dbwb BANK(MenuDmeloGfx),	$9400, 0 ; $13
	dbwb BANK(MenuBattle2Gfx),	$9000, 0 ; $14
	dbwb BANK(MenuBattle3Gfx),	$9000, 0 ; $15
	dbwb BANK(MenuGotNumberGfx),	$9000, 0 ; $16
	dbwb BANK(MenuNicknameGfx),	$8e00, 0 ; $17
	dbwb BANK(MenuNumbersGfx),	$9600, 0 ; $18
	dbwb BANK(EvolveBg2Gfx),	$8b80, 0 ; $19
	dbwb BANK(MenuMain1Gfx),	$9400, 0 ; $1a
	dbwb BANK(MenuMain2Gfx),	$8e00, 0 ; $1b
	dbwb $36,	$9000, 0 ; $1c
	dbwb BANK(EvolveBg3Gfx),	$9000, 0 ; $1d
	dbwb BANK(EvolveBg4Gfx),	$9000, 0 ; $1e
	dbwb BANK(EvolveCannotGfx),	$9400, 0 ; $1f
	dbwb BANK(TilemapOverworldGfx),	$9000, 0 ; $20
	dbwb BANK(TilemapAntennaGfx),	$9000, 0 ; $21
	dbwb BANK(TilemapDungeonGfx),	$9000, 0 ; $22
	dbwb BANK(TilemapCaveGfx),	$9000, 0 ; $23
	dbwb BANK(TilemapHouseGfx),	$9000, 0 ; $24
	dbwb BANK(TilemapTreeGfx),	$9000, 0 ; $25
	dbwb BANK(TilemapDungeon2Gfx),	$9000, 0 ; $26
	dbwb BANK(TilemapDungeon3Gfx),	$9000, 0 ; $27
	dbwb BANK(TilemapDungeon4Gfx),	$9000, 0 ; $28
	dbwb BANK(TilemapHuman1Gfx),	$9000, 0 ; $29
	dbwb BANK(TilemapHumanAntennaGfx),	$9000, 0 ; $2a
	dbwb BANK(TilemapHuman2Gfx),	$9000, 0 ; $2b
	dbwb BANK(TilemapShrineGfx),	$9000, 0 ; $2c
	dbwb $29,	$9000, 0 ; $2d
	dbwb $29,	$9000, 0 ; $2e
	dbwb $29,	$9000, 0 ; $2f
	dbwb BANK(IntroShadowAngios1Gfx),	$9000, 0 ; $30
	dbwb BANK(IntroShadowAngios2Gfx),	$8800, 0 ; $31
	dbwb BANK(IntroShigekiGfx),	$9000, 0 ; $32
	dbwb BANK(IntroTreesGfx),	$9000, 0 ; $33
	dbwb BANK(IntroCryptoShigeki1Gfx),	$9000, 0 ; $34
	dbwb BANK(IntroCryptoShigeki2Gfx),	$8800, 0 ; $35
	dbwb BANK(IntroAngios1Gfx),	$9000, 0 ; $36
	dbwb BANK(IntroAngios2Gfx),	$8800, 0 ; $37
	dbwb BANK(IntroCrypto1Gfx),	$9000, 0 ; $38
	dbwb BANK(IntroCrypto2Gfx),	$8800, 0 ; $39
	dbwb BANK(IntroShigekiSprites1Gfx),	$8000, 0 ; $3a
	dbwb BANK(IntroShigekiSprites2Gfx),	$8000, 0 ; $3b
	dbwb BANK(IntroShigekiMouthGfx),	$8000, 0 ; $3c
	dbwb BANK(IntroCryptoCallGfx),	$8000, 0 ; $3d
	dbwb BANK(IntroCryptoShigekiSpritesGfx),	$8000, 0 ; $3e
	dbwb BANK(UnusedClawGfx),	$8000, 0 ; $3f
	dbwb BANK(MenuMultiplayerGfx),	$9000, 0 ; $40
	dbwb BANK(MenuMultiplayer2Gfx),	$8800, 0 ; $41
	dbwb BANK(ScreenGameOverGfx),	$9000, 0 ; $42
	dbwb BANK(ScreenGameOver2Gfx),	$8800, 0 ; $43
	dbwb $29,	$9000, 0 ; $44
	dbwb $29,	$9000, 0 ; $45
	dbwb $29,	$9000, 0 ; $46
	dbwb $29,	$9000, 0 ; $47
	dbwb BANK(MenuMetGfx),	$8f00, 0 ; $48
	dbwb BANK(MenuStatsHabitatGfx), $8700, 0 ; $49 (repurposed)
	dbwb $29,	$9000, 0 ; $4a
	dbwb $29,	$9000, 0 ; $4b
	dbwb $29,	$9000, 0 ; $4c
	dbwb $29,	$9000, 0 ; $4d
	dbwb $29,	$9000, 0 ; $4e
	dbwb $29,	$9000, 0 ; $4f
	dbwb BANK(CutsceneAntennaTreeGfx),	$9000, 0 ; $50
	dbwb BANK(CutsceneKaiGfx),	$9000, 0 ; $51
	dbwb BANK(CutsceneUnusedGfx),	$9000, 0 ; $52
	dbwb $3b,	$9000, 0 ; $53
	dbwb BANK(MenuMain1DMGGfx),	$9400, 0 ; $54
	dbwb BANK(MenuMain2DMGGfx),	$8e00, 0 ; $55
	dbwb BANK(MenuUnkDMGGfx),	$8e00, 0 ; $56
	dbwb BANK(MenuTotalDMGGfx),	$8f00, 0 ; $57
	dbwb BANK(MenuNicknameDMGGfx),	$8e00, 0 ; $58
	dbwb BANK(MenuOptionsDMGGfx),	$9400, 0 ; $59
	dbwb BANK(MenuDmeloDMGGfx),	$9400, 0 ; $5a
	dbwb BANK(MenuMetDMGGfx),	$8f00, 0 ; $5b
	dbwb BANK(CmpGfx_TitleLogo_Tulunk),	$9000, 0 ; $5c (repurposed)
	dbwb BANK(TitleMenuText1Gfx),	$9400, 0 ; $5d (repurposed)
	dbwb BANK(TitleMenuText1DMGGfx),	$9400, 0 ; $5e (repurposed)
	dbwb BANK(TitleSpritesSgbGfx),	$8000, 0 ; $5f (repurposed)

SECTION "Compressed gfx pointer table 2", ROM0[$1DE1]
	dw $0000 ; $00
	dw BattleMessagesGfx ; $01
	dw UnknownFontGfx ; $02
	dw IntroScreensGfx ; $03
	dw IntroBonbonGfx ; $04
	dw MenuOptionsGfx ; $05
	dw TitleSpritesGfx ; $06
	dw CutsceneConnected1Gfx ; $07
	dw CutsceneConnected2Gfx ; $08
	dw EvolveBgGfx ; $09
	dw TitleTitle1Gfx ; $0a
	dw TitleTitle2Gfx ; $0b
	dw ScreenSaveDeletedGfx ; $0c
	dw MenuUnkGfx ; $0d
	dw MenuStatsGfx ; $0e
	dw MenuEncounterGfx ; $0f
	dw MenuBattleGfx ; $10
	dw MenuMiscSpritesGfx ; $11
	dw MenuTotalGfx ; $12
	dw MenuDmeloGfx ; $13
	dw MenuBattle2Gfx ; $14
	dw MenuBattle3Gfx ; $15
	dw MenuGotNumberGfx ; $16
	dw MenuNicknameGfx ; $17
	dw MenuNumbersGfx ; $18
	dw EvolveBg2Gfx ; $19
	dw MenuMain1Gfx ; $1a
	dw MenuMain2Gfx ; $1b
	dw $0000 ; $1c
	dw EvolveBg3Gfx ; $1d
	dw EvolveBg4Gfx ; $1e
	dw EvolveCannotGfx ; $1f
	dw TilemapOverworldGfx ; $20
	dw TilemapAntennaGfx ; $21
	dw TilemapDungeonGfx ; $22
	dw TilemapCaveGfx ; $23
	dw TilemapHouseGfx ; $24
	dw TilemapTreeGfx ; $25
	dw TilemapDungeon2Gfx ; $26
	dw TilemapDungeon3Gfx ; $27
	dw TilemapDungeon4Gfx ; $28
	dw TilemapHuman1Gfx ; $29
	dw TilemapHumanAntennaGfx ; $2a
	dw TilemapHuman2Gfx ; $2b
	dw TilemapShrineGfx ; $2c
	dw $0000 ; $2d
	dw $0000 ; $2e
	dw $0000 ; $2f
	dw IntroShadowAngios1Gfx ; $30
	dw IntroShadowAngios2Gfx ; $31
	dw IntroShigekiGfx ; $32
	dw IntroTreesGfx ; $33
	dw IntroCryptoShigeki1Gfx ; $34
	dw IntroCryptoShigeki2Gfx ; $35
	dw IntroAngios1Gfx ; $36
	dw IntroAngios2Gfx ; $37
	dw IntroCrypto1Gfx ; $38
	dw IntroCrypto2Gfx ; $39
	dw IntroShigekiSprites1Gfx ; $3a
	dw IntroShigekiSprites2Gfx ; $3b
	dw IntroShigekiMouthGfx ; $3c
	dw IntroCryptoCallGfx ; $3d
	dw IntroCryptoShigekiSpritesGfx ; $3e
	dw UnusedClawGfx ; $3f
	dw MenuMultiplayerGfx ; $40
	dw MenuMultiplayer2Gfx ; $41
	dw ScreenGameOverGfx ; $42
	dw ScreenGameOver2Gfx ; $43
	dw $0000 ; $44
	dw $0000 ; $45
	dw $0000 ; $46
	dw $0000 ; $47
	dw MenuMetGfx ; $48
	dw MenuStatsHabitatGfx ; $49 (repurposed)
	dw $0000 ; $4a
	dw $0000 ; $4b
	dw $0000 ; $4c
	dw $0000 ; $4d
	dw $0000 ; $4e
	dw $0000 ; $4f
	dw CutsceneAntennaTreeGfx ; $50
	dw CutsceneKaiGfx ; $51
	dw CutsceneUnusedGfx ; $52
	dw $0000 ; $53
	dw MenuMain1DMGGfx ; $54
	dw MenuMain2DMGGfx ; $55
	dw MenuUnkDMGGfx ; $56
	dw MenuTotalDMGGfx ; $57
	dw MenuNicknameDMGGfx ; $58
	dw MenuOptionsDMGGfx ; $59
	dw MenuDmeloDMGGfx ; $5a
	dw MenuMetDMGGfx ; $5b
	dw CmpGfx_TitleLogo_Tulunk ; $5c (repurposed)
	dw TitleMenuText1Gfx ; $5d (repurposed)
	dw TitleMenuText1DMGGfx ; $5e (repurposed)
	dw TitleSpritesSgbGfx ; $5f (repurposed)
DEF NOT_COMPRESSED EQU 0
DEF COMPRESSED EQU 1

SECTION "Intro - Screens Compressed GFX", ROMX[$4000], BANK[$36]
IntroScreensGfx:
	dbw NOT_COMPRESSED, IntroScreensGfxEnd - IntroScreensGfx - 3
	INCBIN "build/gfx/intro/screens.2bpp"
IntroScreensGfxEnd:

IntroBonbonGfx:
	dbw NOT_COMPRESSED, IntroBonbonGfxEnd - IntroBonbonGfx - 3
	INCBIN "build/gfx/intro/bonbon.2bpp"
IntroBonbonGfxEnd:

MenuEncounterGfx:
	db COMPRESSED
	INCBIN "gfx/menu/encounter.malias"
MenuEncounterGfxEnd:

MenuBattleGfx:
	db COMPRESSED
	INCBIN "gfx/menu/battle.malias"
MenuBattleGfxEnd:

TitleTitle1Gfx:
	dbw NOT_COMPRESSED, TitleTitle1GfxEnd - TitleTitle1Gfx - 3
	INCBIN "build/versions/power/gfx/title/title1.2bpp"
TitleTitle1GfxEnd:

TitleTitle2Gfx:
	dbw NOT_COMPRESSED, TitleTitle2GfxEnd - TitleTitle2Gfx - 3
	INCBIN "build/versions/power/gfx/title/title2.2bpp"
TitleTitle2GfxEnd:

TitleSpritesGfx:
	dbw NOT_COMPRESSED, TitleSpritesGfxEnd - TitleSpritesGfx - 3
	INCBIN "build/gfx/title/sprites.2bpp"
TitleSpritesGfxEnd:

MenuStatsGfx:
	dbw NOT_COMPRESSED, MenuStatsGfxEnd - MenuStatsGfx - 3
	INCBIN "build/gfx/menu/stats.2bpp"
MenuStatsGfxEnd:

UnknownFontGfx:
	db COMPRESSED
	INCBIN "gfx/unknown_font.malias"
UnknownFontGfxEnd:

MenuBattle2Gfx:
	db COMPRESSED
	INCBIN "gfx/menu/battle2.malias"
MenuBattle2GfxEnd:

MenuBattle3Gfx:
	db COMPRESSED
	INCBIN "gfx/menu/battle3.malias"
MenuBattle3GfxEnd:

MenuNumbersGfx:
	db COMPRESSED
	INCBIN "gfx/menu/numbers.malias"
MenuNumbersGfxEnd:

SECTION "Menu - Misc Sprites Compressed GFX", ROMX[$4000], BANK[$3B]
MenuMiscSpritesGfx:
	db COMPRESSED
	INCBIN "gfx/menu/misc_sprites.malias"
MenuMiscSpritesGfxEnd:

BattleMessagesGfx:
	dbw NOT_COMPRESSED, BattleMessagesGfxEnd - BattleMessagesGfx - 3
	INCBIN "build/gfx/battle_messages.2bpp"
BattleMessagesGfxEnd:

ScreenSaveDeletedGfx:
	dbw NOT_COMPRESSED, ScreenSaveDeletedGfxEnd - ScreenSaveDeletedGfx - 3
	INCBIN "build/versions/power/gfx/screen/save_deleted.2bpp"
ScreenSaveDeletedGfxEnd:

CutsceneConnected1Gfx:
	db COMPRESSED
	INCBIN "gfx/cutscene/connected1.malias"
CutsceneConnected1GfxEnd:

CutsceneConnected2Gfx:
	db COMPRESSED
	INCBIN "gfx/cutscene/connected2.malias"
CutsceneConnected2GfxEnd:

EvolveBgGfx:
	db COMPRESSED
	INCBIN "gfx/evolve/bg.malias"
EvolveBgGfxEnd:

MenuGotNumberGfx:
	db COMPRESSED
	INCBIN "gfx/menu/got_number.malias"
MenuGotNumberGfxEnd:

MenuDmeloGfx:
	dbw NOT_COMPRESSED, MenuDmeloGfxEnd - MenuDmeloGfx - 3
	INCBIN "build/gfx/menu/dmelo.2bpp"
MenuDmeloGfxEnd:

MenuOptionsGfx:
	db COMPRESSED
	INCBIN "gfx/menu/options.malias"
MenuOptionsGfxEnd:

EvolveBg2Gfx:
	db COMPRESSED
	INCBIN "gfx/evolve/bg2.malias"
EvolveBg2GfxEnd:

MenuMain1Gfx:
	dbw NOT_COMPRESSED, MenuMain1GfxEnd - MenuMain1Gfx - 3
	INCBIN "build/components/pausemenu/resources/text1.2bpp"
MenuMain1GfxEnd:

MenuMain2Gfx:
	dbw NOT_COMPRESSED, MenuMain2GfxEnd - MenuMain2Gfx - 3
	INCBIN "build/components/pausemenu/resources/text2.2bpp"
MenuMain2GfxEnd:

MenuUnkGfx:
	dbw NOT_COMPRESSED, MenuUnkGfxEnd - MenuUnkGfx - 3
	INCBIN "build/gfx/menu/unk.2bpp"
MenuUnkGfxEnd:

MenuTotalGfx:
	db COMPRESSED
	INCBIN "gfx/menu/total.malias"
MenuTotalGfxEnd:

MenuNicknameGfx:
	dbw NOT_COMPRESSED, MenuNicknameGfxEnd - MenuNicknameGfx - 3
	INCBIN "build/gfx/menu/nickname.2bpp"
MenuNicknameGfxEnd:

MenuMetGfx:
	db COMPRESSED
	INCBIN "gfx/menu/met.malias"
MenuMetGfxEnd:

SECTION "Evolve - Bg4 Compressed GFX", ROMX[$4000], BANK[$61]
EvolveBg3Gfx:
	db COMPRESSED
	INCBIN "gfx/evolve/bg3.malias"
EvolveBg3GfxEnd:

EvolveBg4Gfx:
	db COMPRESSED
	INCBIN "gfx/evolve/bg4.malias"
EvolveBg4GfxEnd:

EvolveCannotGfx:
	dbw NOT_COMPRESSED, EvolveCannotGfxEnd - EvolveCannotGfx - 3
	INCBIN "build/gfx/evolve/cannot.2bpp"
EvolveCannotGfxEnd:

SECTION "Tilemap - Overworld Compressed GFX", ROMX[$4000], BANK[$59]
TilemapOverworldGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/overworld.malias"
TilemapOverworldGfxEnd:

TilemapAntennaGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/antenna.malias"
TilemapAntennaGfxEnd:

TilemapDungeonGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/dungeon.malias"
TilemapDungeonGfxEnd:

TilemapCaveGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/cave.malias"
TilemapCaveGfxEnd:

TilemapHouseGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/house.malias"
TilemapHouseGfxEnd:

TilemapTreeGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/tree.malias"
TilemapTreeGfxEnd:

TilemapDungeon2Gfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/dungeon2.malias"
TilemapDungeon2GfxEnd:

TilemapDungeon3Gfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/dungeon3.malias"
TilemapDungeon3GfxEnd:

TilemapDungeon4Gfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/dungeon4.malias"
TilemapDungeon4GfxEnd:

TilemapHuman1Gfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/human1.malias"
TilemapHuman1GfxEnd:

TilemapHumanAntennaGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/human_antenna.malias"
TilemapHumanAntennaGfxEnd:

MenuStatsHabitatGfx:
	dbw NOT_COMPRESSED, MenuStatsHabitatGfx_END - MenuStatsHabitatGfx - 3
	INCBIN "build/gfx/menu/stats_habitat.2bpp"
MenuStatsHabitatGfx_END:

SECTION "Tilemap - Human2 Compressed GFX", ROMX[$6d29], BANK[$29]
TilemapHuman2Gfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/human2.malias"
TilemapHuman2GfxEnd:

TilemapShrineGfx:
	db COMPRESSED
	INCBIN "gfx/tilemap/shrine.malias"
TilemapShrineGfxEnd:

SECTION "Intro - Shadow Angios1 Compressed GFX", ROMX[$4000], BANK[$39]
IntroShadowAngios1Gfx:
	db COMPRESSED
	INCBIN "versions/power/gfx/intro/shadow_angios1.malias"
IntroShadowAngios1GfxEnd:

IntroShadowAngios2Gfx:
	db COMPRESSED
	INCBIN "versions/power/gfx/intro/shadow_angios2.malias"
IntroShadowAngios2GfxEnd:

IntroShigekiGfx:
	db COMPRESSED
	INCBIN "gfx/intro/shigeki.malias"
IntroShigekiGfxEnd:

IntroTreesGfx:
	db COMPRESSED
	INCBIN "gfx/intro/trees.malias"
IntroTreesGfxEnd:

IntroCryptoShigeki1Gfx:
	db COMPRESSED
	INCBIN "versions/power/gfx/intro/crypto_shigeki1.malias"
IntroCryptoShigeki1GfxEnd:

IntroCryptoShigeki2Gfx:
	dbw NOT_COMPRESSED, IntroCryptoShigeki2GfxEnd - IntroCryptoShigeki2Gfx - 3
	INCBIN "build/versions/power/gfx/intro/crypto_shigeki2.2bpp"
IntroCryptoShigeki2GfxEnd:

IntroAngios1Gfx:
	db COMPRESSED
	INCBIN "versions/power/gfx/intro/angios1.malias"
IntroAngios1GfxEnd:

IntroAngios2Gfx:
	db COMPRESSED
	INCBIN "versions/power/gfx/intro/angios2.malias"
IntroAngios2GfxEnd:

IntroCrypto1Gfx:
	db COMPRESSED
	INCBIN "versions/power/gfx/intro/crypto1.malias"
IntroCrypto1GfxEnd:

IntroCrypto2Gfx:
	db COMPRESSED
	INCBIN "versions/power/gfx/intro/crypto2.malias"
IntroCrypto2GfxEnd:

SECTION "Intro - Shigeki Sprites1 Compressed GFX", ROMX[$4000], BANK[$3a]
IntroShigekiSprites1Gfx:
	db COMPRESSED
	INCBIN "gfx/intro/shigeki_sprites1.malias"
IntroShigekiSprites1GfxEnd:

IntroShigekiSprites2Gfx:
	db COMPRESSED
	INCBIN "gfx/intro/shigeki_sprites2.malias"
IntroShigekiSprites2GfxEnd:

IntroShigekiMouthGfx:
	db COMPRESSED
	INCBIN "gfx/intro/shigeki_mouth.malias"
IntroShigekiMouthGfxEnd:

IntroCryptoCallGfx:
	db COMPRESSED
	INCBIN "versions/power/gfx/intro/crypto_call.malias"
IntroCryptoCallGfxEnd:

IntroCryptoShigekiSpritesGfx:
	db COMPRESSED
	INCBIN "gfx/intro/crypto_shigeki_sprites.malias"
IntroCryptoShigekiSpritesGfxEnd:

UnusedClawGfx:
	db COMPRESSED
	INCBIN "gfx/unused_claw.malias"
UnusedClawGfxEnd:

MenuMultiplayerGfx:
	dbw NOT_COMPRESSED, MenuMultiplayerGfxEnd - MenuMultiplayerGfx - 3
	INCBIN "build/gfx/menu/multiplayer.2bpp"
MenuMultiplayerGfxEnd:

MenuMultiplayer2Gfx:
	dbw NOT_COMPRESSED, MenuMultiplayer2GfxEnd - MenuMultiplayer2Gfx - 3
	INCBIN "build/gfx/menu/multiplayer2.2bpp"
MenuMultiplayer2GfxEnd:

ScreenGameOverGfx:
	db COMPRESSED
	INCBIN "versions/power/gfx/screen/game_over.malias"
ScreenGameOverGfxEnd:

ScreenGameOver2Gfx:
	db COMPRESSED
	INCBIN "versions/power/gfx/screen/game_over2.malias"
ScreenGameOver2GfxEnd:

SECTION "Cutscene - Antenna Tree Compressed GFX", ROMX[$6c7f], BANK[$39]
CutsceneAntennaTreeGfx:
	db COMPRESSED
	INCBIN "gfx/cutscene/antenna_tree.malias"
CutsceneAntennaTreeGfxEnd:

CutsceneKaiGfx:
	db COMPRESSED
	INCBIN "gfx/cutscene/kai.malias"
CutsceneKaiGfxEnd:

CutsceneUnusedGfx:
	db COMPRESSED
	INCBIN "gfx/cutscene/unused.malias"
CutsceneUnusedGfxEnd:

SECTION "Menu - Dmelo DMG Compressed GFX", ROMX[$4000], BANK[$35]
MenuDmeloDMGGfx:
	dbw NOT_COMPRESSED, MenuDmeloDMGGfxEnd - MenuDmeloDMGGfx - 3
	INCBIN "build/gfx/menu/dmelo_dmg.2bpp"
MenuDmeloDMGGfxEnd:

MenuOptionsDMGGfx:
	dbw NOT_COMPRESSED, MenuOptionsDMGGfxEnd - MenuOptionsDMGGfx - 3
	INCBIN "build/gfx/menu/options_dmg.2bpp"
MenuOptionsDMGGfxEnd:

MenuMain1DMGGfx:
	dbw NOT_COMPRESSED, MenuMain1DMGGfxEnd - MenuMain1DMGGfx - 3
	INCBIN "build/components/pausemenu/resources/text1_dmg.2bpp"
MenuMain1DMGGfxEnd:

TitleMenuText1Gfx:
	dbw NOT_COMPRESSED, TitleMenuText1GfxEnd - TitleMenuText1Gfx - 3
	INCBIN "build/components/titlemenu/resources/text1.2bpp"
TitleMenuText1GfxEnd:

TitleMenuText1DMGGfx:
	dbw NOT_COMPRESSED, TitleMenuText1GfxEnd - TitleMenuText1Gfx - 3
	INCBIN "build/components/titlemenu/resources/text1_dmg.2bpp"
TitleMenuText1DMGGfxEnd:

MenuMain2DMGGfx:
	dbw NOT_COMPRESSED, MenuMain2DMGGfxEnd - MenuMain2DMGGfx - 3
	INCBIN "build/components/pausemenu/resources/text2_dmg.2bpp"
MenuMain2DMGGfxEnd:

MenuUnkDMGGfx:
	dbw NOT_COMPRESSED, MenuUnkDMGGfxEnd - MenuUnkDMGGfx - 3
	INCBIN "build/gfx/menu/unk_dmg.2bpp"
MenuUnkDMGGfxEnd:

MenuTotalDMGGfx:
	dbw NOT_COMPRESSED, MenuTotalDMGGfxEnd - MenuTotalDMGGfx - 3
	INCBIN "build/gfx/menu/total_dmg.2bpp"
MenuTotalDMGGfxEnd:

MenuNicknameDMGGfx:
	dbw NOT_COMPRESSED, MenuNicknameDMGGfxEnd - MenuNicknameDMGGfx - 3
	INCBIN "build/gfx/menu/nickname_dmg.2bpp"
MenuNicknameDMGGfxEnd:

MenuMetDMGGfx:
	dbw NOT_COMPRESSED, MenuMetDMGGfxEnd - MenuMetDMGGfx - 3
	INCBIN "build/gfx/menu/met_dmg.2bpp"
MenuMetDMGGfxEnd:

TitleSpritesSgbGfx:
	dbw NOT_COMPRESSED, TitleSpritesSgbGfxEnd - TitleSpritesSgbGfx - 3
	INCBIN "build/gfx/title/sprites_sgb.2bpp"
TitleSpritesSgbGfxEnd:

CmpGfx_TitleLogo_Tulunk:
    dbw NOT_COMPRESSED, CmpGfx_TitleLogo_Tulunk_END - CmpGfx_TitleLogo_Tulunk - 3
    INCBIN "build/components/titlelogo/tulunk.2bpp"
CmpGfx_TitleLogo_Tulunk_END:
