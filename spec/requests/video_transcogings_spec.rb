require 'rails_helper'

describe 'video_transcodings' do
  describe 'GET /video_transcoding/:id' do
    context 'When the transcoding is not completed' do
      specify do
        transcoding = create(:video_transcoding)

        get "/video_transcodings/#{transcoding.id}"
        expect(last_response.status).to eq 200
      end
    end

    context 'When the transcoding is completed' do
      specify do
        transcoding = create(:video_transcoding)
        video = create(:video, video_transcoding: transcoding)

        get "/video_transcodings/#{transcoding.id}"
        expect(last_response.status).to eq 302
      end
    end
  end
end
