class Book < ApplicationRecord
    belongs_to :user
	validates :title, presence: true,
                    length: { minimum: 5 }  
  mount_uploader :attachment, AttachmentUploader  
end
