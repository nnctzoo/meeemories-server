class ElasticTranscoderClientBuilder
  def self.build
    if Rails.env.production?
      et = Aws::ElasticTranscoder::Client.new({
        region: Rails.configuration.x.aws.region
      })
    else
      et = Aws::ElasticTranscoder::Client.new({
        region: Rails.configuration.x.aws.region,
        access_key_id: ENV['ACCESS_KEY_ID'],
        secret_access_key: ENV['SECRET_ACCESS_KEY']
      })
    end
    return et
  end

end