# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :cron_log, "/path/to/my/cron_log.log"
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

# Learn more: http://github.com/javan/whenever

set :cron_log, "/home/shouldbe/shouldbet/current/log/cron.log"

# fetch mail routine
every 30.minutes do
  runner "/home/shouldbe/shouldbet/current/script/fetch_mail"
end

# test outgoing email
every 1.day, :at => "6am" do
  runner "InvitationMailer.deliver_invite_complete(Invitation.find(8))"
end

#batch mailer
every 10.minutes do
  runner "/home/shouldbe/shouldbet/current/script/batch_mail"
end
