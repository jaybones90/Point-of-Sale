require "spec_helper"

describe(Product) do
  describe('#purchase') do
    it('will return all the purchases for a product') do
      test_purchase1 = Purchase.create
      test_product = Product.create(name: "candy", purchase_id: test_purchase1.id)
      expect(test_product.purchase).to(eq(test_purchase1))
    end
  end
end
