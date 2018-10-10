require 'rails_helper'

describe 'contents' do
  describe 'GET /contents' do
    specify do
      create_list(:content, 3)

      get '/contents'
      expect(last_response.status).to eq 200
    end
  end

  describe 'POST /contents' do
    specify do
      expect {
        post '/contents', file: fixture_file_upload('spec/data/ai_pet_family.png') # 800x604
      }.to  change(Content, :count).by(1)
       .and change(Picture, :count).by(1)
       .and change(Source,  :count).by(4) # 20x, 200x, 400x, Original

      expect(last_response.status).to eq 200
    end
  end
end
