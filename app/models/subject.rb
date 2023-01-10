class Subject < ApplicationRecord
    validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
end
