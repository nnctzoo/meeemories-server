class VideoTranscodingsController < ApplicationController
  def show
    @media = VideoTranscoding.find(params[:id])

    if !@media.pending? && @media.available?
      redirect_to video_path(@media.video.id) and return
    end
    render 'medias/show', formats: :json
  end
end
