class VideoTranscodingsController < ApplicationController
  def show
    @video_key = params.require(:id)
    @sources = Source.where("url like '%#{@video_key}%'")
    @complete = false
    if @sources.length > 0
      @complete = true
    end
    
    render :show, formats: :json
  end
end
