require 'findaface/version'
require 'posix/spawn'

module Findaface
  LIB_PATH = File.dirname(File.expand_path(__FILE__))
  EXECUTABLE = File.join(LIB_PATH, '../ext/findaface/findaface')
  DEFAULT_CASCADE = File.join(LIB_PATH, 'haarcascades/haarcascade_frontalface_alt2.xml')

  def self.has_face?(path)
    raise "#{path} file does not exist" unless File.exists?(path)
    POSIX::Spawn::system "#{EXECUTABLE} --cascade=#{DEFAULT_CASCADE} #{path} > /dev/null 2>&1"
  end
end
