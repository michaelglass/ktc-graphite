#
# vim: set ft=ruby:
#

chef_api "https://chefdev.mkd2.ktc", node_name: "cookbook", client_key: ".cookbook.pem"

site :opscode

metadata

cookbook "ktc-testing"
cookbook "ktc-etcd"
cookbook "graphite_test", path: "test/cookbooks/graphite_test"
