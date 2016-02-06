require_relative '../lib/demo_logger/logger'

describe DemoLogger::Logger do
  context '::new' do
    it 'creates a default instance properly' do
      logger = DemoLogger::Logger.new
      expect(logger).to_not be_nil
    end
  end
end
