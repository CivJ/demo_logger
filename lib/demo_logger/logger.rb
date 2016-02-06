require 'logger'

module DemoLogger
  class Logger < Logger

    # TODO: option for file.sync
    # @param  config [Hash] config options
    # @option config [String] :filename
    # @option config [Symbol] :level
    # @option config [String] :path
    # @option config [Boolean] :stdout
    def initialize(config = {})
      log_file_name = config[:filename] || 'logger.log'
      log_file_path = config[:path] || '.'
      log_file = File.open(File.join(File.expand_path(log_file_path), log_file_name), 'a')
      super(log_file)

      self.level = config[:level] || Logger::DEBUG
    end
  end
end
