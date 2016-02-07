require 'logger'
require 'stringio'

module DemoLogger
  # TODO: This could share a common superclass with FileLogger
  class EmailLogger < Logger
    attr_reader :email_file
    attr_accessor :send_mail

    def initialize(level, send_mail = false)
      log_file_dir = File.expand_path(File.join(Dir.pwd, 'email'))
      FileUtils.mkdir_p(log_file_dir)
      log_file_path = File.join(log_file_dir, 'logger.log')
      @email_file = File.open(File.join(log_file_path), 'a')
      @send_mail = send_mail

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
