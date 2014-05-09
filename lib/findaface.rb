require 'findaface/version'
require 'posix/spawn'

module Findaface
  LIB_PATH = File.dirname(File.expand_path(__FILE__))
  EXECUTABLE = File.join(LIB_PATH, '../ext/findaface/findaface')
  DEFAULT_CASCADE = {
			cascade:'haarcascades/haarcascade_frontalface_alt2.xml',
			fussyness:4,
			max_size: 512,
			min_size: 80,
			scale_factor: 1.05,
	}
  DEFAULT_OPTIONS = DEFAULT_CASCADE.keys

	class << self
	  attr_reader :cascades
	end

  def self.has_face?(path)
    raise "#{path} file does not exist" unless File.exists?(path)
		add_cascade(DEFAULT_CASCADE) if @cascades.nil?
		commands = @cascades.map { |opts| build_command(opts, path) }
		commands.each { |cmd| return true if POSIX::Spawn::system cmd }
		false
  end

  def self.add_cascade(options)
    raise "Invalid setting. Got	#{options.keys.sort}, require #{DEFAULT_OPTIONS}" unless options.keys.sort == DEFAULT_OPTIONS
		@cascades ||= []
		@cascades << options
	end

	private

	def self.build_command(options, path)
    "#{EXECUTABLE} " +
			"--cascade=#{cascade_path(options[:cascade])} " +
		  "--fussyness=#{options[:fussyness]} " +
		  "--scale_factor=#{options[:scale_factor]} " +
		  "--min_size=#{options[:min_size]} " +
		  "--max_size=#{options[:max_size]} " +
			"#{path} > /dev/null 2>&1"
	end

	def self.cascade_path(cascade_path)
    File.join(LIB_PATH, cascade_path)
	end
end
