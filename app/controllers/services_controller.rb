class ServicesController < ApplicationController
  layout 'dashboard'

  def index
    @services = current_user.services
    @service = Service.new(user: current_user)
  end

  def create
    @service = current_user.services.new(service_params)

    if @service.save
      NotificationWorker.perform_async(@service.id)
      flash[:success] = 'Service successfully added'
      redirect_to services_path
    else
      flash[:error] = @service.errors.full_messages
      redirect_to services_path
    end
  end

  def update
    @service = current_user.services.find(params[:id])

    if @service.update(service_params)
      flash[:success] = 'Service successfully updated'
      redirect_to services_path
    else
      flash[:error] =  @service.errors.full_messages
      render :edit
    end
  end

  def destroy
    @service = current_user.services.find(params[:id])
    @service.destroy
    flash[:success] = 'Service successfully deleted'
    redirect_to services_path
  end

private

  def service_params
    params.require(:service).permit(:name, :description, :notification_date, :frequency, :mobile_number, :custom_message)
  end

end
