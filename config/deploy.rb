set :application, "shouldbet"
set :domain, "68.233.8.236"
server domain, :app, :web, :db, :primary => true

set :user, "lukewen"
set :deploy_to, "~/#{application}"
set :use_sudo, false

set :scm, "git"
set :repository, "."
set :deploy_via, :copy
set :copy_remote_dir, "~/tmp"
set :branch, "master"

namespace :deploy do
  desc "Restarting Passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with Passenger"
    task t, :roles => :app do ; end
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
    run "ln -nfs #{shared_path}/config/consumer.yml #{release_path}/config/consumer.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
    run "rm -rf ~/public_html"
    run "ln -nfs #{release_path}/public ~/public_html"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
