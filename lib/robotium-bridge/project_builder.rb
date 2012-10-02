require "robotium-bridge/apk_modifier"
require "fileutils"

module RobotiumBridge
  JARS_PATH = File.expand_path(File.join(File.dirname(__FILE__), "../../jars"))
  ROBOTIUM_SOURCE_PATH = File.expand_path(File.join(File.dirname(__FILE__), "../../src/com/robotiumbridge"))

  class ProjectBuilder
    def self.build configuration
      temporarily_copy_over_source_files configuration[:target_package], configuration[:project_path], configuration[:activity] do
        build_apk(configuration[:project_path])
      end

      apk_path = File.join(configuration[:project_path], "bin", configuration[:apk])
      modify_manifest(configuration[:target_package], configuration[:apk], apk_path)
      install_apk(configuration[:target_package], apk_path)
    end


    def self.temporarily_copy_over_source_files target_package, project_path, activity
      destination_libs_path = "#{project_path}/libs"
      destination_source_path = "#{project_path}/src/com/robotiumbridge"

      FileUtils.mkdir_p destination_libs_path
      Dir.glob(File.join(JARS_PATH, "*.jar")).each do |jar|
        FileUtils.cp jar, destination_libs_path
      end

      FileUtils.mkdir_p destination_source_path
      Dir.glob(File.join(ROBOTIUM_SOURCE_PATH, "*.java")).each do |java_file|
        FileUtils.cp java_file, destination_source_path
        file_path = File.join(destination_source_path, File.basename(java_file))
        file_content = File.read(file_path).gsub("ACTIVITY_UNDER_TEST", activity)
        File.open(file_path, "w") { |file| file.write(file_content) }
      end

      yield

      Dir.glob(File.join(JARS_PATH, "*.jar")).each do |jar|
        FileUtils.rm File.join(destination_libs_path, File.basename(jar))
      end

      Dir.glob(File.join(ROBOTIUM_SOURCE_PATH, "*.java")).each do |java_file|
        FileUtils.rm File.join(destination_source_path, File.basename(java_file))
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
