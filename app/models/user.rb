# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  email           :string
#
class User < ApplicationRecord
    has_secure_password
    validates :email, uniqueness: true, presence: true, length: { maximum: 255 }
    validates :name, presence: true, length: { maximum: 20 }
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    has_many :study_records, dependent: :destroy
    has_many :favorites, dependent: :destroy
end
