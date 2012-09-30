PACKAGE = "com.example.android.notepad"
PROJECT_PATH = File.expand_path "../NotePad"
APK_PATH = File.expand_path "../NotePad/bin/NotesList-debug.apk"
ROBOTIUM_SOURCE_PATH = File.expand_path(File.join(File.dirname(__FILE__), "src/com/robotiumbridge"))

require "fileutils"

task :default do
  FileUtils.rm_rf "#{PROJECT_PATH}/src/com/robotiumbridge"
  FileUtils.cp_r ROBOTIUM_SOURCE_PATH, "#{PROJECT_PATH}/src/com/robotiumbridge"

  Dir.chdir PROJECT_PATH do
    sh "ant clean"
    sh "ant debug"

    sh "adb uninstall #{PACKAGE}"
    sh "adb install #{APK_PATH}"
    sh "adb forward tcp:7103 tcp:7103"
    sh "adb shell am instrument -w #{PACKAGE}/android.test.InstrumentationTestRunner"
  end
end
