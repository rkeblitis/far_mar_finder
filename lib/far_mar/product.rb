module FarMar
  class Product
    attr_accessor :id, :name, :vendor_id

    def initialize(product_row)
      @id         = product_row[0].to_i
      @name       = product_row[1]
      @vendor_id  = product_row[2]
    end

    @@products = nil
    def self.all
      if @@products.nil?
        product_data = CSV.read("support/products.csv")
        @@products = product_data.map { |row| FarMar::Product.new(row) }
      end
      @@products
    end

    def self.find(id)
      self.all.find { |product| product.id == id }
    end

  end

end
