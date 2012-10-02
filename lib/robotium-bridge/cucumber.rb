module RobotiumBridge
  module Cucumber
    def self.page
      @page
    end

    def self.prepare configuration
      @test_runner = RobotiumBridge::TestRunner.new(configuration)
      @test_runner.start
      @page = RobotiumBridge::Solo.new
      at_exit do
        @test_runner.stop
      end
    end
  end
end
