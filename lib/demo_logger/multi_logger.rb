require 'logger'
require 'clean_config'
require_relative 'file_logger'
require_relative 'stdout_logger'
module DemoLogger
  class MultiLogger
    include CleanConfig::Configurable
    attr_reader :logs

    # TODO: :log and :info are the same. How should #log map onto logger's api?
    LOGGER_CONST_MAP = {
      debug: Logger::DEBUG, # 0
      info: Logger::INFO, # 1
      log: Logger::INFO,
      warn: Logger::WARN, # 2
      severe: Logger::FATAL # 4
    }
    FILE = :file
    STDOUT = :stdout
    EMAIL = :email

    # @param  config [Hash] config options
    # @option config [String] :file log level for file
    # @option config [String] :stdout log level for stdout
    # @option config [String] :email log level for email
    def initialize(config = {})
      # defaults = { file: 'warn', stdout: 'warn', email: 'email' }
      defaults = {
        demo_logger: { file: 'warn', stdout: 'warn' }
      }
      config = defaults.merge(CleanConfig::Configuration.instance).merge(config)
      @logs = {}
      file_level = config[:demo_logger][:file]
      stdout_level = config[:demo_logger][:stdout]
      @logs[MultiLogger::FILE] = FileLogger.new(translate_level(file_level))
      @logs[MultiLogger::STDOUT] = StdoutLogger.new(translate_level(stdout_level))
    end

    def debug
    end

    def info
    end

    def log
    end

    def warn
    end

    def severe
    end

    # rubocop:disable Style/TrailingWhitespace

    private

    def translate_level(level)
      LOGGER_CONST_MAP[level.downcase.to_sym]
    end

    def from_config(key)
      CleanConfig::Configuration.instance[:demo_logger][key]
    end
  end
end
