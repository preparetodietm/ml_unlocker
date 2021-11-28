##############
# ML Unlocker 
##############
SKIPUNZIP=1

# Unzip files
ui_print "- Unzipping files..."
sleep 1
unzip -oj "$ZIPFILE" module.prop mlunlocker -d "$TMPDIR" >&2

# Detect xbin folder if exist then create one
ui_print "- Detecting xbin folder if exist..."
sleep 0.5
if [ -d /system/xbin ]; then
  ui_print "✓ xbin folder detected!"
  ui_print "- Creating xbin folder in module..."
  sleep 1
  mkdir -p "$MODPATH"/system/xbin/
else
  ui_print "!xbin folder in system is not exist!"
  ui_print "- Creating xbin folder in module..."
  sleep 1
  mkdir -p "$MODPATH"/system/xbin/
  ui_print "- Mounting system partition..."
  sleep 1
  mount -o remount,rw /
  mount -o remount,rw /system
  remount
  ui_print "- Creating xbin folder in system..."
  sleep 1
  mkdir -p /system/xbin/
  ui_print "- Setting permissions for system xbin folder..."
  sleep 1
  set_perm /system/xbin/ 0 2000 751
  ui_print "- Unmounting system partition..."
  sleep 1
  mount -o remount,ro /
  mount -o remount,ro /system
  sync
fi

# Extract module files
ui_print "- Extracting module files..."
sleep 1
cp -af "$TMPDIR"/module.prop "$MODPATH"/module.prop
cp -af "$TMPDIR"/mlunlocker "$MODPATH"/system/xbin/mlunlocker

# Setting Permissions
ui_print "- Setting permissions..."
sleep 1
set_perm_recursive "$MODPATH" 0 0 0755 0644
set_perm "$MODPATH"/system/xbin/ 0 2000 751
set_perm "$MODPATH"/system/xbin/mlunlocker 0 2000 755

#===============================
# End of customize.sh
# Modified by @preparetodietm
#===============================
