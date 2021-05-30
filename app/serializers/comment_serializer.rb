class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user, :image, :text, :replies, :created_at

  def replies
    self.object.replies
  end

  def user
    {
      user_id: self.object.user.id,
      name: self.object.user.name,
    }
  end

  def image
    {
      image_id: self.object.image.id,
    }
  end
end
