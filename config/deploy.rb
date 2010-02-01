set :application, "shouldbet"
set :domain, "shouldbet.com"
server domain, :app, :web, :db, :primary => true

set :user, "lukewen"
set :deploy_to, "~/#{application}"
set :use_sudo, false
default_run_options[:pty] = true

set :scm, "git"
set :repository, "#{user}@#{domain}:~/git/shouldbet.git"
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
#    can't get smtp auth to work with non-admin accts, so storing credentials in production.rb and symlinking
    run "ln -nfs #{shared_path}/config/production.rb #{release_path}/config/environments/production.rb"
    run "rm -rf ~/public_html"
    run "ln -nfs #{release_path}/public ~/public_html"
  end

  desc "Update the crontab file"
  task :update_crontab, :roles => :app do
#    steps to configure whenever gem to work in shared hosting env:
#    1. gem install javan-whenever (home dir install). NOTE: output of 'gem env' gemhome var (~/ruby/gems) did not match error from script/console re: gem repo location (~/.gem/ruby/1.8), so i symlinked ~/.gem/ruby/1.8 to ~/ruby/gems
#    2. add ~/ruby/gems/bin to deploy user PATH (host-specific local gem path) ... although I still had to 'export PATH...' below. could be something i don't understand about capistrano
#    3. read "http://www.hostingrails.com/wiki/2/Install-and-freeze-your-own-RubyGems" for a primer. i also googled 'installing gems shared host' for some ideas.

#    change to --update-crontab to keep existing entries -- although this seems to create dupe entries
    run "cd #{release_path} && export PATH=$PATH:$HOME/ruby/gems/bin && whenever --write-crontab #{application} --set environment=production"
    # TODO: set env var dynamically for use with future staging env
  end

end

after 'deploy:update_code', 'deploy:symlink_shared', 'deploy:update_crontab'
