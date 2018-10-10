class PicturesController < ApplicationController
  def show
    @media = Picture.find(params[:id])
    render 'medias/show', formats: :json
  end
end
