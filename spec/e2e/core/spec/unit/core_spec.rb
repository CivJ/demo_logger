require 'logger'
require_relative '../../lib/core/core_one'

module Core
  describe CoreOne do
    context 'demo_logger layers config' do
      it 'Core can override demo_logger configuration' do

        # Reset the configuration by hand during an Rspec run.
        CleanConfig::Configuration.instance.merge!(demo_logger: { level: 'debug' })
        core_one = CoreOne.new

        puts "core_cone logger level: #{core_one.logger.level}"
        expect(core_one.logger.level).to eql(Logger::DEBUG)
      end
    end
  end
end
