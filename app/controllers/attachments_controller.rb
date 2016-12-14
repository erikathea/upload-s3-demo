class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:destroy]

  def index
    @attachments = Attachment.all
  end

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(s3_attachment_params)

    respond_to do |format|
      if @attachment.save
        format.json { render json: { url: @attachment.file_file_name, id: @attachment.id }, status: :created }
      else
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attachment.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    # TODO: find proper way of getting s3 object key
    def s3_attachment_params
      key  = params[:filepath][1..-1].dup.gsub!('%2F','/').split('/')
      key[2] = params[:filename]
      file = S3_BUCKET.object(key.join('/'))

      # make sure that we are saving the actual file uploaded
      return {} unless file

      { file_file_name:    key[2],
        stamp:             key[1],
        file_content_type: file.content_type,
        file_file_size:    file.content_length,
        file_updated_at:   file.last_modified }
    end
end
