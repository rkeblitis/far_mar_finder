module FarMar
  # Creates Vendor class using vendors.csv
  class Vendor
    attr_accessor :id, :name, :no_of_employees, :market_id

    def initialize(vendor_row)
      @id              = vendor_row[0].to_i
      @name            = vendor_row[1]
      @no_of_employees = vendor_row[2].to_i
      @market_id       = vendor_row[3].to_i
    end

    def self.all
      @vendors ||= make_vendor_instances
    end

    def self.make_vendor_instances
      vendor_data = CSV.read("support/vendors.csv")
      vendor_data.map { |row| FarMar::Vendor.new(row) }
    end

    # returns the row where the ID field matches the argument
    def self.find(id)
      all.find { |vendor| vendor.id == id }
    end

    # returns the FarMar::Market instance that is associated with
    # this vendor using the FarMar::Vendor market_id field
    # to call this method: FarMar::Vendor.find(id).market
    def market
      FarMar::Market.all.find { |market| market.id == @market_id }
    end

    # returns a collection of FarMar::Product instances that are
    # associated with market by the FarMar::Product vendor_id field.
    def products
      FarMar::Product.all.find_all { |product| product.vendor_id == @id }
    end

    # returns a collection of FarMar::Sale instances that are
    # associated with market by the vendor_id field.
    def sales
      FarMar::Sale.all.find_all { |sale| sale.vendor_id == @id }
    end

    # returns the the sum of all of the vendor's sales (in cents)
    def revenue
      sales.map { |sales| sales.amount }.reduce(:+)
      # any way to add reduce to the initial chain?
    end

    # returns all of the vendors with the given market_id
    def self.by_market(market_id)
      all.find_all { |vendors| vendors.market_id == market_id }
    end
  end
end
