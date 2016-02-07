require_relative '../lib/demo_logger/multi_logger'
require_relative 'spec_helper'

describe DemoLogger::MultiLogger do
  context 'logger creation' do
    it 'creates all loggers based on config file' do
      # See config/config.yml
      logger = DemoLogger::MultiLogger.new
      expect(logger.logs.length).to eq 1
      expect(logger.logs[0].class).to eql DemoLogger::FileLogger
    end

    it 'creates all loggers based on method parameters' do
      # See config/config.yml
      logger = DemoLogger::MultiLogger.new(demo_logger: { file: 'severe' })
      expect(logger.logs.length).to eq 1
      log = logger.logs.first
      expect(log.class).to eql DemoLogger::FileLogger
      expect(log.level).to eql Logger::FATAL
    end
  end
end
