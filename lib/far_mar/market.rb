module FarMar
  class Market

    def initialize(row)
      @id = row[0]
      @name = row[1]
      @address = row[2]
      @city = row[3]
      @county = row[4]
      @state = row[5]
      @zip = row[6]
    end

    #reads in the CSV market data as an array of arrays
    #creates a new array filled with all market objects
    def self.all
      market_data = CSV.read("support/markets.csv")
      market_data.map { |row| FarMar::Market.new(row) }
    end

  end

end
