###################
# ML Unlocker v2.0 
###################
SKIPUNZIP=1

# Note
ui_print " Take Note: ML Unlocker works only if you activate"
sleep 0.5
ui_print " in Termux/Terminal Emulator. For more info, execute"
sleep 0.5
ui_print " ๐ฌ๐ฎ -๐ ๐ฆ๐ฅ๐ฎ๐ง๐ฅ๐จ๐๐ค๐๐ซ or ๐ฌ๐ฎ first then ๐ฆ๐ฅ๐ฎ๐ง๐ฅ๐จ๐๐ค๐๐ซ"
sleep 10

# Unzip files
ui_print "- Unzipping files..."
sleep 1
unzip -oj "$ZIPFILE" module.prop mlunlocker -d "$TMPDIR" >&2

# Detect system xbin folder if exist and create path in MODPATH
ui_print "- Detecting xbin folder in system..."
sleep 1
if [ -d /system/xbin ]; then
  ui_print "โxbin folder detected!"
  ui_print "- Creating xbin folder in MODPATH"
  mkdir -p "$MODPATH"/system/xbin
else
  ui_print "โxbin folder not detected!"
  # Create bin path in MODPATH
  ui_print "- Creating bin folder in MODPATH"
  mkdir -p "$MODPATH"/system/bin
fi

# Extract module files
ui_print "- Extracting module files..."
sleep 1
cp -af "$TMPDIR"/module.prop "$MODPATH"/module.prop
if [ -d /system/xbin ]; then
  cp -af "$TMPDIR"/mlunlocker "$MODPATH"/system/xbin/mlunlocker
else
  cp -af "$TMPDIR"/mlunlocker "$MODPATH"/system/bin/mlunlocker
fi

# Setting Permissions
ui_print "- Setting permissions..."
sleep 1
set_perm_recursive "$MODPATH" 0 0 0755 0644
set_perm "$MODPATH"/system/bin/ 0 2000 751
set_perm "$MODPATH"/system/xbin/ 0 2000 751
set_perm "$MODPATH"/system/bin/mlunlocker 0 2000 755
set_perm "$MODPATH"/system/xbin/mlunlocker 0 2000 755

#===============================
# End of customize.sh
# Modified by @preparetodietm
#===============================
