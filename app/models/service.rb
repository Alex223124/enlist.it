class Service < ApplicationRecord
  FREQUENCY = %w( daily weekly monthly )

  belongs_to :user

  validates :name, :notification_date, :mobile_number, presence: true
  validates :frequency, presence: true, inclusion: { in: FREQUENCY }
  validates :description, presence: true, length: { maximum: 140 }
  validates :custom_message, length: { maximum: 140 }
end
