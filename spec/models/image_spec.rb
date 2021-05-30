require "rails_helper"

RSpec.describe Image, :type => :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:image1) { create(:image, user_id: user1.id, title: "Testing search title", tags: ["nature", "green", "red"]) }
  let(:image2) { create(:image, user_id: user2.id) }
  before(:all) do
  end  

  it "creates an image given valid params" do
    image_params = {
      title: "A valid title",
      description: "A really cool picture",
      tags: ["cool", "weather", "tag3"],
      public_view: true
    }
    image2 = Image.create_image(image_params, user1)
    result = Image.where(title: "A valid title").count
    expect(result).to eq(1)
  end

  it "searches by user" do
    expected_id = image1.id

    search_params = {
      search_by: "user",
      search_value: user1.id
    }
    result = Image.search_image(search_params)
    expect(result[0].id).to eq(expected_id)
  end

  it "searches by title" do
    expected_id = image1.id
    search_params = {
      search_by: "title",
      search_value: image1.title
    }
    result = Image.search_image(search_params)
    expect(result[0].id).to eq(expected_id)
  end

  it "searches by tag" do
    expected_id = image1.id
    search_params = {
      search_by: "tags",
      search_value: "red"
    }
    result = Image.search_image(search_params)
    expect(result[0].id).to eq(expected_id)
  end
end