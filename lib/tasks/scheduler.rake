desc "This task updates police, fire database from SODA APIs"
task :update_databases => :environment do
  PoliceAlert.fetch_police_data
  FireAlert.fetch_fire_data
end



