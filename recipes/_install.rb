#
# Cookbook Name:: ktc-graphite
# Recipe:: _install
# Author:: Robert Choi
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
chef_gem "chef-rewind"
require 'chef/rewind'

version = node['graphite']['version']

# Temporary fix. Should be removed soon. #
package "python-django" do
  version "1.3.1-4ubuntu1.8"
end

# Install packages from our repo
%w{ python-whisper python-carbon graphite-web }.each do |pkg|
  package pkg do
    version node['graphite']['package_version']
  end
end

include_recipe "graphite"

# Rewind Whisper installation #
rewind :remote_file => "#{Chef::Config[:file_cache_path]}/whisper-#{version}.tar.gz" do
  action :nothing
end

["untar whisper", "install whisper"].each do |exe|
  rewind :execute => exe do
    action :nothing
  end
end

# Rewind Carbon installation #
rewind :remote_file => "#{Chef::Config[:file_cache_path]}/carbon-#{version}.tar.gz" do
  action :nothing
end

["untar carbon", "install carbon"].each do |exe|
  rewind :execute => exe do
    action :nothing
  end
end


# Rewind Webapp installation#
rewind :remote_file => "#{Chef::Config[:file_cache_path]}/graphite-web-#{version}.tar.gz" do
  action :nothing
end

["untar graphite-web", "install graphite-web"].each do |exe|
  rewind :execute => exe do
    action :nothing
  end
end

package "python-django" do
  action :nothing
end

# Run carbon_relay service
include_recipe "graphite::carbon_relay"
