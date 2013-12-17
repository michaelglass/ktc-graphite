#
# Cookbook Name:: ktc-graphite
# Recipe:: default
#
# Copyright 2013, Robert Choi.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "services"
include_recipe "ktc-utils"

# Search graphite peer nodes
query = "recipes:#{node['graphite']['server_recipe']} AND chef_environment:#{node.chef_environment}"
search(:node, query) do |n|
  # Update carbon-relay destinations
  node.default['graphite']['carbon']['relay']['destinations'] << "#{n['ipaddress']}:2004"
  # Update webapp cluster_servers
  node.default['graphite']['web']['cluster_servers'] << "#{n['ipaddress']}:80"
end

include_recipe "graphite"
include_recipe "graphite::carbon_relay"

# Register main carbon-relay endpoint
::KTC::Network.node = node
ip = ::KTC::Network.address "management"

ep = Services::Endpoint.new "graphite",
  ip: ip,
  port: node['graphite']['carbon']['relay']['line_receiver_port']
ep.save
