require_relative '../lib/demo_logger/logger'

describe DemoLogger::Logger do
  context '::new' do
    it 'creates a default instance properly' do
      logger = DemoLogger::Logger.new
      expect(logger).to_not be_nil
      expect(logger.level).to be Logger::WARN
      expect(logger.log_file.path).to eql File.expand_path('.', 'logger.log')
    end
  end
end
