require 'logger'
require 'clean_config' # I wrote this open-source library

module DemoLogger
  class Logger < Logger
    include CleanConfig::Configurable

    attr_accessor :log_file
    # TODO: option for file.sync
    # @param  config [Hash] config options
    # @option config [Symbol] :level
    # @option config [String] :path defaults to File.join(Dir.pwd, 'logger.log')
    # @option config [Boolean] :stdout
    def initialize(config = {})
      config.merge!(CleanConfig::Configuration.instance[:demo_logger])
      puts "config: #{config}"
      log_file_path = config[:path] || File.join(Dir.pwd, 'logger.log')
      @log_file = File.open(File.join(File.expand_path(log_file_path)), 'a')

      super(@log_file)

      level = nil
      if config[:level]
        level = Kernel.const_get("Logger::#{config[:level].upcase}")
      end
      self.level = level || Logger::WARN
    end
  end
end
