class AddStampToPicturesAndAttachments < ActiveRecord::Migration
  def change
    add_column :pictures, :stamp, :string
    add_column :attachments, :stamp, :string
  end

  def self.down
    remove_column :pictures, :stamp
    remove_column :attachments, :stamp
  end
end
