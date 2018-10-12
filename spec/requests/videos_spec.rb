require 'rails_helper'

describe 'videos' do
  describe 'GET /videos/:id' do
    specify do
      video = create(:video)

      get "/videos/#{video.id}"
      expect(last_response.status).to eq 200
    end
  end

  describe 'POST /videos' do
    specify do
      verifier = instance_double(Aws::SNS::MessageVerifier)
      allow(Aws::SNS::MessageVerifier).to receive(:new) { verifier }
      allow(verifier).to receive(:authentic?) { true }

      job = create(:video_transcoding_job)

      expect {
        post '/videos', JSON.generate(
          Message: JSON.generate(
            state: 'COMPLETED',
            version: '2012-09-25',
            jobId: job.key,
            pipelineId: 'xxxxx',
            input: {
              key: 'xxxxx',
              frameRate: 'auto',
              resolution: 'auto',
              aspectRatio: 'auto',
              interlaced: 'auto',
              container: 'auto'
            },
            inputCount: 1,
            outputs: [{
              id: 1,
              presetId: 'xxxxx',
              key: 'xxxxx',
              thumbnailPattern: 'xxxxx-{count}',
              rotate: '0',
              status: 'Complete',
              duration: '10',
              width: 640,
              height: 480
            }]
          )
        ),
        {
          'CONTENT_TYPE' => 'application/json'
        }
      }.to  change(Content, :count).by(1)
       .and change(Video, :count).by(1)
       .and change(Source, :count).by(3) # Video, Thumbnail, Resized thumbnail

      expect(job.video_transcoding).not_to be_pending
      expect(job.video_transcoding).to be_available
    end
  end
end
