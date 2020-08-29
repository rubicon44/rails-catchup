class Goal < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :user, optional: true
end
