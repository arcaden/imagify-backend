class ImageSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :tags, :created_at, :img_url, :public_view

  def img_url
    if self.object.img_file.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.object.img_file, only_path: true)
    else 
      nil
    end 
  end
end
