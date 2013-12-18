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

include_recipe "graphite"
include_recipe "graphite::carbon_relay"

ruby_block "service member registration" do
  block do
    #service  = Services::Service.new("graphite")
    member = Services::Member.new node['fqdn'],
      service: "graphite",
      port: node['graphite']['carbon']['relay']['pickle_receiver_port'],
      ip: node[:ipaddress]
    member.save
  end
end
