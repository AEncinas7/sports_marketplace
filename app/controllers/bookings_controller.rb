class BookingsController < ApplicationController
  def index
    @message = "None"
    begin
      @equipments = Equipment.where(user_id: current_user)
    rescue ActiveRecord::RecordNotFound 
      @equipments = []
    end
    
    @requests = []
    begin
      @equipments.each do |item|
        @requests << Booking.where( equipment_id: item.id, status: "pending" )
      end
    rescue ActiveRecord::RecordNotFound 
      @requests = []
    end
    
    begin
      @bookings = Booking.find(user_id: current_user)
    rescue ActiveRecord::RecordNotFound
      @bookings = []
    end
  end

  def create
    @equipment = Equipment.find(params[:equipment_id])
    @bookings = @equipment.bookings
    @booking = Booking.new(booking_params)

    @booking.equipment = @equipment
    @booking.user = current_user

    if @booking.save
      redirect_to equipment_path(@equipment)
    else
      render 'equipments/show'
    end
  end

  def update

  end

  private

  def booking_params
    params.require(:booking).permit(:date)
  end
end
