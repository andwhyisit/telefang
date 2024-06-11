.PHONY: all compare_power compare_speed clean power speed

.SUFFIXES:
.SUFFIXES: .asm .o .gbc .png .wav .wikitext

BASE_DIR := baseroms
BUILD_DIR := build

# Build Telefang.
# We have two targets:
# Power (English on top of Japanese Power)
# Speed (English on top of Japanese Speed)
ROMS_POWER := ${BUILD_DIR}/telefang_pw_english.gbc
ROMS_POWER_NORTC := ${BUILD_DIR}/telefang_pw_english_nortc.gbc
BASEROM_POWER := ${BASE_DIR}/baserom_pw.gbc
ROMS_SPEED := ${BUILD_DIR}/telefang_sp_english.gbc
ROMS_SPEED_NORTC := ${BUILD_DIR}/telefang_sp_english_nortc.gbc
BASEROM_SPEED := ${BASE_DIR}/baserom_sp.gbc
OBJS := $(patsubst %.asm,%.o,$(shell find components gfx script -type f -name "*.asm"))

OBJS_POWER := $(patsubst %.asm,%.o,$(shell find versions/power -type f -name "*.asm"))
OBJS_SPEED := $(patsubst %.asm,%.o,$(shell find versions/speed -type f -name "*.asm"))

SRC_MESSAGE := $(shell find script -type f -name "*.messages.csv") $(shell find components -type f -name "*.messages.csv")

INT_MESSAGE := build/script/mainscript_data.asm
OBJS_MESSAGE := build/script/mainscript_data.o

OBJS_RGBASM := ${OBJS} ${OBJS_POWER} ${OBJS_SPEED}

