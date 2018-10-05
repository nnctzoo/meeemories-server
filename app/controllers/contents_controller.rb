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

    case FileMagic.new(:mime_type).file(file.path)
    when /\Aimage\//
      # TODO
    when /\Avideo\//
      # TODO
    else
      head 400 and return
    end

    render :create, formats: :json
  end
end
