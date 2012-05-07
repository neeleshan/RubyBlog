class Micropost < ActiveRecord::Base
  attr_accessible :content
  validates :user_id, presence: true

  belongs_to :user

  validates :content, :length => { :maximum => 200 }

  default_scope order: 'microposts.created_at DESC'
end