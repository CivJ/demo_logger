require 'logger'
require 'stringio'

module DemoLogger
  class EmailLogger < Logger
    attribute_reader :@email_file

    def initialize(level)
      @email_file = File.new(File.join(Dir.pwd, 'email.log'))

      # We are setting sync = true because of the following line from the spec:
      # "You need to build a framework that will continuously dump the logger output to a file."
      # This sounds like an instruction to avoid buffering, so that's what we're doing.
      # Obvious performance hit.
      @email_file.sync = true
      super(@email_file)
      self.level = level || Logger::WARN
    end
  end
end
