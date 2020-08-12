class Word < ApplicationRecord
  belongs_to :user
  
  validates :word, presence: true, length: { maximum: 255 }
  validates :definition, length: { maximum: 255 }
  validates :link, length: { maximum: 255 }
  
  has_many :classifications, dependent: :destroy
  has_many :folders, through: :classifications, source: :folder
  
  def classify(folder)
      self.classifications.find_or_create_by(folder_id: folder.id)
  end

  def unclassify(folder)
    classification = self.classifications.find_by(folder_id: folder.id)
    classification.destroy if classification
  end

  def classify?(folder)
    self.folders.include?(folder)
  end
end
