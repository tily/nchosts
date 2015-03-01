module Nchosts
	class Command < Thor
		desc 'version', 'show version info'
		def version
			puts "v#{Nchosts::VERSION}"
		end

		desc 'generate', 'generate hosts info'
		option :format, :alias => :f
		option :config, :alias => :c
		option :ip_type, :alias => :i # :private, :global, defaults to :global
		option :include # host name regexp
		option :exclude # host name regexp
		option :template # custom erb template
		def generate
			instances = []
			lines = File.read(options[:config]).split(/\n/)
			lines.each do |line|
				# TODO: sharp comment for user memo
				aki, sak = line.split(/\:/)
				instances += client(aki, sak).instances
			end
		end

		no_commands do
		end
	end
end
