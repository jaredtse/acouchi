desc "compile RobotiumBridge"
task :default do
  sh "ant clean"
  sh "ant debug"
  sh "adb uninstall com.android.robotiumbridge"
  sh "adb install bin/RobotiumBridge-debug.apk"
  sh "adb shell am start com.android.robotiumbridge/.RobotiumBridgeActivity"
  sh "adb forward tcp:7102 tcp:7102"
end
