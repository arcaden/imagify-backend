class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :img_file

  scope :by_title, ->(title) { where("title ILIKE ? AND public_view = true", "%#{title}%") }
  scope :by_user, ->(user) { where("user_id = ? AND public_view = true", user) }
  scope :by_tag, ->(tags) { where("tags @> ARRAY[?]::varchar[] AND public_view = true", tags) }

  def self.create_image(image_params, current_user)
    image = Image.new({
      user_id: current_user[:id],
      title: image_params[:title],
      tags: image_params[:tags],
      description: image_params[:description],
      public_view: image_params[:public_view],
    })
    image.img_file.attach(image_params[:img_file])
    image.save!
    return image
  end

  def self.search_image(search_params)
    images = []
    case search_params[:search_by]
    when "title"
      images = Image.by_title(search_params[:search_value]).order(created_at: :desc)
    when "user"
      images = Image.by_user(search_params[:search_value]).order(created_at: :desc)
      return images
    when "tag"
      images = Image.by_tag(search_params[:search_value]).order(created_at: :desc)
    end
    return images
  end
end
