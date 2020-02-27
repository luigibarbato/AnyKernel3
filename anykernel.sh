# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=lavender
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

# backup files
if [ ! -f /vendor/bin/init.qcom.post_boot.sh.bkp ]; then
	cp -rpf /vendor/bin/init.qcom.post_boot.sh /vendor/bin/init.qcom.post_boot.sh.bkp;
fi
if [ ! -f /vendor/etc/perf/perfboostsconfig.xml.bkp ]; then
	cp -rpf /vendor/etc/perf/perfboostsconfig.xml /vendor/etc/perf/perfboostsconfig.xml.bkp;
fi

# replace files
cp -rpf $patch/init.qcom.post_boot.sh /vendor/bin/init.qcom.post_boot.sh;
cp -rpf $patch/perfboostsconfig.xml /vendor/etc/perf/perfboostsconfig.xml;
cp -rpf $patch/perf-profile0.conf /vendor/etc/perf/perf-profile0.conf;


# set up permissions
chmod 0644 vendor/etc/perf/perf-profile0.conf;
chmod 0777 /vendor/bin/init.qcom.post_boot.sh;
chmod 0644 /vendor/etc/perf/perfboostsconfig.xml;

## AnyKernel install
dump_boot;

# begin ramdisk changes


# end ramdisk changes

write_boot;
## end install

