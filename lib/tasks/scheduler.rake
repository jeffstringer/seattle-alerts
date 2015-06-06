desc "This task updates police, fire database from SODA APIs"
task :start_app => :environment do
  StartApp.call
end

task :clean_app => :environment do
  CleanApp.call
end

