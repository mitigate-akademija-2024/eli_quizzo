class Quiz < ApplicationRecord
    validates :title, :describtion, presence: true
end

