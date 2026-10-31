### AnyKernel3 Ramdisk Mod Script
## ginkgo / willow — KernelSU-Next legacy + SUSFS

properties() { '
kernel.string=Redmi Note 8 (ginkgo) KSU-Next v3.1.0-legacy-susfs + SUSFS kernel
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=ginkgo
device.name2=willow
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; }

## boot shell variables
BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

. tools/ak3-core.sh;

split_boot;
flash_boot;
## end boot install

## Drop the matching ksud so the kernel can exec it at post-fs-data.
## Without it the manager APK reports "signature not found".
if [ -d /data/adb ]; then
  if cp -f "$AKHOME/ksud" /data/adb/ksud 2>/dev/null; then
    chmod 0755 /data/adb/ksud
    ui_print "  -> ksud installed to /data/adb/ksud"
  else
    ui_print "  -> ksud copy failed (is /data encrypted?)"
  fi
fi