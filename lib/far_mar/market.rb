module FarMar
  # Creates Market class using market.csv
  class Market
    attr_accessor :id, :name, :address, :city, :county, :state, :zip

    def initialize(market_row)
      @id      = market_row[0].to_i
      @name    = market_row[1]
      @address = market_row[2]
      @city    = market_row[3]
      @county  = market_row[4]
      @state   = market_row[5]
      @zip     = market_row[6]
    end

    # creates a new array filled with all market objects
    def self.all
      @markets ||= make_market_instances
    end

    # reads in the CSV market data as an array of arrays
    def self.make_market_instances
      market_data = CSV.read("support/markets.csv")
      market_data.map { |row| FarMar::Market.new(row) }
    end

    # returns the row where the ID field matches the argument
    def self.find(id)
      all.find { |market| market.id == id }
    end

    # returns a collection of FarMar::Vendor instances that are
    # associated with the market by the market_id field.
    def vendors
      FarMar::Vendor.all.find_all { |vendor| vendor.market_id == @id }
    end

    # returns a collection of FarMar::Product instances that are associated to
    # the market through the FarMar::Vendor class.
    def products
      FarMar::Vendor.by_market(@id).flat_map { |vendor| vendor.products }
    end


    # returns a collection of FarMar::Market instances
    # where the market name or vendor name contain the search_term. For example
    # FarMar::Market.search('school') would return 3 results, one being the
    # market with id 75 (Fox School Farmers FarMar::Market).
    def self.search(search_term)
      search_term = search_term.capitalize
      all.find_all do |market|
        market.name.include?(search_term) ||
        market.vendors.any? { |vendor| vendor.name.include?(search_term) }
      end
    end
  end
end
