module FarMar
  class Market
    attr_accessor :id, :name, :address, :city, :county, :state, :zip, :vendors

    def initialize(market_row)
      @id         = market_row[0].to_i
      @name       = market_row[1]
      @address    = market_row[2]
      @city       = market_row[3]
      @county     = market_row[4]
      @state      = market_row[5]
      @zip        = market_row[6]
      @vendors    = []
    end

    #reads in the CSV market data as an array of arrays
    #creates a new array filled with all market objects
    @@markets = nil
    def self.all
      if @@markets.nil?
        market_data = CSV.read("support/markets.csv")
        @@markets = market_data.map { |row| FarMar::Market.new(row) }
      end
      @@markets
    end

    #self.find(id) - returns the row where the ID field matches the argument
    def self.find(id)
      self.all.find { |market| market.id == id }
    end

  end

end
