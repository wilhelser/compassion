# Use this file to easily define all of your cron jobs.
#
#
set :output, "/var/log/cron.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

every 24.hours do
  runner "Project.email_inactive_projects"
end

# Learn more: http://github.com/javan/whenever
