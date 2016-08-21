class ServicesController < ApplicationController

  def index
    @services = current_user.services
  end

  def new
    @service = current_user.services.new
  end

  def create
    @service = current_user.services.new(service_params)

    if @service.save
      NotificationWorker.perform_async(@service.id)
      flash[:success] = 'Service successfully added'
      redirect_to services_path
    else
      flash[:error] = @service.errors.full_messages
      render :new
    end
  end

  def edit
    @service = current_user.services.find(params[:id])
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

    redirect_to services_path
  end

private

  def service_params
    params.require(:service).permit(:name, :description, :notification_date, :frequency, :mobile_number, :custom_message)
  end

end
