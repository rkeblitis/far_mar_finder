module FarMar
  class Market
    attr_accessor :id, :name, :address, :city, :county, :state, :zip

    def initialize (market_index)
      @id       = market_index[0]
      @name     = market_index[1]
      @address  = market_index[2]
      @city     = market_index[3]
      @county   = market_index[4]
      @state    = market_index[5]
      @zip      = market_index[-1]
# instanciate all markets here
    end

    # Execute by typing FarMar::Market.all
    def self.all # transform every individual array into an instance
      # the values within the individuals arrays will should be the instance
      # variables.
      @market_index = CSV.read("support/markets.csv")
    end

    # Execute by typing FarMar::Market.find(id)
    def self.find(id)
      file = CSV.read("support/market.csv")
      #returns the row where the ID field matches the argument

      # convert into market objects
      a = file.find { |array| array[0] == id}
      FarMar::Market.new(a[0])



    end



  end
end
