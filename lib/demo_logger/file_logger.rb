require 'logger'
require 'clean_config'
require 'fileutils'

module DemoLogger
  class FileLogger < Logger
    attr_accessor :log_file

    # @param level [String] log level for files
    def initialize(level)
      log_file_dir = File.expand_path(File.join(Dir.pwd, 'log'))
      FileUtils.mkdir_p(log_file_dir)
      log_file_path = File.join(log_file_dir, 'logger.log')
      @log_file = File.open(File.join(log_file_path), 'a')

      # We are setting sync = true because of the following line from the spec:
      # "You need to build a framework that will continuously dump the logger output to a file."
      # This sounds like an instruction to avoid buffering, so that's what we're doing.
      # Obvious performance hit.
      @log_file.sync = true
      super(@log_file)
      self.level = level || Logger::WARN
    end
  end
end
