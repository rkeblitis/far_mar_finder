module FarMar
  # Creates Sale class using sales.csv
  class Sale
    attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(sale_row)
      @id            = sale_row[0].to_i
      @amount        = sale_row[1].to_i # in cents
      @purchase_time = Time.parse(sale_row[2])
      @vendor_id     = sale_row[3].to_i
      @product_id    = sale_row[4].to_i
    end

    def self.all
      @sales ||= make_sale_instances
    end

    def self.make_sale_instances
      sale_data = CSV.read("support/sales.csv")
      sale_data.map { |row| FarMar::Sale.new(row) }
    end

    # returns the row where the ID field matches the argument
    def self.find(id)
      all.find { |sale| sale.id == id }
    end

    # returns the FarMar::Vendor instance that is associated
    # with this sale using the FarMar::Sale vendor_id field
    def vendor
      FarMar::Vendor.all.find { |vendor| vendor.id == @vendor_id }
    end

    # returns the FarMar::Product instance that is associated with
    # this sale using the FarMar::Sale product_id field
    def product
      FarMar::Product.all.find { |product| product.id == @product_id }
    end

    # returns a collection of FarMar::Sale objects where the purchase time is
    # between the two times given as "YY-MM-DD" arguments
    def self.between(beginning_time, end_time)
      time_one  = Time.parse(beginning_time)
      time_two = Time.parse(end_time)
      all.find_all { |sale| sale.purchase_time.between?(time_one, time_two) }
    end
  end
end
