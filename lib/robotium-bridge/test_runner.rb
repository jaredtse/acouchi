module RobotiumBridge
  class TestRunner
    def initialize package
      @package = package
    end

    def start
      @test_runner_thread = Thread.new {
        system "adb forward tcp:7103 tcp:7103"
        system "adb shell am instrument -w #{@package}/android.test.InstrumentationTestRunner"
      }
      while ready? == false
        sleep 0.1
      end
    end

    def stop
      Thread.kill(@test_runner_thread) if @test_runner_thread
      HTTParty.get("http://127.0.0.1:7103/finish") rescue nil
    end

    private
      def ready?
        HTTParty.get("http://127.0.0.1:7103/").body == "RobotiumBridge" rescue false
      end
  end
end
