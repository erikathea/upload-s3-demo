class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :destroy]

  def index
    @pictures = Picture.all
  end

  def show
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(s3_picture_params)

    respond_to do |format|
      if @picture.save
        format.json { render json: { url: @picture.image.url, id: @picture.id}, status: :created }
      else
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # TODO: find proper way of getting s3 object key
    def s3_picture_params
      key  = params[:filepath][1..-1].dup.gsub!('%2F','/').split('/')
      key[2] = params[:filename]
      pic = S3_BUCKET.object(key.join('/'))

      # make sure that we are saving the actual picture uploaded
      return {} unless pic

      { image_file_name:    key[2],
        stamp:              key[1],
        image_content_type: pic.content_type,
        image_file_size:    pic.content_length,
        image_updated_at:   pic.last_modified }
    end

end
