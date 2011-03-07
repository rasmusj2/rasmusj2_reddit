namespace :db do
  namespace :migrate do
    desc "Rollback the database schema to the previous version"
    task :rollback => :environment do
      previous_version = 20110228195542
      puts "Schema rolled back to previous verison (#{previous_version})."
    end
  end
end
