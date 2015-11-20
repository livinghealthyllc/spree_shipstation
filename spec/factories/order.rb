require 'spree/testing_support/factories'

FactoryGirl.modify do
  factory :order, class: Spree::Order do
    # updated_at { 1.days.ago }
    # association :shipment #commented because SystemStackError: stack level too deep

    factory :one_day_ago do
      updated_at { 1.days.ago }
    end

    factory :one_day_from_now do
      updated_at { 1.day.from_now }
    end

    # after(:build) do |shipment|
    #   [:one_day_ago].each do |order|
    #     shipment.order << build(:order, updated_at: order, shipment: shipment)
    #   end
    # end

    # before(:save) do |order|
    #   order.updated_at = 1.days.ago
    #   # order.updated_at = :one_day_ago
    #   order.save!
    # end
  end
end