require "spec_helper"

describe(Purchase) do
  describe('#products') do
    it("will return all the products") do
      test_purchase = Purchase.create
      test_product = Product.create(name: "Thing", purchase_id: test_purchase.id)
      test_product2 =  Product.create({name: "Jimbo", purchase_id: test_purchase.id})
      expect(test_purchase.products).to(eq([test_product, test_product2]))
    end
  end
end
