module FarMar
  class Vendor
    attr_accessor :id, :name, :no_of_employees, :market_id

    def initialize(vendor_row)
      @id               = vendor_row[0].to_i
      @name             = vendor_row[1]
      @no_of_employees  = vendor_row[2]
      @market_id        = vendor_row[3].to_i
    end

    @@vendors = nil
    def self.all
      if @@vendors.nil?
        vendor_data = CSV.read("support/vendors.csv")
        @@vendors = vendor_data.map { |row| FarMar::Vendor.new(row) }
      end
      @@vendors
    end

    #self.find(id) - returns the row where the ID field matches the argument
    def self.find(id)
      self.all.find { |vendor| vendor.id == id }
    end

    #def self.find_market_id(market_id)
    #self.all.find_all { |vendor| vendor.market_id == market_id }
    #end

    #market - returns the FarMar::Market instance that is associated with
    #this vendor using the FarMar::Vendor market_id field
    #to call this method: FarMar::Vendor.find(id).market
    def market
      FarMar::Market.all.find_all { |market| market.id == @market_id }
    end

    #products - returns a collection of FarMar::Product instances that are
    #associated with market by the FarMar::Product vendor_id field.
    def products
      FarMar::Product.all.find_all { |product| product.vendor_id == @id}
    end

  end

end
