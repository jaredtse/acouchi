require "robotium-bridge/build"
require "robotium-bridge/solo"
require "robotium-bridge/test_runner"

def setup
  configuration = {
    :target_package => "com.robotiumbridge.sample",
    :activity       => "com.robotiumbridge.sample.StartupActivity",
    :project_path   => File.expand_path(File.join(File.dirname(__FILE__), "RobotiumBridgeSample")),
    :apk            => "RobotiumBridgeSample-debug.apk",
  }
  RobotiumBridge::Builder.build(configuration)
  @test_runner = RobotiumBridge::TestRunner.new(configuration[:target_package])
  @test_runner.start

  at_exit do
    @test_runner.stop
  end
end

def test_add_new_note
  RobotiumBridge::Solo.enter_text(0, "hello")
  sleep 1
end

def test_delete_note
  RobotiumBridge::Solo.clear_edit_text(0)
  RobotiumBridge::Solo.enter_text(0, "spelling eror")
  sleep 1
  RobotiumBridge::Solo.clear_edit_text(0)
end

setup
test_add_new_note
test_delete_note
