require "bundler/capistrano"
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'deploy')
# require 'new_relic/recipes'
# require "remote"
load 'deploy/assets'
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

server "192.241.252.242", :web, :app, :db, primary: true
set :rvm_type, :user
set :rvm_bin_path, "$HOME/.rvm/bin"
set :user, "deployer"
set :domain, "compassionforhumanity.org"
set :application, "compassion"
set :deploy_to, "/home/#{user}/apps/compassion"
# set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, :git
set :port, 36332
set :repository,  "~/git/compassion.git"
set :local_repository,  "ssh://#{user}@#{domain}:#{port}/~/git/compassion.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:port] = 36332


# Passenger
namespace :deploy do

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  task :after_symlink do
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end

  desc "Reload the database with seed data"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=production"
  end

  desc "Cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

  before "deploy:assets:precompile", "deploy:symlink_shared"
  after "deploy:symlink_shared", "deploy:after_symlink"

  after "deploy:update_code", :bundle_install
  desc "install the necessary prerequisites"
  task :bundle_install, :roles => :app do
    run "cd #{release_path} && bundle install"
  end

  desc "Remote console on the production appserver"
  task :console, :roles => ENV['ROLE'] || :web do
    hostname = find_servers_for_task(current_task).first
    puts "Connecting to #{hostname}"
    exec "ssh -p 36332 -l #{user} #{hostname} -t 'source ~/.profile && cd #{current_path} && bundle exec rails c #{rails_env}'"
  end

require "rvm/capistrano"
        require './config/boot'
        require 'airbrake/capistrano'
