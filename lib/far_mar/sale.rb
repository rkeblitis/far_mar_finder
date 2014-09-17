module FarMar
  class Sale
    attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(sale_row)
      @id            = sale_row[0].to_i
      @amount        = sale_row[1].to_i #(in cents)
      @purchase_time = sale_row[2]
      @vendor_id     = sale_row[3].to_i
      @product_id    = sale_row[4].to_i
    end

    @@sale = nil
    def self.all
      if @@sale.nil?
        sale_data = CSV.read("support/sales.csv")
        @@sale = sale_data.map { |row| FarMar::Sale.new(row) }
      end
      @@sale
    end

    #returns the row where the ID field matches the argument
    def self.find(id)
      self.all.find { |sale| sale.id == id }
    end

    #returns the FarMar::Vendor instance that is associated
    #with this sale using the FarMar::Sale vendor_id field
    def vendor
      FarMar::Vendor.all.find_all { |vendor| vendor.id == @vendor_id }
    end

    #returns the FarMar::Product instance that is associated with
    #this sale using the FarMar::Sale product_id field
    def product
      FarMar::Product.all.find_all { |product| product.id == @product_id }
    end

    #returns a collection of FarMar::Sale objects where the purchase time is
    #between the two times given as arguments
    def self.between(beginning_time, end_time)
      self.all
    end

  end

end
