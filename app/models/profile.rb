class AttachedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :attached, options) unless value.attached?
  end
end

class Profile < ApplicationRecord
  has_one_attached :picture
  validates :firstName, :lastName, :website, :location, presence: true
  validates :picture, attached: true
  enum location: [:US_East_Coast, :US_West_Coast, :US_Midwest, :US_South, :Asia, :Africa, :Australia_New_Zealand, :Europe, :Canada, :Carribean, :Central_America, :Mexico, :Middle_East, :South_America]
  enum orientation: [:LBTQ]
  enum religion: [:Agnostic, :Atheist, :Buddhist, :Christian, :Hindu, :Jewish, :Muslim, :Pagan, :Sikh, :Taoist]
  enum ethnicity: [:African_American_Black, :American_Indian_Alaska_Native, :Asian_American, :Hispanic_Latina, :Middle_Eastern, :Multiracial, :Native_Hawaiian_Pacific_Islander]
  enum typeOfWork: [:Illustrator, :Artist, :Influencer, :Content_Creator, :Writer, :Comic_Artist, :Photographer, :Blogger]
  enum fatCategory: [:Small_Fat, :Medium_Fat, :Infinifat]
end
