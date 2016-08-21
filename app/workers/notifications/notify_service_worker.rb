class Notifications::NotifyServiceWorker
  include Sidekiq::Worker

  def perform(service_id)
    service = Service.find(service_id)

    service.notify_service

    NotificationWorker.perform_async(service_id)
  end
end
