class VideoTranscodingCreator
  SYSTEM_WEB_PRESET_ID = '1351620000001-000020'

  def initialize(file:)
    @file = file
  end

  def run
    ActiveRecord::Base.transaction do
      @transcoding = VideoTranscoding.create!(file: @file)

      response = elastic_transcoder.create_job(
        pipeline_id: ENV.fetch('AWS_ET_PIPELINE_ID'),
        input: {
          key: @transcoding.file.key,
          frame_rate: 'auto',
          resolution: 'auto',
          aspect_ratio: 'auto',
          interlaced: 'auto',
          container: 'auto'
        },
        output: {
          key: "video/#{@transcoding.file.key}.mp4",
          preset_id: SYSTEM_WEB_PRESET_ID,
          thumbnail_pattern: "video_thumbnail/#{@transcoding.file.key}-{count}",
          rotate: '0'
        }
      )
      @transcoding.create_video_transcoding_job!(key: response.job.id)
    end

    @transcoding
  end

  private

  def elastic_transcoder
    @elastic_transcoder ||=
      case Rails.env
      when 'test'
        Aws::ElasticTranscoder::Client.new(stub_responses: true)
      else
        Aws::ElasticTranscoder::Client.new(region: Rails.configuration.x.elastic_transcoder.region)
      end
  end
end
