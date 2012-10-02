require "robotium-bridge/apk_modifier"
require "fileutils"

module RobotiumBridge
  ROBOTIUM_SOURCE_PATH = File.expand_path(File.join(File.dirname(__FILE__), "../../src/com/robotiumbridge"))

  class Builder
    def self.build configuration
      copy_over_robotium_jar configuration[:project_path]
      copy_over_source_files configuration[:target_package], configuration[:project_path], configuration[:activity]

      build_apk(configuration[:project_path])

      apk_path = File.join(configuration[:project_path], "bin", configuration[:apk])
      modify_manifest(configuration[:target_package], configuration[:apk], apk_path)
      install_apk(configuration[:target_package], apk_path)
    end

    def self.copy_over_robotium_jar project_path
      robotium_jar = File.expand_path(Dir.glob(File.join(File.dirname(__FILE__), "../../jars/*robotium*.jar")).first)
      FileUtils.mkdir_p "#{project_path}/libs"
      FileUtils.cp robotium_jar, "#{project_path}/libs/"
    end

    def self.copy_over_source_files target_package, project_path, activity
      destination_source_path = "#{project_path}/src/com/robotiumbridge"
      FileUtils.cp "#{ROBOTIUM_SOURCE_PATH}/TestCase.java", destination_source_path
      FileUtils.cp "#{ROBOTIUM_SOURCE_PATH}/RobotiumBridge.java", destination_source_path
      FileUtils.cp "#{ROBOTIUM_SOURCE_PATH}/NanoHTTPD.java", destination_source_path

      test_case_rb_path = "#{destination_source_path}/TestCase.java"
      test_case_rb = File.read(test_case_rb_path).gsub("ACTIVITY_UNDER_TEST", activity)
      File.open(test_case_rb_path, "w") do |file|
        file.write(test_case_rb)
      end
    end

    def self.modify_manifest package, apk, apk_path
      ApkModifier.new(apk_path).modify_manifest do |original|
        require "nokogiri"
        document = Nokogiri::XML(original)
        manifest = document.xpath("//manifest").first

        instrumentation = Nokogiri::XML::Node.new("instrumentation", document)
        instrumentation["android:name"] = "android.test.InstrumentationTestRunner"
        instrumentation["android:targetPackage"] = package
        manifest.add_child(instrumentation)

        uses_permission = Nokogiri::XML::Node.new("uses-permission", document)
        uses_permission["android:name"] = "android.permission.INTERNET"
        manifest.add_child(uses_permission)

        application = document.xpath("//application").first
        uses_library = Nokogiri::XML::Node.new("uses-library", document)
        uses_library["android:name"] = "android.test.runner"
        application.add_child(uses_library)

        document.to_xml
      end
    end

    def self.build_apk project_path
      Dir.chdir project_path do
        puts project_path
        system "ant clean"
        system "ant debug"
      end
    end

    def self.install_apk target_package, apk_path
      system "adb uninstall #{target_package}"
      system "adb install #{apk_path}"
    end
  end
end
