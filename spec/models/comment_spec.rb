require "rails_helper"

RSpec.describe Image, :type => :model do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:image1) { create(:image, user_id: user1.id, title: "Testing search title", tags: ["nature", "green", "red"]) }
    let(:image2) { create(:image, user_id: user2.id) }
    let(:comment1) { create(:comment, user_id: user2.id, image_id: image1.id) }  

  it "creates a comment given valid params" do
    image_params = {
      text: "Wow this is a really cool comment on a picture",
      image_id: image1.id
    }
    comment = Comment.create_comment(image_params, user1)
    result = Comment.where(text: "Wow this is a really cool comment on a picture").first
    expect(result.id).to eq(comment.id)
  end

  it "creates a reply given valid params" do
    post = image1
    parent = comment1
    image_params = {
      text: "Wow this is a really cool reply on a comment",
      image_id: post.id,
      comment_id: parent.id
    }
    comment = Comment.create_comment(image_params, user1)
    result = Comment.where(text: "Wow this is a really cool reply on a comment").first
    expect(result.id).to eq(comment.id)
    expect(result.parent.id).to eq(parent.id)
  end
end