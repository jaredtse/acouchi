require "robotium-bridge"

def setup
  configuration = {
    :target_package => "com.robotiumbridge.sample",
    :activity       => "com.robotiumbridge.sample.StartupActivity",
    :project_path   => File.expand_path(File.join(File.dirname(__FILE__), "RobotiumBridgeSample")),
    :apk            => "RobotiumBridgeSample-debug.apk",
  }
  RobotiumBridge::ProjectBuilder.build(configuration)
  @test_runner = RobotiumBridge::TestRunner.new(configuration[:target_package])
  @test_runner.start
  @solo = RobotiumBridge::Solo.new

  at_exit do
    @test_runner.stop
  end
end

def test_add_new_note
  @solo.enter_text(0, "hello")
  puts @solo.has_text? "hello"
  puts @solo.has_text? "monkeys"
  sleep 1
end

def test_delete_note
  @solo.clear_edit_text(0)
  @solo.enter_text(0, "spelling eror")
  sleep 1
  @solo.clear_edit_text(0)
end

setup
# reinstall_app
test_add_new_note
# reinstall_app
test_delete_note
