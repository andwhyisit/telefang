# coding=utf-8

import argparse, io, os.path, csv
from FangTools.gb import PTR, CHARA, flat, banked
from FangTools.rgbds import format_hex, format_sectionaddr_rom
from FangTools.fs import install_path

ATTRIBMODE_ENUM = {
    0x00: "ConfigAttribs",
    0x01: "LocalAttribs",
    0x02: "ConfigPalette"
}

ATTRIBMODE_ENUM_REV = {
    "ConfigAttribs": 0x00,
    "LocalAttribs": 0x01,
    "ConfigPalette": 0x02
}

def rip_msprite(rom, offset = None):
    """Given a ROM and an offset, decode the metasprite data and return an array
    of sprite configuration data."""
    
    cloc = rom.tell()
    if offset is not None:
        rom.seek(offset)
    
    msprite = []
    
    msprite_len = CHARA.unpack(rom.read(1))[0]
    
    for i in range(0, msprite_len):
        oam_spr = {}
        
        oam_spr["y"] = CHARA.unpack(rom.read(1))[0]
        oam_spr["x"] = CHARA.unpack(rom.read(1))[0]
        oam_spr["tile"] = CHARA.unpack(rom.read(1))[0]
        oam_spr["attrib_mode"] = CHARA.unpack(rom.read(1))[0]
        oam_spr["attribs"] = CHARA.unpack(rom.read(1))[0]
        
        oam_spr["attrib_mode"] = ATTRIBMODE_ENUM[oam_spr["attrib_mode"]]
        
        msprite.append(oam_spr)
    
    rom.seek(cloc)
    return msprite

def rip_msprite_table(rom, offset = None):
    """Given a ROM and an offset, rip a metatable of metasprites. Ripped data
    will be returned as an array of ASM and a dict listing files to save."""
    
    cloc = rom.tell()
    if offset is not None:
        rom.seek(offset)
    else:
        offset = cloc
    
    table_ptr, bank = banked(offset)
    
    ptrs = []
    end = 0x7FFF
    cur = table_ptr
    
    table_ptr_list = []
    ripped_sprites = {}
    
    while cur < end:
        offset_ptr = PTR.unpack(rom.read(2))[0]
        
        cur += 2
        end = min(offset_ptr, end)
        
        if offset_ptr not in list(ripped_sprites.keys()):
            try:
                ripped_sprites[offset_ptr] = rip_msprite(rom, flat(bank, offset_ptr))
            except KeyError:
                #If a metasprite points at undecipherable data, assume it's a
                #dummy pointer and don't generate a metasprite for it, since
                #it's clearly run off the end of the table.
                
                ripped_sprites[offset_ptr] = []
        
        table_ptr_list.append(offset_ptr)
    
    #Now that we have the tables and their data, generate the ASM for it...
    data_asmsrc = ""
    table_asmsrc = ""
    files = {}
    
    table_symbol = "MetaSprite_" + "{0:x}".format(bank)
    
    table_asmsrc += "SECTION \"" + table_symbol + "\", ROMX[$" + "{0:x}".format(table_ptr) + "], BANK[$" + "{0:x}".format(bank) + "]\n"
    table_asmsrc += table_symbol + "::\n"
    
    sorted_ptrs = list(ripped_sprites.keys())
    sorted_ptrs.sort()
    last_ptrkey_end = 0x0000
    
    for ptrkey in sorted_ptrs:
        val = ripped_sprites[ptrkey]
        
        symbol = table_symbol + "_" + "{0:x}".format(ptrkey)
        file = "gfx/unknown/metasprite_" + "{0:x}".format(bank) + "/" + "{0:x}".format(ptrkey) + ".sprite.csv"
        binfile = "gfx/unknown/metasprite_" + "{0:x}".format(bank) + "/" + "{0:x}".format(ptrkey) + ".sprite.bin"
        
        if last_ptrkey_end != ptrkey:
            data_asmsrc += "SECTION \"" + symbol + "\", ROMX[$" + "{0:x}".format(ptrkey) + "], BANK[$" + "{0:x}".format(bank) + "]\n"
        
        data_asmsrc += symbol + "::\n"
        
        #ASSUMPTION: All 0 size metasprites are dummy pointers
        if len(val) > 0:
            data_asmsrc += "    INCBIN \"" + binfile + "\"\n"
        data_asmsrc += symbol + "_END::\n"
        
        files[file] = "Y,X,Tile Offset,Attribute Mixing,Attributes\n"
        for spritecfg in val:
            files[file] += "{0:x},{1:x},{2:x},{3},{4:x}\n".format(spritecfg['y'], spritecfg['x'], spritecfg['tile'], spritecfg['attrib_mode'], spritecfg['attribs'])
        
        last_ptrkey_end = ptrkey + 1 + len(val) * 5
    
    for ptr in table_ptr_list:
        symbol = table_symbol + "_" + "{0:x}".format(ptr)

        table_asmsrc += "    dw " + symbol + "\n"
    
    asm_src = table_asmsrc + "\n" + data_asmsrc
    
    rom.seek(cloc)
    return (asm_src, files)

