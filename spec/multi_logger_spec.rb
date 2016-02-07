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
  end
end
