class NotificationWorker
  include Sidekiq::Worker

  def perform(service_id)
    Notifications::NotifyUserWorker.perform_at(1.minutes.from_now, service_id)
    Notifications::NotifyServiceWorker.perform_at(6.minutes.from_now, service_id)
  end
end


