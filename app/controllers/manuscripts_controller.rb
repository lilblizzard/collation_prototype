class ManuscriptsController < ApplicationController
  before_action :set_manuscript, only: [:show, :edit, :update, :destroy]

  # GET /manuscripts
  # GET /manuscripts.json
  def index
    @manuscripts = Manuscript.all
  end

  # GET /manuscripts/1
  # GET /manuscripts/1.json
  def show
  end

  # GET /manuscripts/new
  def new
    @manuscript = current_account.manuscripts.build
  end

  # GET /manuscripts/1/edit
  def edit
  end

  # POST /manuscripts
  # POST /manuscripts.json
  def create
    @manuscript = current_account.manuscripts.build(manuscript_params)

    respond_to do |format|
      if @manuscript.save
        format.html { redirect_to @manuscript, notice: 'Manuscript was successfully created.' }
        format.json { render :show, status: :created, location: @manuscript }
      else
        format.html { render :new }
        format.json { render json: @manuscript.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manuscripts/1
  # PATCH/PUT /manuscripts/1.json
  def update
    respond_to do |format|
      if @manuscript.update(manuscript_params)
        format.html { redirect_to @manuscript, notice: 'Manuscript was successfully updated.' }
        format.json { render :show, status: :ok, location: @manuscript }
      else
        format.html { render :edit }
        format.json { render json: @manuscript.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manuscripts/1
  # DELETE /manuscripts/1.json
  def destroy
    @manuscript.destroy
    respond_to do |format|
      format.html { redirect_to manuscripts_url, notice: 'Manuscript was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_manuscript
    @manuscript = Manuscript.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def manuscript_params
    params.require(:manuscript).permit(:name, :shelfmark, :quire_count, :date)
  end
end
