### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=PawKernel 1.0 SuSFS (Stable, A16 KSU-Next) by dusklte
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=1
device.name1=beyond0lte
device.name2=beyond1lte
device.name3=beyond2lte
device.name4=beyondx
supported.versions=14 - 16
#supported.patchlevels=2025-09-05
#supported.vendorpatchlevels=2023-03-01
'; } # end properties


### AnyKernel install
## boot files attributes
boot_attributes() {
set_perm_recursive 0 0 755 644 $RAMDISK/*;
set_perm_recursive 0 0 750 750 $RAMDISK/init* $RAMDISK/sbin;
} # end attributes

# boot shell variables
BLOCK=/dev/block/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

# boot install (kernel-only: replaces only the Image, no ramdisk patches)
dump_boot;
write_boot;
## end boot install

## dtb install (GPU DVFS tuning) - separate dtb partition on beyond2lte
ui_print " " "Flashing dtb (GPU DVFS tuning)...";
flash_generic dtb;
## end dtb install