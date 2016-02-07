require 'clean_config'
require_relative '../lib/demo_logger/file_logger'

describe DemoLogger::FileLogger do
  context '::new' do
    it 'creates an instance' do
      logger = DemoLogger::FileLogger.new(Logger::INFO)
      expect(logger).to_not be_nil
      expect(logger.level).to eq Logger::INFO
      expect(logger.log_file.path).to eq File.join(Dir.pwd, 'log', 'logger.log')
    end
  end
end
