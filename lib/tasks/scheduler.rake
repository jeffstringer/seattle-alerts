desc "This task fetches data from SODA APIs, creates alerts and notifications"
task :seattle_alert_call => :environment do
  SeattleAlert.call
end

desc "This task destroys all data except subscribers if >= 9900 records for heroku limit"
task :reset_db_call => :environment do
  ResetDB.call
end

