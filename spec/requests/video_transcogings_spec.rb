require 'rails_helper'

describe 'video_transcodings' do
  describe 'GET /video_transcodings' do
    specify do
      transcoding = create(:video_transcoding)

      get "/video_transcodings/#{transcoding.id}"
      expect(last_response.status).to eq 200
    end
  end
end
