class TranscoderClientBuilder
  attr_reader :transcoder

  def initialize
    if Rails.env == 'production'
      @transcoder = Aws::ElasticTranscoder::Client.new({
        region: Rails.configuration.x.aws.region
      })
    end

    @transcoder = Aws::ElasticTranscoder::Client.new({
      region: Rails.configuration.x.aws.region,
      access_key_id: ENV['ACCESS_KEY_ID'],
      secret_access_key: ENV['SECRET_ACCESS_KEY']
    })
  end

end