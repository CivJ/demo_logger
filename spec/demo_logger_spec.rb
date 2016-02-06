require_relative '../lib/demo_logger/logger'

describe DemoLogger::Logger do
  context '::new' do
    context 'configuration settings' do
      # let(:output_file) { File.join(__FILE__, '..', 'tmp', 'spec_output.log') }
      # let(:config) { {path: output_file} }

      it 'creates a default instance properly' do
        logger = DemoLogger::Logger.new
        expect(logger).to_not be_nil
        expect(logger.level).to be Logger::WARN
        expect(logger.log_file.path).to eql File.join(Dir.pwd, 'logger.log')
      end
    end
  end
end
