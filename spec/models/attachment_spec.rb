require 'rails_helper'

RSpec.describe Attachment, :type => :model do
  let(:attachment) { create(:attachment) }
  subject { attachment }
  it { should validate_presence_of(:file) }
  it { should belong_to(:attachable) }

  it 'should validate_attachment_size(:file)' do
    expect(attachment.file_file_size).to be < Attachment::FILE_SIZE
  end
end
