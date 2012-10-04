module Acouchi
  class ProcessLauncher
    def initialize(*arguments)
      @arguments = arguments
      @process = ChildProcess.build(*@arguments)
      @process.io.inherit!
    end

    def start
      @process.start
      @process.wait
    end

    def start_and_crash_if_process_fails
      start
      if @process.crashed?
        raise "A process exited with a non-zero exit code.\nThe command executed was \"#{@arguments.join(" ")}\""
      end
    end
  end
end
