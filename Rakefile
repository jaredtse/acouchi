# desc "compile RobotiumBridge"
# task :default do
#   sh "ant clean"
#   sh "ant debug"
#   sh "adb uninstall com.jayway.test"
#   sh "adb install bin/RobotiumBridge-debug.apk"
# e
desc "compile RobotiumBridge"
task :default do
  class_path = [
    "./",
    "~/android-sdk-macosx/platforms/android-16/android.jar",
    "./libs/robotium-solo-3.4.1.jar",
  ].map{|p| File.expand_path(p)}.join(File::PATH_SEPARATOR)

  sh "javac RobotiumBridge.java -classpath #{class_path}"
end
