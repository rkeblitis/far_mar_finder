module FarMar
  # Creates Product class using products.csv
  class Product
    attr_accessor :id, :name, :vendor_id

    def initialize(product_row)
      @id        = product_row[0].to_i
      @name      = product_row[1]
      @vendor_id = product_row[2].to_i
    end

    def self.all
      @products ||= make_product_instances
    end

    def self.make_product_instances
      product_data = CSV.read("support/products.csv")
      product_data.map { |row| FarMar::Product.new(row) }
    end

    def self.find(id)
      all.find { |product| product.id == id }
    end

    # returns the FarMar::Vendor instance that is associated with
    # this vendor using the FarMar::Product vendor_id field
    def vendor
      FarMar::Vendor.all.find { |vendor| vendor.id == @vendor_id }
    end

    # returns a collection of FarMar::Sale instances that are
    # associated using the FarMar::Sale product_id field.
    def sales
      FarMar::Sale.all.find_all { |sale| sale.product_id == @id }
    end

    # returns the number of times this product has been sold
    def number_of_sales
      sales.count
    end

    # returns all of the products with the given vendor_id
    def self.by_vendor(vendor_id)
      all.find_all { |product| product.vendor_id == vendor_id }
    end
  end
end
