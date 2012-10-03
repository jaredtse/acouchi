require "childprocess"

module Acouchi
  class TestRunner
    def initialize configuration
      @configuration = configuration
    end

    def start
      system "adb forward tcp:7103 tcp:7103"
      @test_runner_process = ChildProcess.build("adb", "shell", "am", "instrument", "-w", "#{@configuration.target_package}/android.test.InstrumentationTestRunner")
      @test_runner_process.start

      while ready? == false
        sleep 0.1
      end
    end

    def stop
      HTTParty.get("http://127.0.0.1:7103/finish") rescue nil
      begin
        @test_runner_process.poll_for_exit 10
      rescue ChildProcess::TimeoutError
        @test_runner_process.stop
      end
    end

    private
      def ready?
        HTTParty.get("http://127.0.0.1:7103/").body == "Acouchi" rescue false
      end
  end
end
