class ContentsController < ApplicationController
  def index
    @contents = Content.order(id: :desc).limit(20)
    @contents = @contents.where(Content.arel_table[:id].gt(params[:after].to_i)) if params[:after].present?

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
      # TODO
    else
      head 400 and return
    end

    render :create, formats: :json
  end
end
