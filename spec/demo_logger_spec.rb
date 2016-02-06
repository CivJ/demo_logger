require 'clean_config'
require_relative '../lib/demo_logger/logger'

describe DemoLogger::Logger do
  context '::new' do
    context 'configuration settings' do
      it 'creates an instance from a config file' do
        logger = DemoLogger::Logger.new
        expect(logger).to_not be_nil
        expect(logger.level).to be Logger::INFO
        expect(logger.log_file.path).to eql File.join(Dir.pwd, 'logger.log')
      end
    end
  end
end
