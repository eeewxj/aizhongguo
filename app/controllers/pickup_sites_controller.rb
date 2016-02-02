class PickupSitesController < ApplicationController
  before_action :set_pickup_site, only: [:show, :edit, :update, :destroy]

  # GET /pickup_sites
  # GET /pickup_sites.json
  def index
    @pickup_sites = PickupSite.all
  end

  # GET /pickup_sites/1
  # GET /pickup_sites/1.json
  def show
  end

  # GET /pickup_sites/new
  def new
    @pickup_site = PickupSite.new
  end

  # GET /pickup_sites/1/edit
  def edit
  end

  # POST /pickup_sites
  # POST /pickup_sites.json
  def create
    @pickup_site = PickupSite.new(pickup_site_params)

    respond_to do |format|
      if @pickup_site.save
        format.html { redirect_to @pickup_site, notice: 'Pickup site was successfully created.' }
        format.json { render :show, status: :created, location: @pickup_site }
      else
        format.html { render :new }
        format.json { render json: @pickup_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pickup_sites/1
  # PATCH/PUT /pickup_sites/1.json
  def update
    respond_to do |format|
      if @pickup_site.update(pickup_site_params)
        format.html { redirect_to @pickup_site, notice: 'Pickup site was successfully updated.' }
        format.json { render :show, status: :ok, location: @pickup_site }
      else
        format.html { render :edit }
        format.json { render json: @pickup_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pickup_sites/1
  # DELETE /pickup_sites/1.json
  def destroy
    @pickup_site.destroy
    respond_to do |format|
      format.html { redirect_to pickup_sites_url, notice: 'Pickup site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pickup_site
      @pickup_site = PickupSite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pickup_site_params
      params.require(:pickup_site).permit(:name, :project_id, :liaison, :phone_number, :meeting_time)
    end
end
