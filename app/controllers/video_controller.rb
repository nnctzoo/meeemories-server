class VideoController < ApplicationController
  def create
    @result = params.require(:outputs)[0].permit(:key, :thumbnailPattern, :width, :height)

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
  end
end