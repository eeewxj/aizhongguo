class NursingsController < ApplicationController
  before_action :set_nursing, only: [:show, :edit, :update, :destroy]

  # GET /nursings
  # GET /nursings.json
  def index
    @nursings = Nursing.all
  end

  # GET /nursings/1
  # GET /nursings/1.json
  def show
  end

  # GET /nursings/new
  def new
    @nursing_home = NursingHome.find(params[:nursing_home_id])
    @nursing = @nursing_home.nursings.build
  end

  # GET /nursings/1/edit
  def edit
  end

  # POST /nursings
  # POST /nursings.json
  def create
    @nursing = Nursing.new(nursing_params)

    respond_to do |format|
      if @nursing.save
        format.html {  render "_ajax_form", layout: false, notice: 'Nursing was successfully created.' }
        format.json { render :show, status: :created, location: @nursing }
      else
        format.html { render :new }
        format.json { render json: @nursing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nursings/1
  # PATCH/PUT /nursings/1.json
  def update
    respond_to do |format|
      if @nursing.update(nursing_params)
        format.html {  render "_ajax_form", layout: false, notice: 'Nursing was successfully updated.' }
        format.json { render :show, status: :ok, location: @nursing }
      else
        format.html { render :edit }
        format.json { render json: @nursing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nursings/1
  # DELETE /nursings/1.json
  def destroy
    @nursing.destroy
    respond_to do |format|
      format.html { redirect_to nursings_url, notice: 'Nursing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nursing
      @nursing = Nursing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nursing_params
      params.require(:nursing).permit(:nurse_id, :resident_id)
    end
end
