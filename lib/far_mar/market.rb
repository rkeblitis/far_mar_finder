module FarMar
  class Market
    attr_accessor :id, :name, :address, :city, :county, :state, :zip, :vendors

    def initialize(market_row)
      @id = market_row[0]
      @name = market_row[1]
      @address = market_row[2]
      @city = market_row[3]
      @county = market_row[4]
      @state = market_row[5]
      @zip = market_row[6]
      @vendors = []
    end

    #reads in the CSV market data as an array of arrays
    #creates a new array filled with all market objects
    def self.all
      market_data = CSV.read("support/markets.csv")
      market_data.map { |row| FarMar::Market.new(row) }
    end

  end

end
