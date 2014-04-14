#Include required files for the below config settings
include_recipe "mysql::server"
include_recipe "database::mysql"

# create a mysql database - use mysql -u root -proot in order to see database
mysql_database node['vagrantConfig']['databaseName'] do connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end

execute "import_database" do
  command "mysql -u root -p#{node['mysql']['server_root_password']} #{node['vagrantConfig']['databaseName']} < #{node['mysql']['projectRoot']}#{node['mysql']['dump_filename']}"
  action :run
end
