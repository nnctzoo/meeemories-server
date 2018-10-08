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
        @media = Video.create
        @source = @media.sources.create({
          width: 0,
          height: 0,
          mime_type: mime_type
        })

        @content = Content.new
        @content.media = @media
        @content.save
      else
        # TODO: error handle
        logger.error(@video_transcoding.errors)
      end
    else
      head 400 and return
    end

    render :create, formats: :json
  end
end
