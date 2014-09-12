desc "This task updates police, fire database from SODA APIs"
task :update_police_alerts => :environment do
  PoliceAlert.fetch_police_data
end

task :update_fire_alerts => :environment do
  FireAlert.fetch_fire_data
end



