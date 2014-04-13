execute "create_path" do
  command "sudo mkdir -p /srv/www/"
  action :run
end

execute "create_link" do
  command "sudo ln -s /home/vagrant/code/site/ /srv/www/site"
  action :run
end

#/srv owned by root
