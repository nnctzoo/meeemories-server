require 'rails_helper'

describe 'contents' do
  describe 'GET /contents' do
    specify do
      create_list(:content, 3)

      get '/contents'
      expect(last_response.status).to eq 200
    end
  end

  describe 'GET /contents/:id' do
    specify do
      content = create(:content)

      get "/contents/#{content.id}"
      expect(last_response.status).to eq 200
    end
  end

  describe 'POST /contents' do
    xspecify do
      post '/contents', file: Rack::Test::UploadedFile.new('')
      expect(last_response.status).to eq 200
    end
  end
end
