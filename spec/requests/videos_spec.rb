require 'rails_helper'

describe 'videos' do
  describe 'POST /videos' do
    specify do
      job = create(:video_transcoding_job)

      expect {
        post '/videos', Message: JSON.generate({
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
        })
      }.to  change(Content, :count).by(1)
       .and change(Video, :count).by(1)
       .and change(Source, :count).by(3) # Video, Thumbnail, Resized thumbnail
    end
  end
end
