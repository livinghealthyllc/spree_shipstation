require 'spree/testing_support/factories'
require 'timecop'
FactoryGirl.modify do
  factory :shipment, class: Spree::Shipment do
    # updated_at { 1.days.ago }
    association :order

    # updated_at {}
    # after(:build) do |shipment|
    #   [:one_day_ago].each do |order|
    #     shipment.order << build(:order, updated_at: order, shipment: shipment)
    #   end
    # end

    # after(:create) do |shipment|
      # shipment.order.updated_at = 1.days.ago
      # shipment.order.save!
      # shipment.save!
    # end

    before(:create) do |shipment|
      # shipment.save!(validate: false)
    end
  end

end