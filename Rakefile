TARGET_PACKAGE = "com.example.android.notepad"

APK = "NotesList-debug.apk"
PROJECT_PATH = File.expand_path "../NotePad"
APK_PATH = File.join(PROJECT_PATH, "bin", APK)
TARGET_PACKAGE = "com.example.android.notepad"
APK_TOOL = File.expand_path(File.join(File.dirname(__FILE__), "apktool"))

ROBOTIUM_SOURCE_PATH = File.expand_path(File.join(File.dirname(__FILE__), "src/com/robotiumbridge"))

require "fileutils"

task :default do
  FileUtils.rm_rf "#{PROJECT_PATH}/src/com/robotiumbridge"
  FileUtils.cp_r ROBOTIUM_SOURCE_PATH, "#{PROJECT_PATH}/src/com/robotiumbridge"

  Helpers.build_apk(PROJECT_PATH)
  modify_manifest
  Helpers.install_apk(TARGET_PACKAGE, APK_PATH)
  Helpers.run_tests(TARGET_PACKAGE)
end

def modify_manifest
  temp_apk_path = File.expand_path(File.join(File.dirname(__FILE__), "temp_apk_path"))
  manifest_path = File.join(temp_apk_path, "AndroidManifest.xml")
  new_apk_path = File.join(temp_apk_path, "dist", APK)

  Helpers.decompile_apk(APK_PATH, temp_apk_path)
  Helpers.apply_required_manifest_changes(manifest_path, TARGET_PACKAGE)
  Helpers.recompile_apk(temp_apk_path)
  Helpers.sign_apk_in_debug_mode(new_apk_path)

  FileUtils.mv File.join(temp_apk_path, "dist", APK), APK_PATH
  FileUtils.rm_rf temp_apk_path
end

class Helpers
  def self.build_apk project_path
    Dir.chdir project_path do
      sh "ant clean"
      sh "ant debug"
    end
  end

  def self.decompile_apk(apk_path, output_path)
    sh "#{APK_TOOL} d #{apk_path} #{output_path}"
  end

  def self.apply_required_manifest_changes(manifest_path, target_package)
    require "nokogiri"
    document = Nokogiri::XML(File.read(manifest_path))
    manifest = document.xpath("//manifest").first

    instrumentation = Nokogiri::XML::Node.new("instrumentation", document)
    instrumentation["android:name"] = "android.test.InstrumentationTestRunner"
    instrumentation["android:targetPackage"] = target_package
    manifest.add_child(instrumentation)

    uses_permission = Nokogiri::XML::Node.new("uses-permission", document)
    uses_permission["android:name"] = "android.permission.INTERNET"
    manifest.add_child(uses_permission)

    application = document.xpath("//application").first
    uses_library = Nokogiri::XML::Node.new("uses-library", document)
    uses_library["android:name"] = "android.test.runner"
    application.add_child(uses_library)

    File.open(manifest_path, "w") {|f| f.write(document.to_xml)}
  end

  def self.recompile_apk directory
    sh "#{APK_TOOL} b #{directory}"
  end

  def self.sign_apk_in_debug_mode path
    sh "jarsigner -keystore ~/.android/debug.keystore -storepass android -keypass android #{path} androiddebugkey"
  end

  def self.install_apk target_package, apk_path
    sh "adb uninstall #{target_package}"
    sh "adb install #{apk_path}"
  end

  def self.run_tests target_package
    sh "adb forward tcp:7103 tcp:7103"
    sh "adb shell am instrument -w #{target_package}/android.test.InstrumentationTestRunner"
  end
end
