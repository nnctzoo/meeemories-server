require 'rails_helper'

describe 'pictures' do
  describe 'GET /pictures/:id' do
    specify do
      picture = create(:picture, :with_sources)

      get "/pictures/#{picture.id}"
      expect(last_response.status).to eq 200
    end
  end
end
