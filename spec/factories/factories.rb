require 'spree/testing_support/factories'

FactoryGirl.modify do

  factory :shipment, class: Spree::Shipment do

    # after(:create) do |shipment, evaluator|
    #   build(:order, evaluator.updated_at, shipment: shipment)
    # end

    # # create instance without validation
    # factory :shipment_no_validate do
    #   to_create {|instance| instance.save!(validate: false) }
    # end

    # should work but it doesn'not work
    # trait :trait_updated_at do
    #   updated_at { Time.now }
    # end
    # factory :shipment_force_updated_at, traits: [:trait_updated_at]

  end

  factory :order, class: Spree::Order do

    # create instance without validation
    # factory :order_no_validate do
    #   to_create {|instance| instance.save(validate: false) }
    # end

    # updated_at Time.now
    # transient do
    #   updated_at Time.now
    # end
    #
    # order do
    #   Spree::Order.find_by(updated_at: updated_at) || FactoryGirl.create(:order, updated_at: updated_at)
    # end
  end

end