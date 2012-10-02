require "tmpdir"
require "securerandom"

module RobotiumBridge
  class ApkModifier
    def initialize apk
      @apk = apk
      @apk_tool = `which apktool`.strip
      @output_path = "#{Dir.tmpdir}/#{SecureRandom.uuid}/"

      if @apk_tool.empty?
        puts "Couldn't find a valid apktool. Please install apktool from http://code.google.com/p/android-apktool/"
        exit
      end
    end

    def modify_manifest
      if block_given?
        decompile_apk
        manifest_path = File.join(@output_path, "AndroidManifest.xml")
        new_manifest = yield(File.read(manifest_path))
        File.open(manifest_path, "w") {|f| f.write(new_manifest)}
        compile_apk
        sign_apk_in_debug_mode
        overwrite_original_apk
      else
        throw "modify_manifest takes a block"
      end
    end

    private
      def apktool command
        puts "#{@apk_tool} #{command}"
        system "#{@apk_tool} #{command}"
      end

      def decompile_apk
        apktool "d #{@apk} #{@output_path}"
      end

      def compile_apk
        apktool "b #{@output_path}"
      end

      def sign_apk_in_debug_mode
        @new_apk = File.join(@output_path, "dist", File.basename(@apk))
        system "jarsigner -keystore ~/.android/debug.keystore -storepass android -keypass android #{@new_apk} androiddebugkey"
      end

      def overwrite_original_apk
       FileUtils.mv(@new_apk, @apk)
      end
  end
end
