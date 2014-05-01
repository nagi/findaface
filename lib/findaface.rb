require "findaface/version"

module Findaface
  def self.has_face?(path)
    binary = File.join(File.dirname(File.expand_path(__FILE__)), '../ext/findaface/findaface')
    cascade = File.join(File.dirname(File.expand_path(__FILE__)),
                        '../lib/haarcascades/haarcascade_frontalface_alt.xml')
    system "#{binary} --cascade=#{cascade} #{path} > /dev/null 2>&1"
  end
end
