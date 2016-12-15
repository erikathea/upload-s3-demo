require 'rails_helper'

RSpec.describe Post, :type => :model do
  let(:post) { create(:post_with_attachments) }
  subject { post }
  it { should validate_presence_of(:title) }
  it { should have_many(:pictures).dependent(:destroy).class_name(Picture) }
  it { should have_many(:attachments).dependent(:destroy).class_name(Attachment) }

  it 'should return content_preview with length at most 80' do
    expect(post.content_preview.length).to be <= 80
  end
end
