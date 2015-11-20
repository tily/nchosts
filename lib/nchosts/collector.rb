module Nchosts
	class Collector
		attr_accessor :client

		def initialize(account)
			@client = AceClient::Niftycloud::Computing.build_client(
				endpoint: 'cp.cloud.nifty.com',
				path: '/api/',
				access_key_id: account['access_key_id'],
				secret_access_key: account['secret_access_key']
			)
		end

		def collect
			client.regions.each do |region|
				client.endpoint = region['regionEndpoint']
				client.instances.each do |instance|
					yield region, instance
				end
			end
		end
	end
end
