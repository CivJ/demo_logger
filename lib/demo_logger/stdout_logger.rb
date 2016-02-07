require 'logger'

module DemoLogger
  class StdoutLogger < Logger
    # @param level [String] log level for STDOUT
    def initialize(level)
      super(STDOUT)
      self.level = level
    end
  end
end
