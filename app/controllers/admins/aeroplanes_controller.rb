module Admins
  class AeroplanesController < ApplicationController
    before_action :set_aeroplane, only: %i[show edit update destroy]
    before_action :check_changing_ability, only: %i[edit update destroy]

    # GET /aeroplanes or /aeroplanes.json
    def index
      @aeroplanes = Aeroplane.includes(:aeroplane_classes).all
    end

    # GET /aeroplanes/1 or /aeroplanes/1.json
    def show; end

    # GET /aeroplanes/new
    def new
      @aeroplane = Aeroplane.new
    end

    # GET /aeroplanes/1/edit
    def edit; end

    # POST /aeroplanes or /aeroplanes.json
    def create
      @aeroplane = Aeroplane.new(aeroplane_params)

      if @aeroplane.save
        redirect_to admins_aeroplane_url(@aeroplane), notice: "Aeroplane was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /aeroplanes/1 or /aeroplanes/1.json
    def update
      if @aeroplane.update(aeroplane_params)
        redirect_to admins_aeroplane_url(@aeroplane), notice: "Aeroplane was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /aeroplanes/1 or /aeroplanes/1.json
    def destroy
      @aeroplane.destroy

      redirect_to admins_aeroplanes_url, notice: "Aeroplane was successfully destroyed."
    end

    private

    def check_changing_ability
      return true unless @aeroplane.flights?

      redirect_to admins_aeroplane_url(@aeroplane), error: "Aeroplane has flights and couldn't be changed"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_aeroplane
      @aeroplane = Aeroplane.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def aeroplane_params
      params.require(:aeroplane).permit(:name)
    end
  end
end
