module FarMar
  class Sale
    attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(sale_row)
      @id            = sale_row[0].to_i
      @amount        = sale_row[1]
      @purchase_time = sale_row[2]
      @vendor_id     = sale_row[3].to_i
      @product_id    = sale_row[4].to_i
    end

    @@sale = nil
    def self.all
      if @@sale.nil?
        sale_data = CSV.read("support/sale.csv")
        @@sale = sale_data.map { |row| FarMar::Sale.new(row) }
      end
      @@sale
    end

    #self.find(id) - returns the row where the ID field matches the argument
    def self.find(id)
      self.all.find { |sale| sale.id == id }
    end

  end

end
