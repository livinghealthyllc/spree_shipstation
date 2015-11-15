require 'spree/testing_support/factories'

FactoryGirl.modify do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_shipstation/factories'

  # factory :s do
  #   updated_at Time.now
  # end

  factory :shipment, class: Spree::Shipment do
    # state 'pending'

    trait :state do
      state 'pending'
    end



    # after(:create) do |shipment, evaluator|
    #   build(:order, evaluator.updated_at, shipment: shipment)#.save(validate:false)
    # end

    # create instance without validation

    factory :shipment_no_validate do
      to_create {|instance| instance.save!(validate: false) }
    end



    # updated_at Time.now
    # state "pending"
    # order

    # factory :shipment_with_order_dt do
    #
    #   transient do
    #     updated_at Time.now
    #   end
    #
    #   after(:build) do |shipment, evaluator|
    #     build(:order, evaluator.updated_at, shipment: shipment).save(validate:false)
    #   end
    # end
    # stock_location_id Spree::Stock
    # transient do
    #   updated_at Time.now
    # end
    # # transient do
    # #   order Spree::Order.find_by(updated_at: updated_at) || FactoryGirl.create(:order, updated_at: updated_at)
    # # end
    # order do
    #   Spree::Order.find_by(updated_at: updated_at) || FactoryGirl.create(:order, updated_at: updated_at)
    # end

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