def rip_msprite_mtable(rom, offset = 0x094D, count = 9):
    """Rip an entire ROM's metasprite data."""
    cloc = rom.tell()
    rom.seek(offset)

    #The metasprite metatable is oddly organized here.
    #Banks in one place, pointers in the other.
    banks = []
    ptrs = []

    for i in range(0, count):
        banks.append(CHARA.unpack(rom.read(1))[0])

    for i in range(0, count):
        ptrs.append(PTR.unpack(rom.read(2))[0])

    asmsrc = "SECTION \"MetaSprite metatable\", " + format_sectionaddr_rom(offset) + "\n"
    asmsrc += "MetaspriteBankMetatable::\n"

    for bank in banks:
        asmsrc += "    db BANK(MetaSprite_" + "{0:x}".format(bank) + ")\n"

    asmsrc += "MetaspriteAddressMetatable::\n"

    for bank, ptr in zip(banks, ptrs):
        asmsrc += "    dw MetaSprite_" + "{0:x}".format(bank) + "\n"

    asmsrc += "\n"
    
    files = {}
    for bank, ptr in zip(banks, ptrs):
        table_asmsrc, table_files = rip_msprite_table(rom, flat(bank, ptr))
        
        asmsrc += table_asmsrc + "\n"
        files.update(table_files)
    
    return (asmsrc, files)

def extract(args):
    with open(args.filenames[0], 'rb') as rom:
        asmsrc, files = rip_msprite_mtable(rom, args.metatable_loc)
        
        for filename, data in files.items():
            install_path(os.path.dirname(filename))
            
            with io.open(filename, "w+", encoding="utf-8") as spr_csv:
                spr_csv.write(data)
        
        print(asmsrc)

def spritecsv2bin(data):
    """Given an array representation of CSV source data, produce a string
    containing the binary representation of that source data."""
    length_spr = len(data) - 1

    bin = CHARA.pack(length_spr)

    for i in range(0, length_spr):
        bin += CHARA.pack(int(data[i+1][0], 16))
        bin += CHARA.pack(int(data[i+1][1], 16))
        bin += CHARA.pack(int(data[i+1][2], 16))
        bin += CHARA.pack(ATTRIBMODE_ENUM_REV[data[i+1][3]])
        bin += CHARA.pack(int(data[i+1][4], 16))

    return bin

def make_spritebin(args):
    for filename in args.filenames:
        print("Compiling " + filename)
        
        dst_filename = os.path.join("build", os.path.splitext(filename)[0] + ".bin")
        
        with open(filename, 'r') as srcfile:
            csvreader = csv.reader(srcfile)
            rows = []

            for row in csvreader:
                rows.append(row)

            with open(dst_filename, 'wb') as dstfile:
                dstfile.write(spritecsv2bin(rows))

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mode')
    ap.add_argument('--metatable_loc', type=int, default=0x094D)
    ap.add_argument('filenames', type=str, nargs="*")
    args = ap.parse_args()

    method = {
        "extract": extract,
        "make_spritebin": make_spritebin
    }.get(args.mode, None)

    if method == None:
        raise Exception("Unknown conversion method!")

    method(args)

if __name__ == "__main__":
    main()
