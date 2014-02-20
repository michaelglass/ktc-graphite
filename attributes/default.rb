#
# Cookbook Name:: ktc-graphite
# Attributes:: default
#
# Copyright 2013, Robert Choi
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
include_attribute 'graphite'
include_attribute 'graphite::carbon_cache'
include_attribute 'graphite::carbon_relay'

default['graphite']['timezone'] = 'Asia/Seoul'
default['graphite']['package_version'] = '0.9.10-1'

default['graphite']['carbon']['line_receiver_port'] = 2013
default['graphite']['carbon']['udp_receiver_port'] = 2013
default['graphite']['carbon']['pickle_receiver_port'] = 2014

default['graphite']['carbon']['relay']['line_receiver_port'] = 2003
default['graphite']['carbon']['relay']['pickle_receiver_port'] = 2004
default['graphite']['carbon']['relay']['method'] = 'consistent-hashing'  # rules | consistent-hashing
default['graphite']['carbon']['relay']['destinations'] = ['127.0.0.1:2014']
