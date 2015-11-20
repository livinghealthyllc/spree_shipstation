require 'spec_helper'

describe Spree::Shipment do
  context "between" do
    before do
      @dt1 = dt1 = 2.days.ago

      # @order1 = create(:order, updated_at: dt1)
      @order1 = create_order(updated_at: dt1)
      @order1.updated_at = @dt1
      @order1.save!

      # @shipment1 = create(:shipment, updated_at: dt1) # commented because updated_at not updated correctly
      @shipment1 = create_shipment(updated_at: dt1)
      # @shipment1 = create(:shipment_force_updated_at, updated_at: dt1) # not work but should work
      @shipment1.order = @order1
      @shipment1.order.updated_at = @dt1
      @shipment1.order.save!

    end

    subject(:shipment1) { Spree::Shipment.first }
    specify { expect(shipment1.updated_at).to eq(@dt1) }

    order1 = Spree::Order.first
    it "check shipment order date_time" do
      expect(@shipment1.order.updated_at).to eq(@dt1)
      expect(@order1.updated_at).to eq(@dt1)

      expect(shipment1.order.updated_at).to eq(@dt1)
      expect(order1.updated_at).to eq(@dt1)

      expect(Spree::Shipment.count).to eq(1)
      expect(Spree::Order.count).to eq(1)
    end

  end

  def without_timestamping_of(*klasses)
    if block_given?
      klasses.delete_if { |klass| !klass.record_timestamps }
      klasses.each { |klass| klass.record_timestamps = false }
      begin
        yield
      ensure
        klasses.each { |klass| klass.record_timestamps = true }
      end
    end
  end

  def create_order(options={})
    # order = FactoryGirl.build(:order).save!(validate: false)
    # order.updated_at = options[:updated_at] if options[:updated_at]

    # FactoryGirl.create(:order, options)
    FactoryGirl.create(:order, options).tap do |order|
      order.update_column(:updated_at, options[:updated_at]) if options[:updated_at]
    end
  end

  def create_shipment(options={})
    # shipment = FactoryGirl.build(:shipment).save(validate: false)

    # FactoryGirl.create(:shipment, options)
    FactoryGirl.create(:shipment, options).tap do |shipment|
      shipment.update_column(:state, options[:state]) if options[:state]
      shipment.update_column(:updated_at, options[:updated_at]) if options[:updated_at]
      # create_order(updated_at: options[:order]) if options[:order]
      # shipment.order = create_order(updated_at: options[:updated_at]) if options[:updated_at]
    end
  end

end
