module RobotiumBridge
  require "fileutils"
  APK_TOOL = "apktool"
  ROBOTIUM_SOURCE_PATH = File.expand_path(File.join(File.dirname(__FILE__), "../../src/com/robotiumbridge"))

  class Builder
    def self.launch_test_runner(configuration)
      @test_runner_thread = Thread.new {
        system "adb forward tcp:7103 tcp:7103"
        system "adb shell am instrument -w #{configuration[:target_package]}/android.test.InstrumentationTestRunner"
      }
    end

    def self.kill_test_runner
      if @test_runner_thread
        Thread.kill(@test_runner_thread)
      end
    end

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
      temp_apk_path = File.expand_path(File.join(File.dirname(__FILE__), "temp_apk_path"))
      manifest_path = File.join(temp_apk_path, "AndroidManifest.xml")
      new_apk_path = File.join(temp_apk_path, "dist", apk)

      Builder.decompile_apk(apk_path, temp_apk_path)
      Builder.apply_required_manifest_changes(manifest_path, package)
      Builder.recompile_apk(temp_apk_path)
      Builder.sign_apk_in_debug_mode(new_apk_path)

      FileUtils.mv File.join(temp_apk_path, "dist", apk), apk_path
      FileUtils.rm_rf temp_apk_path
    end

    def self.build_apk project_path
      Dir.chdir project_path do
        puts project_path
        system "ant clean"
        system "ant debug"
      end
    end

    def self.decompile_apk(apk_path, output_path)
      system "#{APK_TOOL} d #{apk_path} #{output_path}"
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
      system "#{APK_TOOL} b #{directory}"
    end

    def self.sign_apk_in_debug_mode path
      system "jarsigner -keystore ~/.android/debug.keystore -storepass android -keypass android #{path} androiddebugkey"
    end

    def self.install_apk target_package, apk_path
      system "adb uninstall #{target_package}"
      system "adb install #{apk_path}"
    end
  end
end
