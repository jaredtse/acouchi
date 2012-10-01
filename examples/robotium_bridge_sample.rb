require_relative "../lib/solo"
require_relative "../lib/build"

def setup
  configuration = {
    :target_package => "com.robotiumbridge.sample",
    :activity       => "com.robotiumbridge.sample.StartupActivity",
    :project_path   => File.expand_path(File.join(File.dirname(__FILE__), "RobotiumBridgeSample")),
    :apk            => "RobotiumBridgeSample-debug.apk",
  }
  Builder.build(configuration)
  Builder.launch_test_runner(configuration)
  Solo.wait_until_ready

  at_exit do
    Solo.kill_server
    Builder.kill_test_runner
  end
end

def test_add_new_note
  Solo.enter_text(0, "hello")
  sleep 1
end

def test_delete_note
  Solo.clear_edit_text(0)
  Solo.enter_text(0, "spelling eror")
  sleep 1
  Solo.clear_edit_text(0)
end

setup
test_add_new_note
test_delete_note
