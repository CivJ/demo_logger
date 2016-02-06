require 'clean_config'
require_relative '../lib/demo_logger/logger'

describe DemoLogger::Logger do
  context '::new' do
    context 'configuration settings' do
      it 'creates an instance from a config file' do

        # Reset the configuration by hand during an Rspec run.
        CleanConfig::Configuration.instance.merge!(demo_logger: { level: 'info' })

        logger = DemoLogger::Logger.new
        expect(logger).to_not be_nil
        expect(logger.level).to be Logger::INFO
        expect(logger.log_file.path).to eq File.join(Dir.pwd, 'logger.log')
      end
    end
  end

  context 'sanity check api behavior' do
    context 'log level should be honored' do

    end
  end
end
