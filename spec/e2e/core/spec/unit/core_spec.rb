require 'logger'
require_relative '../../lib/core/core_one'

module Core
  describe CoreOne do
    context 'demo_logger layers config' do
      it 'Core can override demo_logger configuration' do

        # See config/config.yml
        # Because of the way Rspec loads/evals tests we have to babysit our
        # configuration object. We would not have to do this outside of Rspec.
        config = { demo_logger: { file: 'info', stdout: 'debug', email: 'severe' } }
        CleanConfig::Configuration.instance.merge!(config)

        core_one = CoreOne.new

        logger = core_one.logger
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
      end
    end
  end
end
