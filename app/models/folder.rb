class Folder < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  
  has_many :classifications, dependent: :destroy
  has_many :words, through: :classifications, source: :word
  
  def fold(word)
      self.classifications.find_or_create_by(word_id: word.id)
  end

  def unfold(word)
    classification = self.classifications.find_by(word_id: word.id)
    classification.destroy if classification
  end

  def fold?(word)
    self.words.include?(word)
  end
end
