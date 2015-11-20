require 'spree/testing_support/factories'

FactoryGirl.modify do
  factory :order, class: Spree::Order do
  end
end