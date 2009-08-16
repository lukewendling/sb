desc "Initialize/Reset the sandbox for development and testing"
task :bootstrap do
  puts "*** This will remove and reset all databases ***"
  # rails 2.0.5 balks on db:drop:all if any of the databases does not exist, bad for "virgin" bootstrap
  # make sure the files themselves exist before removing them.
  touch 'db/development.sqlite3'
  touch 'db/test.sqlite3'
  [ 'db:drop:all', 'log:clear', 'db:migrate', 'db:fixtures:load', 'db:test:prepare', 'db:schema:dump' ].each do |subtask|
    puts "*** [#{Time.now}] Invoking Rake Task: #{subtask}"
    Rake::Task[subtask].invoke
  end
  puts "*** Sandbox should be ready to 'rake test', 'script/server', etc... ***"
end

desc "Restart passenger"
namespace :app do
  task :restart do
    touch 'tmp/restart.txt'
  end
end
