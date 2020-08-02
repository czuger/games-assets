class Photo < ApplicationRecord

  serialize :pic_localization

  has_and_belongs_to_many :tags

end
