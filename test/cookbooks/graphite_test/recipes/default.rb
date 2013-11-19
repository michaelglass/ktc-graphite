include_recipe "services"

endpoint = Services::Endpoint.new "graphite"
endpoint.load

Chef::Log.info "Graphite Endpoint: #{endpoint.ip}"
