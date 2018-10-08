class ContentsController < ApplicationController
  def index
    @contents = Content.all
    render :index, formats: :json
  end

  def show
    @content = Content.find(params.require(:id))
    render :show, formats: :json
  end

  def create
    file = params.require(:file)

    mimetype = FileMagic.new(:mime_type).file(file.path)
    case mimetype
    when /\Aimage\//
      # TODO
    when /\Avideo\//
      @video_transcoding = VideoTranscoding.new(:file => file)
      if @video_transcoding.save
        @media = Video.create
        @source = @media.sources.create({
          width: 0,
          height: 0,
          mime_type: mimetype
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
