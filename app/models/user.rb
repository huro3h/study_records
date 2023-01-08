class User < ApplicationRecord
    has_secure_password
    validates :login_id, uniqueness: true, presence: true, length: { maximum: 255 }
    validates :name, presence: true, length: { maximum: 20 }
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
