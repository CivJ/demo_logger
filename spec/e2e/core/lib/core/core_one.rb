require 'demo_logger'
require 'clean_config'

module Core
  class CoreOne
    include CleanConfig::Configurable
    attr_reader :logger

    def initialize
      @logger = DemoLogger::MultiLogger.new
    end
  end
end
