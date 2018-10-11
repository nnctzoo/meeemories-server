class VideoController < ApplicationController
  def create
    if request.headers['x-amz-sns-message-type'] == 'SubscriptionConfirmation'
      @subscribe_url = params.permit(:SubscribeURL)
      logger.debug "Subscribe URL: #{@subscribe_url}"
      render json: {}, status: 200
    elsif request.headers['x-amz-sns-message-type'] == 'Notification'
      @result = JSON.parse(params.permit(:Message)[:Message])['outputs'][0]

      @media = Video.create
      # video source
      @media.sources.create({
        width: @result[:width],
        height: @result[:height],
        mime_type: 'video/mp4',
        url: "#{Rails.configuration.x.aws.s3_url}/#{@result[:key]}"
      })
      # thumbnail source
      thumb = @result[:thumbnailPattern].gsub(/\{count\}/,'00001')
      @media.sources.create({
        width: @result[:width],
        height: @result[:height],
        mime_type: 'image/png',
        url: "#{Rails.configuration.x.aws.s3_url}/#{thumb}.png"
      })

      @content = Content.new
      @content.media = @media
      @content.save
      
      render :create, formats: :json
    else
      render json: {}, status: 400
    end
  end
end