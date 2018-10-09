class ContentsController < ApplicationController
  def index
    @contents = Content.all
    render :index, formats: :json
  end

  def create
    file = params.require(:file)

    mime_type = FileMagic.new(:mime_type).file(file.path)
    case mime_type
    when /\Aimage\//
      PictureCreator.new(file: file, mime_type: mime_type).run
    when /\Avideo\//
      # TODO
    else
      head 400 and return
    end

    render :create, formats: :json
  end
end
