module FarMar
  class Market
    attr_accessor :id, :name, :address, :city, :county, :state, :zip

    def initialize
      @id = id
      @name = name
      @address = address
      @city = city
      @county = county
      @state = state
      @zip = zip
      @vendors = []
    end

    # Execute by typing FarMar::Market.all
    def self.all
      CSV.read("support/markets.csv")
    end

    # Execute by typing FarMar::Market.find(id)
    def self.find(id)
      file = CSV.read("support/market.csv")
      file.first[0].each do | |

      [first..last].each do |number|
        a[number][0] == id
      end
    end

  end
end


FarMar::Market.new
