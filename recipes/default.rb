apt_update "update_sources" do
  action :update
end

package "nginx" do
  action :install
end

template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  notifies(:restart, 'service[nginx]')
end

link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
  notifies(:restart, 'service[nginx]')
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
end

service "nginx" do
  action [:enable, :start]
end
