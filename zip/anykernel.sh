# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=IMMENSITY - KERNEL by @UtsavTheCunt
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=potter
device.name2=potter_retail
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

## AnyKernel install
dump_boot;

# begin ramdisk changes

rm $ramdisk/init.optimus.rc
rm $ramdisk/init.extended_kernel.rc
# Set executable

chmod 755 $ramdisk/init.immensity.sh

insert_line init.rc "init.immensity.rc" after "import /init.usb.configfs.rc" "import /init.immensity.rc";

# end ramdisk changes

write_boot;

## end install

