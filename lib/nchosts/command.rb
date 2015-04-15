module Nchosts
	class Command < Thor
		desc 'version', 'show version info'
		def version
			puts "v#{Nchosts::VERSION}"
		end

		desc 'collect', 'collect hosts info from nifty cloud api'
		option :config, :aliases => :c
		option :output_path, :aliases => :o
		def collect
			instances = []
			json = JSON.parse File.read(options[:config])
			json['accounts'].each do |account|
				collector = Nchosts::Collector.new(account)
				collector.collect do |region, instance|
					instance['region'] = region
					instance['account'] = account
					instances << instance
				end
			end
			File.write options[:output_path], instances.to_json
		end

		desc 'generate', 'generate'
		option :format, :aliases => :f # hosts, capistrano, ssh_config
		option :include # host name regexp
		option :exclude # host name regexp
		option :format, :aliases => :f
		option :template, :aliases => :t
		option :input_path, :aliases => :i
		def generate
			if options[:format]
				template = template(options[:format])
			elsif options[:template]
				template = File.read(options[:template])
			else
				abort "Please specify :format or :template"
			end
			instances = JSON.parse File.read options[:input_path]
			puts Erubis::Eruby.new(template).result(:instances => instances)
		end

		no_commands do
			def template(name)
				File.read File.join(File.dirname(__FILE__), "templates/#{name}.erb")
			end
		end
	end
end
