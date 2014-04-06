#use this tempate file as the nginx module
template "/etc/nginx/sites-available/site" do
  source "config.erb"
  mode 0777
  owner node.nginx.user
  group node.nginx.user
end

nginx_site "site" #name of module


