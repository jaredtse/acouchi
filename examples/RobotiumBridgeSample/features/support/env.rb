require "robotium-bridge"
require "robotium-bridge/cucumber"

configuration = RobotiumBridge::Configuration.from_json(File.read("robotium_bridge_configuration.json"))
RobotiumBridge::Cucumber.prepare(configuration)

def page
  RobotiumBridge::Cucumber.page
end
