;TODO: Determine actual size of array
M_SaveClock_MaxDenjuuContacts EQU 1

;Size of individual save data elements.
;WARNING: Other routines assume these values when calculating pointers.
;Changing these values will break code.
M_SaveClock_DenjuuStatSize EQU $10
M_SaveClock_DenjuuNicknameSize EQU 6

;Size of various staging areas.
M_SaveClock_DenjuuNicknameStagingSize EQU M_StringTable_Load8AreaSize + 1