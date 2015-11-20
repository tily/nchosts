module Nchosts
	class Collector
		ENDPOINTS = %w(
			cp.cloud.nifty.com
			uscp.cloud.nifty.com
		)
		attr_accessor :clients

		def initialize(account)
			@clients = []
			ENDPOINTS.each do |endpoint|
				@clients << AceClient::Niftycloud::Computing.build_client(
					endpoint: endpoint,
					path: '/api/',
					access_key_id: account['access_key_id'],
					secret_access_key: account['secret_access_key']
				)
			end
		end

		def collect
			@clients.each do |client|
				client.regions.each do |region|
					client.endpoint = region['regionEndpoint']
					client.instances.each do |instance|
						yield region, instance
					end
				end
			end
		end
	end
end
