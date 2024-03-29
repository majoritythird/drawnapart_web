# This code and these comments are from Avdi Grimm's "Configuring
# database_cleaner with Rails, RSpec, Capybara, and Selenium" blog post.
#
# http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
#
RSpec.configure do |config|

  # This says that before the entire test suite runs, clear the test database
  # out completely.  This gets rid of any garbage left over from interrupted or
  # poorly-written tests--a common source of surprising test behavior.
  config.before(:suite) do
    # Commented out until we figure out how to make specjour not run
    # before-suite on every example.  If you uncomment this line, the suite
    # takes twice as long to run.
    # DatabaseCleaner.clean_with(:truncation)
  end

  # This part sets the default database cleaning strategy to be transactions.
  # Transactions are very fast, and for all the tests where they do work—that
  # is, any test where the entire test runs in the RSpec process—they are
  # preferable.
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    @needs_reseed = false
  end

  # This line only runs before examples which have been flagged `:js => true`.
  # These are the only tests for which Capybara fires up a test server process
  # and drives a browser.  For these types of tests, transactions won't work,
  # so this code overrides the setting and chooses the "truncation" strategy
  # instead.
  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :deletion
    @needs_reseed = true
  end

  # These lines hook up database_cleaner around the beginning and end of each
  # test, telling it to execute whatever cleanup strategy we selected
  # beforehand.
  config.before(:each) do
    DatabaseCleaner.start
  end

  # Run other after hooks before cleaning the DB
  config.append_after(:each) do
    DatabaseCleaner.clean

    # Re-seed the db if we deleted everything
    load(Rails.root.join('db/seeds.rb')) if @needs_reseed
  end

end
