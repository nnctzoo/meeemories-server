require 'rails_helper'

describe 'video_transcoding_errors' do
  describe 'POST /video_transcoding_errors' do
    specify do
      verifier = instance_double(Aws::SNS::MessageVerifier)
      allow(Aws::SNS::MessageVerifier).to receive(:new) { verifier }
      allow(verifier).to receive(:authentic?) { true }

      job = create(:video_transcoding_job)

      expect {
        post '/video_transcoding_errors', JSON.generate(
          Message: JSON.generate(
            state: 'ERROR',
            errorCode: 1000,
            messageDetails: 'Validation Error',
            jobId: job.key
          )
        ),
        {
          'CONTENT_TYPE' => 'application/json'
        }
      }.to change(VideoTranscodingError, :count).by(1)

      expect(job.video_transcoding).not_to be_pending
      expect(job.video_transcoding).not_to be_available
    end
  end
end
