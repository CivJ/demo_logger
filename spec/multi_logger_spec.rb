require_relative '../lib/demo_logger/multi_logger'
require_relative 'spec_helper'

describe DemoLogger::MultiLogger do
  context 'logger creation' do
    it 'creates all loggers based on config file' do

      # See config/config.yml
      # Because of the way Rspec loads/evals tests we have to babysit our
      # configuration object. We would not have to do this outside of Rspec.
      config = { demo_logger: { file: 'info', stdout: 'debug', email: 'severe' } }
      CleanConfig::Configuration.instance.merge!(config)

      logger = DemoLogger::MultiLogger.new
      expect(logger.logs.length).to eq 3

      file_log = logger.logs[DemoLogger::MultiLogger::FILE]
      expect(file_log.class).to eql DemoLogger::FileLogger
      expect(file_log.level).to eql Logger::INFO

      std_log = logger.logs[DemoLogger::MultiLogger::STDOUT]
      expect(std_log.class).to eql DemoLogger::StdoutLogger
      expect(std_log.level).to eql Logger::DEBUG

      email_log = logger.logs[DemoLogger::MultiLogger::EMAIL]
      expect(email_log.class).to eql DemoLogger::EmailLogger
      expect(email_log.level).to eql Logger::FATAL

      logger.close
    end

    it 'creates all loggers based on method parameters' do
      # See config/config.yml
      config = {
        demo_logger: { file: 'severe', stdout: 'severe', email: 'info' } }

      logger = DemoLogger::MultiLogger.new(config)
      expect(logger.logs.length).to eq 3

      file_log = logger.logs[DemoLogger::MultiLogger::FILE]
      expect(file_log.class).to eql DemoLogger::FileLogger
      expect(file_log.level).to eql Logger::FATAL

      std_log = logger.logs[DemoLogger::MultiLogger::STDOUT]
      expect(std_log.class).to eql DemoLogger::StdoutLogger
      expect(std_log.level).to eql Logger::FATAL

      email_log = logger.logs[DemoLogger::MultiLogger::EMAIL]
      expect(email_log.class).to eql DemoLogger::EmailLogger
      expect(email_log.level).to eql Logger::INFO

      logger.close
    end

    # TODO: have each test cleanup after itself. Right now the rake tasks
    # are doing one big cleanup before the tests run.
    context 'logging levels' do

      config = {
        demo_logger: { file: 'severe', stdout: 'debug' } }

      let(:logger) { DemoLogger::MultiLogger.new(config) }
      # We can check the file immediately because sync is turned on.
      let(:log_file) { logger.logs[DemoLogger::MultiLogger::FILE].log_file }
      let(:email_file) { logger.logs[DemoLogger::MultiLogger::FILE].log_file }

      after(:each) { logger.close }
      it 'debug to all logs correctly' do
        config = { demo_logger: { file: 'info', stdout: 'debug', email: 'severe' } }
        CleanConfig::Configuration.instance.merge!(config)

        # TODO: Make the stdout capturing work.
        logger.debug('TEST-DEBUG')

        file_contents = File.read(log_file)
        expect(file_contents).to be_empty

        email_contents = File.read(email_file)
        expect(email_contents).to be_empty
      end

      it 'severe to all logs correctly' do
        config = { demo_logger: { file: 'info', stdout: 'debug', email: 'severe' } }
        CleanConfig::Configuration.instance.merge!(config)

        expected_contents = 'TEST-SEVERE'
        logger.severe(expected_contents)

        file_contents = File.read(log_file)
        expect(file_contents).to include(expected_contents)

        email_contents = File.read(email_file)
        expect(email_contents).to include(expected_contents)
      end
    end
  end
end
