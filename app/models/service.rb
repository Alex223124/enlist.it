class Service < ApplicationRecord
  FREQUENCY = %w( daily weekly monthly )

  belongs_to :user

  validates :name, :notification_date, :mobile_number, presence: true
  validates :frequency, presence: true, inclusion: { in: FREQUENCY }
  validates :description, presence: true, length: { maximum: 140 }
  validates :custom_message, length: { maximum: 140 }

  def notify_service
    message = custom_message.empty? ? "I need a #{name}" : custom_message
    client = Chikka::Client.new(client_id: "#{Rails.application.secrets.chikka_client_id}",
                                secret_key: "#{Rails.application.secrets.chikka_secret_key}",
                                shortcode: "#{Rails.application.secrets.chikka_shortcode}")
    client.send_message(message: message, mobile_number: mobile_number)
  end

  def notify_user
    message = "You are running out of #{name}, but don't worry I will order it for you in the next five days."
    client = Chikka::Client.new(client_id: "#{Rails.application.secrets.chikka_client_id}",
                                secret_key: "#{Rails.application.secrets.chikka_secret_key}",
                                shortcode: "#{Rails.application.secrets.chikka_shortcode}")
    client.send_message(message: message, mobile_number: user.mobile_number)
  end
end