PYTHON := $(shell rip_scripts/find_python.sh)
ifndef PYTHON
$(error Couldn't find Python 3)
endif

# Link objects together to build a rom.
all: power speed

ips: $(ROMS_POWER:.gbc=.ips) $(ROMS_SPEED:.gbc=.ips)

power: $(ROMS_POWER) $(ROMS_POWER_NORTC)

speed: $(ROMS_SPEED) $(ROMS_SPEED_NORTC)

# Assemble source files into objects.
$(OBJS_RGBASM:%.o=${BUILD_DIR}/%.o): $(BUILD_DIR)/%.o : %.asm
	@echo "Assembling" $<
	@mkdir -p $(dir $@)
	@rgbasm -o $@ $<

$(ROMS_POWER): $(OBJS:%.o=${BUILD_DIR}/%.o) $(OBJS_POWER:%.o=${BUILD_DIR}/%.o)  $(OBJS_MESSAGE) 
	rgblink -n $(ROMS_POWER:.gbc=.sym) -m $(ROMS_POWER:.gbc=.map) -O $(BASEROM_POWER) -o $@ $^
	rgbfix -v -c -i BTXJ -k 2N -l 0x33 -m 0x10 -p 0 -r 3 -s -t "TELEFANG PW" $@

$(ROMS_SPEED): $(OBJS:%.o=${BUILD_DIR}/%.o) $(OBJS_SPEED:%.o=${BUILD_DIR}/%.o)  $(OBJS_MESSAGE) 
	rgblink -n $(ROMS_SPEED:.gbc=.sym) -m $(ROMS_SPEED:.gbc=.map) -O $(BASEROM_SPEED) -o $@ $^
	rgbfix -v -c -i BTZJ -k 2N -l 0x33 -m 0x10 -p 0 -r 3 -s -t "TELEFANG SP" $@

$(ROMS_POWER_NORTC): $(OBJS:%.o=${BUILD_DIR}/%.o) $(OBJS_POWER:%.o=${BUILD_DIR}/%.o)  $(OBJS_MESSAGE) $(OBJS_MESSAGE_BLOCKS) 
	rgblink -n $(ROMS_POWER_NORTC:.gbc=.sym) -m $(ROMS_POWER_NORTC:.gbc=.map) -O $(BASEROM_POWER) -o $@ $^
	rgbfix -v -c -i BTXJ -k 2N -l 0x33 -m 0x13 -p 0 -r 3 -s -t "TELEFANG PW" $@

$(ROMS_SPEED_NORTC): $(OBJS:%.o=${BUILD_DIR}/%.o) $(OBJS_SPEED:%.o=${BUILD_DIR}/%.o)  $(OBJS_MESSAGE) $(OBJS_MESSAGE_BLOCKS) 
	rgblink -n $(ROMS_SPEED_NORTC:.gbc=.sym) -m $(ROMS_SPEED_NORTC:.gbc=.map) -O $(BASEROM_SPEED) -o $@ $^
	rgbfix -v -c -i BTZJ -k 2N -l 0x33 -m 0x13 -p 0 -r 3 -s -t "TELEFANG SP" $@

# Remove files generated by the build process.
clean:
	rm -f $(ROMS_POWER) $(ROMS_POWER_NORTC) $(OBJS) $(OBJS_POWER) $(ROMS_POWER:.gbc=.sym) $(ROMS_POWER:.gbc=.map) $(ROMS_POWER_NORTC:.gbc=.sym) $(ROMS_POWER_NORTC:.gbc=.map) $(ROMS_SPEED) $(ROMS_SPEED_NORTC) $(OBJS_SPEED) $(ROMS_SPEED:.gbc=.sym) $(ROMS_SPEED:.gbc=.map) $(ROMS_SPEED_NORTC:.gbc=.sym) $(ROMS_SPEED_NORTC:.gbc=.map) $(OBJS_MESSAGE) $(INT_MESSAGE) $(ROMS_POWER:.gbc=.ips) $(ROMS_SPEED:.gbc=.ips)
	find . \( -iname '*.1bpp' -o -iname '*.2bpp' -o -iname '*.pcm' -o -iname '*.scripttbl' -o -iname '*.tmap' -o -iname '*.stringtbl' -o -iname '*.sprite.bin' -o -iname '*.atf' \) -exec rm {} +

#This rule is needed if we want make to not die. It expects to see .inc files in
#the build directory now that we moved all resources there. We DO want to see
#.inc files as dependencies but I can't be arsed to fiddle with any more arcane
#makefile bullshit to get it to not prefix .inc files.
$(BUILD_DIR)/%.inc: %.inc
	@mkdir -p $(dir $@)
	@cp $< $@

$(BUILD_DIR)/%.color.2bpp $(BUILD_DIR)/%.color.gbcpal: %.color.png
	@echo "Building" $<
	@rm -f $@
	@mkdir -p $(dir $(BUILD_DIR)/$*.color.2bpp)
	@mkdir -p $(dir $(BUILD_DIR)/$*.gbcpal)
	@rgbgfx -d 2 -p $(BUILD_DIR)/$*.color.gbcpal -o $(BUILD_DIR)/$*.color.2bpp $<

$(filter-out $(BUILD_DIR)/%.color.2bpp,$(BUILD_DIR)/%.2bpp): %.png
	@echo "Building" $<
	@./rip_scripts/is_nonindexed_png.sh $<
	@rm -f $@
	@mkdir -p $(dir $@)
	@rgbgfx -d 2 -o $@ $<

$(BUILD_DIR)/%.1bpp: %.png
	@echo "Building" $<
	@./rip_scripts/is_nonindexed_png.sh $<
	@rm -f $@
	@mkdir -p $(dir $@)
	@rgbgfx -d 1 -o $@ $<

$(BUILD_DIR)/%.pcm: %.wav
	@rm -f $@
	@mkdir -p $(dir $@)
	@$(PYTHON) rip_scripts/pcm.py pcm $<

$(OBJS_MESSAGE): $(SRC_MESSAGE)
	@rm -f $@
	@$(PYTHON) rip_scripts/mainscript_text.py make_tbl /dev/null $(SRC_MESSAGE) $(INT_MESSAGE) --language="English" --metrics="components/mainscript/font.tffont.csv"
	@rgbasm -o $@ $(INT_MESSAGE)

$(BUILD_DIR)/%.stringtbl: %.csv
	@rm -f $@
	mkdir -p $(dir $@)
	@$(PYTHON) rip_scripts/stringtable_text.py make_tbl /dev/null --language="English"

$(BUILD_DIR)/%.stringidx: %.csv
	@rm -f $@
	@mkdir -p $(dir $@)
	@$(PYTHON) rip_scripts/stringtable_text.py make_tbl /dev/null --language="English"

$(BUILD_DIR)/%.stringblk: %.csv
	@rm -f $@
	@mkdir -p $(dir $@)
	@$(PYTHON) rip_scripts/stringtable_text.py make_tbl /dev/null --language="English"

$(BUILD_DIR)/%.tmap: %.csv
	@rm -f $@
	@mkdir -p $(dir $@)
	@$(PYTHON) rip_scripts/rip_tilemaps.py make_maps $(BASEROM_POWER) $<

$(BUILD_DIR)/%.sprite.bin: %.sprite.csv
	@rm -f $@
	@mkdir -p $(dir $@)
	@$(PYTHON) rip_scripts/metasprite.py make_spritebin $<
   
$(BUILD_DIR)/%.atf: %.sgbattr.csv
	@rm -f $@
	@mkdir -p $(dir $@)
	@$(PYTHON) rip_scripts/rip_sgb_attrfile.py make_atf $< $@
   
$(BUILD_DIR)/%.metrics.bin: %.tffont.csv
	@rm -f $@
	@mkdir -p $(dir $@)
	@$(PYTHON) rip_scripts/tffontasm.py $< $@

# Shoutout to SimpleFlips
$(ROMS_POWER:.gbc=.ips): $(BASEROM_POWER) $(ROMS_POWER)
	flips --create --ips $^ $@

$(ROMS_SPEED:.gbc=.ips): $(BASEROM_SPEED) $(ROMS_SPEED)
	flips --create --ips $^ $@

DEPENDENCY_SCAN_EXIT_STATUS := $(shell $(PYTHON) rip_scripts/scan_includes.py $(OBJS_RGBASM:.o=.asm) > dependencies.d; echo $$?)
ifneq ($(DEPENDENCY_SCAN_EXIT_STATUS), 0)
$(error Dependency scan failed)
endif
include dependencies.d
