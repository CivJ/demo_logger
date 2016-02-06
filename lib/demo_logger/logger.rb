require 'logger'

module DemoLogger
  class Logger < Logger
    attr_accessor :log_file
    # TODO: option for file.sync
    # @param  config [Hash] config options
    # @option config [Symbol] :level
    # @option config [String] :path defaults to File.join(Dir.pwd, 'logger.log')
    # @option config [Boolean] :stdout
    def initialize(config = {})
      log_file_path = config[:path] || File.join(Dir.pwd, 'logger.log')
      @log_file = File.open(File.join(File.expand_path(log_file_path)), 'a')
      super(@log_file)

      self.level = config[:level] || Logger::WARN
    end
  end
end
