class ContentsController < ApplicationController
  def index
    @contents = Content.order(id: :desc).limit(20)
    @contents = @contents.where(Content.arel_table[:id].lt(params[:before].to_i)) if params[:before].present?

    render :index, formats: :json
  end

  def create
    file = params.require(:file)

    mime_type = FileMagic.new(:mime_type).file(file.path)
    case mime_type
    when /\Aimage\//
      picture = PictureCreator.new(file: file, mime_type: mime_type).run
      @detail = picture_path(picture)
    when /\Avideo\//
      @video_transcoding = VideoTranscoding.new(:file => file)
      if @video_transcoding.save
        create_transcoder_job(video_key: @video_transcoding.file.key)
      else
        # TODO: error handle
        logger.error(@video_transcoding.errors)
      end
    else
      head 400 and return
    end

    render :create, formats: :json
  end

  private
    # Create transcoder job
    def create_transcoder_job(video_key:)
      pipeline_id = ENV['AWS_ET_PIPELINE_ID']
      preset_id_system_web = Rails.configuration.x.aws.et_preset_id_system_web
      input_key = "#{video_key}"
      output_key = "transcode/#{video_key}.mp4"
      thumbnail_pattern = "transcode/#{video_key}-{count}"

      et = ElasticTranscoderClientBuilder.new().build
      response = et.create_job(
        pipeline_id: pipeline_id,
        input: {
          key: input_key,
          frame_rate: 'auto',
          resolution: 'auto',
          aspect_ratio: 'auto',
          interlaced: 'auto',
          container: 'auto'
        },
        output: {
          key: output_key,
          preset_id: preset_id_system_web,
          thumbnail_pattern: thumbnail_pattern,
          rotate: '0',
        }
      )

      return response
    end
end
