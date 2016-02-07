require_relative '../lib/demo_logger/multi_logger'
require_relative 'spec_helper'

describe DemoLogger::MultiLogger do
  context 'logger creation' do
    it 'creates all loggers based on config file' do
      # See config/config.yml
      logger = DemoLogger::MultiLogger.new
      expect(logger.logs.length).to eq 2

      file_log = logger.logs[DemoLogger::MultiLogger::FILE]
      expect(file_log.class).to eql DemoLogger::FileLogger
      expect(file_log.level).to eql Logger::INFO

      std_log = logger.logs[DemoLogger::MultiLogger::STDOUT]
      expect(std_log.class).to eql DemoLogger::StdoutLogger
      expect(std_log.level).to eql Logger::DEBUG
    end

    it 'creates all loggers based on method parameters' do
      # See config/config.yml
      config = {
        demo_logger: { file: 'severe', stdout: 'severe' } }

      logger = DemoLogger::MultiLogger.new(config)
      expect(logger.logs.length).to eq 2

      file_log = logger.logs[DemoLogger::MultiLogger::FILE]
      expect(file_log.class).to eql DemoLogger::FileLogger
      expect(file_log.level).to eql Logger::FATAL

      std_log = logger.logs[DemoLogger::MultiLogger::STDOUT]
      expect(std_log.class).to eql DemoLogger::StdoutLogger
      expect(std_log.level).to eql Logger::FATAL
    end

    # TODO: We can probably break this up into smaller tests.
    it 'logs to all loggers at appropriate levels' do
      config = {
        demo_logger: { file: 'severe', stdout: 'debug' } }

      logger = DemoLogger::MultiLogger.new(config)

      # TODO: Make the stdout capturing work.
      logger.debug('TEST-DEBUG')

      # We can check the file immediately because sync is turned on.
      log_file = logger.logs[DemoLogger::MultiLogger::FILE].log_file
      file_contents = File.read(log_file)
      expect(file_contents).to be_empty

      expected_contents = 'TEST-SEVERE'
      logger.severe(expected_contents)

      file_contents = File.read(log_file)
      expect(file_contents).to include(expected_contents)
    end
  end
end
