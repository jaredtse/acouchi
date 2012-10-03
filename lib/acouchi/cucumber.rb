module Acouchi
  module Cucumber
    def self.page
      @page
    end

    def self.prepare configuration
      @test_runner = TestRunner.new(configuration)
      @test_runner.start
      @page = Solo.new
      at_exit do
        @test_runner.stop
      end
    end
  end
end
