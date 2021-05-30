class Comment < ApplicationRecord
  belongs_to :image
  belongs_to :user
  belongs_to :parent, class_name: "Comment", foreign_key: :comment_id, optional: true
  has_many :replies, class_name: "Comment", foreign_key: :comment_id, dependent: :destroy

  def self.create_comment(comment_params, current_user)
    comment = Comment.new({
      user_id: current_user[:id],
      text: comment_params[:text],
      image_id: comment_params[:image_id],
    })
    if (comment_params[:comment_id])
      comment.comment_id = comment_params[:comment_id]
    end
    comment.save!
    return comment
  end
end
