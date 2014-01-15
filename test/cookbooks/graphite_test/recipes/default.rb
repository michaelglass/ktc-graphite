include_recipe "services"

ruby_block "set endpoints" do
  block do
    KTC::Attributes.set
  end
end
