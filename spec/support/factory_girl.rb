# RSpec.configure do |config|
#   # additional factory_girl configuration
#
#   config.before(:suite) do
#     begin
#       DatabaseCleaner.start
#       # builds each factory and subsequently calls #valid? on it (if #valid? is defined);
#       # if any calls to #valid? return false, FactoryGirl::InvalidFactoryError is raised with a list of the offending factories.
#       FactoryGirl.lint
#     ensure
#       DatabaseCleaner.clean
#     end
#   end
#
#   # lint factories selectively by passing only factories you want linted
#   factories_to_lint = FactoryGirl.factories.reject do |factory|
#     factory.name =~ /^old_/
#   end
#
#   # This would lint all factories that aren't prefixed with old_.
#   FactoryGirl.lint factories_to_lint
# end