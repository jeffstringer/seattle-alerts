desc "This task updates police, fire database from SODA APIs"
task :start_all => :environment do
  PoliceAlert.start_all
end

task :count_all => :environment do
  PoliceAlert.count_all
end

