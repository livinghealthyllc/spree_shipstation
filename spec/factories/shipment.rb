require 'spree/testing_support/factories'
require 'timecop'
FactoryGirl.modify do
  factory :shipment, class: Spree::Shipment do
    association :order
  end

end