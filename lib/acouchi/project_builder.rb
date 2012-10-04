require "fileutils"
require "childprocess"

module Acouchi
  JARS_PATH = File.expand_path(File.join(File.dirname(__FILE__), "../../jars"))
  ROBOTIUM_SOURCE_PATH = File.expand_path(File.join(File.dirname(__FILE__), "../../src/com/acouchi"))

  class ProjectBuilder
    def initialize configuration
      @configuration = configuration
    end

    def configuration
      @configuration
    end

    def build
      temporarily_copy_over_source_files do
        build_apk
      end

      apk_path = File.join(configuration.project_path, "bin", configuration.apk)
      modify_manifest(apk_path)
      install_apk(apk_path)
    end

    def temporarily_copy_over_source_files
      destination_libs_path = "#{configuration.project_path}/libs"
      destination_source_path = "#{configuration.project_path}/src/com/acouchi"

      FileUtils.mkdir_p destination_libs_path
      Dir.glob(File.join(JARS_PATH, "*.jar")).each do |jar|
        FileUtils.cp jar, destination_libs_path
      end

      FileUtils.mkdir_p destination_source_path
      Dir.glob(File.join(ROBOTIUM_SOURCE_PATH, "*.java")).each do |java_file|
        FileUtils.cp java_file, destination_source_path
        file_path = File.join(destination_source_path, File.basename(java_file))
        file_content = File.read(file_path).gsub("ACTIVITY_UNDER_TEST", configuration.activity)
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

    def modify_manifest apk_path
      ApkModifier.new(apk_path).modify_manifest do |original|
        require "nokogiri"
        document = Nokogiri::XML(original)
        manifest = document.xpath("//manifest").first

        instrumentation = Nokogiri::XML::Node.new("instrumentation", document)
        instrumentation["android:name"] = "android.test.InstrumentationTestRunner"
        instrumentation["android:targetPackage"] = configuration.target_package
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

    def build_apk
      Dir.chdir configuration.project_path do
        ProcessLauncher.new("ant", "clean", "debug").start_and_crash_if_process_fails
      end
    end

    def install_apk apk_path
      ProcessLauncher.new("adb", "uninstall", configuration.target_package).start
      ProcessLauncher.new("adb", "install", apk_path).start_and_crash_if_process_fails
    end
  end
end
