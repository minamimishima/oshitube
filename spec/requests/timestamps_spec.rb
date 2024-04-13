require 'rails_helper'

RSpec.describe "Timestamps", type: :request do
  describe "GET /timestamps" do
    it "works! (now write some real specs)" do
      get timestamps_path
      expect(response).to have_http_status(200)
    end
  end
end
