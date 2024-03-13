class EsdasController < ApplicationController
  before_action :set_esda, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  # GET /esdas
  # GET /esdas.json
  def index
    @esdas = Esda.all
  end

  # GET /esdas/1
  # GET /esdas/1.json
  def show; end

  # POST /esdas
  # POST /esdas.json
  def create
    @esda = Esda.new(metadata: params.dig(:esda, :metadata))

    if @esda.save
      render :show, status: :created, location: @esda
    else
      render json: @esda.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /esdas/1
  # PATCH/PUT /esdas/1.json
  def update
    if @esda.update(esda_params)
      render :show, status: :ok, location: @esda
    else
      render json: @esda.errors, status: :unprocessable_entity
    end
  end

  # DELETE /esdas/1
  # DELETE /esdas/1.json
  def destroy
    @esda.destroy
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_esda
    @esda = Esda.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def esda_params
    params.require(:esda).permit(:metadata)
  end
end
