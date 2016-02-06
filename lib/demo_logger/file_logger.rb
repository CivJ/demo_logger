require 'logger'
require 'clean_config' # I wrote this open-source library

module DemoLogger
  # TODO: rename to FileLogger
  class FileLogger < Logger
    include CleanConfig::Configurable

    # TODO: #log and #info are the same. How should log map onto logger's api?
    alias_method :log, :info
    alias_method :severe, :fatal
    attr_accessor :log_file

    # @param  config [Hash] config options
    # @option config [String] :file
    # @option config [String] :stdout
    # @option config [String] :email
    def initialize(config = {})
      config.merge!(CleanConfig::Configuration.instance[:demo_logger])
      puts "config: #{config}"
      log_file_path = config[:path] || File.join(Dir.pwd, 'logger.log')
      @log_file = File.open(File.join(File.expand_path(log_file_path)), 'a')

      # We are setting sync = true because of the following line from the spec:
      # "You need to build a framework that will continuously dump the logger output to a file."
      # This sounds like an instruction to avoid buffering, so that's what we're doing.
      @log_file.sync = true
      super(@log_file)

      level = nil
      if config[:level]
        level = Kernel.const_get("Logger::#{config[:level].upcase}")
      end
      self.level = level || FileLogger::WARN
    end
  end
end
