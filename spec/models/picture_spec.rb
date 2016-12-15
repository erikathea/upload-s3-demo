require 'rails_helper'

RSpec.describe Picture, :type => :model do
  let(:picture) { create(:picture) }
  subject { picture }
  it { should validate_presence_of(:image) }
  it { should belong_to(:imageable) }

  it 'should validate_attachment_file_type(:image)' do
    expect(Picture::CONTENT_TYPE.include?(picture.image_content_type)).to be true
  end

  it 'should validate_attachment_size(:image)' do
    expect(picture.image_file_size).to be < Picture::IMAGE_SIZE
  end

  it 'should return a name with length at most 30' do
    expect(picture.name.length).to be <= 30
  end
end
