class AttachedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :attached, options) unless value.attached?
  end
end

class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :picture
  validates :firstName, :lastName, :website, :location, presence: true
  validates :picture, attached: true
end
