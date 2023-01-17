# == Schema Information
#
# Table name: favorites
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  follower_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_favorites_on_follower_id              (follower_id)
#  index_favorites_on_user_id                  (user_id)
#  index_favorites_on_user_id_and_follower_id  (user_id,follower_id) UNIQUE
#
class Favorite < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :follower, class_name: 'User'
end
