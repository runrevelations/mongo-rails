require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/v1/users").to route_to("users#index")
    end

  end
end
