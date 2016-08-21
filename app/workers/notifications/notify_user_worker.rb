class Notifications::NotifyUserWorker
  include Sidekiq::Worker

  def perform(service_id)
    service = Service.find(service_id)

    service.notify_user
  end
end
