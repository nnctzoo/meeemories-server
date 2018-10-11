require 'rails_helper'

describe 'contents' do
  describe 'GET /contents' do
    context 'When no parameters' do
      specify do
        contents = create_list(:content, 3)
        get '/contents'

        body = JSON.parse(last_response.body)
        expect(body['contents'].count).to eq 3
        expect(body['contents'][0]['id']).to eq contents[2].id
        expect(body['contents'][1]['id']).to eq contents[1].id
        expect(body['contents'][2]['id']).to eq contents[0].id
      end
    end

    context 'When the parameter before is specified' do
      specify do
        contents = create_list(:content, 3)
        get '/contents', before: contents[2].id

        body = JSON.parse(last_response.body)
        expect(body['contents'].count).to eq 2
        expect(body['contents'][0]['id']).to eq contents[1].id
        expect(body['contents'][1]['id']).to eq contents[0].id
      end
    end
  end

  describe 'POST /contents' do
    specify do
      expect {
        post '/contents', file: fixture_file_upload('spec/data/ai_pet_family.png') # 800x604
      }.to  change(Content, :count).by(1)
       .and change(Picture, :count).by(1)
       .and change(Source, :count).by(4) # 20x, 200x, 400x, Original
    end
  end
end
