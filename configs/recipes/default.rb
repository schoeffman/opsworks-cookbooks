#Include required files for the below config settings
include_recipe "mysql::server"
include_recipe "database::mysql"

#use this tempate file as the nginx module
template "/etc/nginx/sites-available/site" do
  source "config.erb"
  mode 0777
  owner node.nginx.user
  group node.nginx.user
end

nginx_site "site" #name of module

#install the required php mysql extension
package "php5-mysql" do
  action :install
end

# create a mysql database - use mysql -u root -proot in order to see database
mysql_database 'siteDb' do connection ({:host => "localhost", :username => 'root', :password => "root"})

  action :create
end

execute "import_database" do
  command "mysql -u root -p#{node['mysql']['server_root_password']} siteDb < #{node['mysql']['projectRoot']}#{node['mysql']['dump_filename']}"
  action :run
end
