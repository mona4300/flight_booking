module Admins
  class AeroplaneClassesController < ApplicationController
    before_action :set_aeroplane
    before_action :set_aeroplane_class, only: %i[edit update destroy]
    before_action :check_changing_ability

    helper_method :resource_klass

    # GET /aeroplane_classes/new
    def new
      @aeroplane_class = @aeroplane.aeroplane_classes.build
    end

    # GET /aeroplane_classes/1/edit
    def edit; end

    # POST /aeroplane_classes or /aeroplane_classes.json
    def create
      @aeroplane_class = @aeroplane.aeroplane_classes.build(aeroplane_class_params)

      if @aeroplane_class.save
        redirect_to admins_aeroplane_url(@aeroplane),
                    notice: success_message(resource_klass, :create)
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /aeroplane_classes/1 or /aeroplane_classes/1.json
    def update
      if @aeroplane_class.update(aeroplane_class_params)
        redirect_to admins_aeroplane_url(@aeroplane_class.aeroplane),
                    notice: success_message(resource_klass, :update)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /aeroplane_classes/1 or /aeroplane_classes/1.json
    def destroy
      @aeroplane_class.destroy
      redirect_to admins_aeroplane_url,
                  notice: success_message(resource_klass, :destroy)
    end

    private

    def resource_klass
      AeroplaneClass
    end

    def check_changing_ability
      return true unless @aeroplane.flights?

      redirect_to(
        admins_aeroplane_url(@aeroplane),
        error: t('admins.aeroplanes.errors.flights_exists')
      )
    end

    def set_aeroplane
      @aeroplane = Aeroplane.find(params[:aeroplane_id])
      @breadcrumbs[:aeroplane] = { id: @aeroplane.id, name: @aeroplane.name }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_aeroplane_class
      @aeroplane_class = AeroplaneClass.find(params[:id])
      @breadcrumbs[:aeroplane_class] = { id: @aeroplane_class.id, name: @aeroplane_class.name }
    end

    # Only allow a list of trusted parameters through.
    def aeroplane_class_params
      params.require(:aeroplane_class).permit(:category, :rows_number, :seats_per_row, :seat_price, :position)
    end

    def aeroplane_id_param
      params.require(:aeroplane_class).fetch(:aeroplane_id)
    end
  end
end
