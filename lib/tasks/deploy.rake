namespace :deploy do
  desc "Run db:seed only if the database is not already seeded"
  task seed_once: :environment do
    if Spree::Store.exists?
      puts "Database already seeded. Skipping db:seed."
    else
      puts "Database not seeded. Running db:seed..."
      Rake::Task["db:seed"].invoke
    end
  end
end
