class PictureCreator
  S3_PREFIX = 'picture'
  RESIZED_SOURCE_SIZES = [20, 200, 400, 800]

  def initialize(file:, mime_type:)
    @file = file
    @mime_type = mime_type
  end

  def run
    ActiveRecord::Base.transaction do
      @picture = Picture.new
      @picture.generate_key
      @picture.save!

      s3.put_object(
        bucket: Rails.configuration.x.s3.bucket,
        key: "#{S3_PREFIX}/#{@picture.key}",
        body: @file,
        content_type: @mime_type
      )

      width, height = FastImage.size(@file.path)
      Source.create!(
        media: @picture,
        width: width,
        height: height,
        mime_type: @mime_type,
        url: Cloudinary::Utils.cloudinary_url("#{ENV.fetch('CLOUDINARY_FOLDER')}/picutre/#{@picture.key}")
      )
      RESIZED_SOURCE_SIZES.each do |resized_width|
        next if width <= resized_width

        ratio = resized_width.to_f / width
        Source.create!(
          media: @picture,
          width: resized_width,
          height: (height * ratio).to_i,
          mime_type: @mime_type,
          url: Cloudinary::Utils.cloudinary_url("#{ENV.fetch('CLOUDINARY_FOLDER')}/picture/#{@picture.key}",
            width: resized_width,
            crop: :scale
          )
        )
      end

      Content.create!(media: @picture)
    end

    @picture
  end

  private

  def s3
    @s3 ||=
      case Rails.env
      when 'test'
        Aws::S3::Client.new(stub_responses: true)
      else
        Aws::S3::Client.new(region: Rails.configuration.x.s3.region)
      end
  end
end
