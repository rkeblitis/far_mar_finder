module FarMar
  class Product
    attr_accessor :id, :name, :vendor_id

    def initialize(product_row)
      @id         = product_row[0].to_i
      @name       = product_row[1]
      @vendor_id  = product_row[2].to_i
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

    #returns the FarMar::Vendor instance that is associated with
    #this vendor using the FarMar::Product vendor_id field
    def vendor
      FarMar::Vendor.all.find { |vendor| vendor.id == @vendor_id }
    end

    #returns a collection of FarMar::Sale instances that are
    #associated using the FarMar::Sale product_id field.
    def sales
      FarMar::Sale.all.find_all { |sale| sale.product_id == @id }
    end

    #returns the number of times this product has been sold
    def number_of_sales
      sales.map.count
    end

    #returns all of the products with the given vendor_id
    def self.by_vendor(vendor_id)
      self.all.find_all { |product| product.vendor_id == vendor_id }
    end

  end

end
