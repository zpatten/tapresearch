namespace :api do

  desc "Sync TapResearch API Data"
  task :sync => :environment do
    print "Starting TapResearch API Sync..."

    TapResearch::API::Campaign.new.sync

    print "done.\n"
  end

end
