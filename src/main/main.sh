#-----------Dynamic Installer Configs-----------#
setdefault   overwrite_symlinks   off
setdefault   dalvik_memory        800M
setdefault   framework_res        "$addons/framework-res.apk"
setdefault   permissions          "0:0:0755:0644"
#-----------------------------------------------#
#Your script starts here:

ui_print "Hello world!"



# Example of using dynamic_apktool to decompile, patch, and recompile an APK
REMAKE="
    .locals 1
    const/4 v0, 0x1
    return v0
"
if exist "$addons/Test.apk"; then
   # ui_print <type> "Message"
   #   info = For informational messages
   #   error = For error messages
   #   warn = For warning messages
   ui_print info "Decompiling Test.apk"

   # By default dynamic_apktool do not decompile resources, so we use -allow-res if we need them
   dynamic_apktool -allow-res -decompile "$addons/Test.apk" -o "$TMP/Test"

   ui_print info "Patching Test.apk"
   if smali_kit -check -method "TestMethod" -remake "$REMAKE" -name Test.smali -dir "$TMP/Test"; then
      ui_print info "Recompiling Test.apk"
      if dynamic_apktool -preserve-signature -recompile "$TMP/Test" -o "$project/src/OUT/NewTest.apk"; then
         ui_print info "Success"
      else
         abort error "Failed"
      fi
   else
      abort warn "Patching failed"
   fi
fi