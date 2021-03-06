require "test_helper"

describe CustomersController do
  describe "index" do
    it "is a real working route" do
      get customers_url
      must_respond_with :success
    end

    it "returns json" do
      get customers_url
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an Array" do
      get customers_url

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the customers" do
      get customers_url

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns empty array if there is no customers" do
      Customer.all.each do |customer|
        customer.rentals.each do |rental|
          rental.destroy
        end
        customer.destroy
      end

      get customers_url

      body = JSON.parse(response.body)
      body.must_equal []
      body.length.must_equal 0
    end

    it "returns customers with exactly the required fields" do
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)
      get customers_url
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal keys
      end
    end
  end
end
