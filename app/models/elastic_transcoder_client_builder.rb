class ElasticTranscoderClientBuilder
  def initialize
  end

  def build
    if Rails.env.production?
      return Aws::ElasticTranscoder::Client.new({
        region: Rails.configuration.x.aws.region
      })
    end

    return Aws::ElasticTranscoder::Client.new({
      region: Rails.configuration.x.aws.region,
      access_key_id: ENV['ACCESS_KEY_ID'],
      secret_access_key: ENV['SECRET_ACCESS_KEY']
    })
  end

end