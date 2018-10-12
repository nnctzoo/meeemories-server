class VideoCreator
  VIDEO_MIME_TYPE = 'video/mp4'
  THUMBNAIL_MIME_TYPE = 'image/png'

  RESIZED_THUBMNAIL_WIDTHS = [20, 200, 400]

  CLOUDINARY_FOLDER = "#{ENV.fetch('CLOUDINARY_FOLDER_PREFIX')}/video_thumbnail"

  def initialize(message)
    @message = JSON.parse(message)
    @output = @message['outputs'][0]
  end

  def run
    verify_message!

    ActiveRecord::Base.transaction do
      job = VideoTranscodingJob.find_by!(key: @message['jobId'])
      @video = Video.create!(video_transcoding_id: job.video_transcoding_id)

      # Video
      @video.sources.create!(
        width: @output['width'],
        height: @output['height'],
        mime_type: VIDEO_MIME_TYPE,
        url: "#{Rails.configuration.x.cloudfront.host}/#{video_key}"
      )

      # Thumbnail
      @video.sources.create!(
        width: thumbnail_dimensions[0],
        height: thumbnail_dimensions[1],
        mime_type: THUMBNAIL_MIME_TYPE,
        url: Cloudinary::Utils.cloudinary_url("#{CLOUDINARY_FOLDER}/#{thumbnail_key}", secure: true)
      )

      # Resized thumbnail
      RESIZED_THUBMNAIL_WIDTHS.each do |resized_width|
        ratio = resized_width / thumbnail_dimensions[0].to_f
        @video.sources.create!(
          width: resized_width,
          height: (thumbnail_dimensions[1] * ratio).to_i,
          mime_type: THUMBNAIL_MIME_TYPE,
          url: Cloudinary::Utils.cloudinary_url("#{CLOUDINARY_FOLDER}/#{thumbnail_key}",
            width: resized_width,
            crop: :scale,
            secure: true
          )
        )
      end

      Content.create!(media: @video)
    end

    @video
  end

  private

  def verify_message!
    raise InvalidState if @message['state'] != 'COMPLETED'
  end

  def video_key
    @video_key ||= @output['key'].sub(/\Avideo\//, '')
  end

  def thumbnail_key
    @thumbnail_key ||=
      "#{@output['thumbnailPattern'].sub(/\Avideo_thumbnail\//, '').sub(/\{count\}/, '00001')}.png"
  end

  def thumbnail_dimensions
    # 480x854 (9:16)
    @thumbnail_dimensions ||=
      if (@output['width'] / 9.0) > (@output['height'] / 16.0)
        ratio = 480.0 / @output['width']
        [480, (@output['height'] * ratio).to_i]
      else
        ratio = 854.0 / @output['height']
        [(@output['width'] * ratio).to_i, 854]
      end
  end

  InvalidState = Class.new(StandardError)
end
