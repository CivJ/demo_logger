require 'logger'

module DemoLogger
  class StdoutLogger < Logger
    # @param level [String] log level for STDOUT
    def initialize(level)
      super(STDOUT)
      self.level = level || Logger::WARN
    end

    # Don't close STDOUT.
    def close
    end
  end
end
