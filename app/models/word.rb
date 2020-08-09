class Word < ApplicationRecord
  belongs_to :user
  
  validates :word, presence: true, length: { maximum: 255 }
  validates :definition, length: { maximum: 255 }
  validates :link, length: { maximum: 255 }
end
