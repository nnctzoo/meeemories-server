class ImagesController < ApplicationController
  # GET /images
  def index
    @images = Image.all()
    render json: @image
  end

  # POST /images
  def create
    @image = Image.new()
    @image.key = SecureRandom.hex(10)
    p "key:" + @image.key

    if @image.save
      # save resize iamge
      require 'mini_magick'
      img = MiniMagick::Image.read(params[:image][:image])
      img.resize "300"
      resize_file_name = "/tmp/" + @image.key + "_w300.png"
      img.write resize_file_name
      
      # upload resize image
      require 'aws-sdk-s3'
      bucket_name = 'meeemories-server-production'
      bucket = Aws::S3::Resource.new(
        :region => 'ap-northeast-1',
        :access_key_id => Rails.application.credentials.dig(:aws, :access_key_id),
        :secret_access_key => Rails.application.credentials.dig(:aws, :secret_access_key)
      ).bucket(bucket_name)
      
      object = bucket.object("out/" + @image.key + "_w300.png")
      object.put(:body   => File.open(resize_file_name))
      url = URI.parse(object.presigned_url(:get))
      p url

      # create source
      # @source = Source.create(:url => url,:width => 300, :image => @image.id)

      render json: @image, status: :created
    else
      reneder json: @video.errors, status: :unprocessable_entity
    end
  end

  private
    def image_params
      params.require(:image).permit(:image)
    end
  
end
