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

    if @manuscript.save
      flash[:success] = "Manuscript created successfully."
      redirect_to @manuscript
    else
      flash[:danger]
      redirect_to new_manuscript_path
    end
  end

  # PATCH/PUT /manuscripts/1
  # PATCH/PUT /manuscripts/1.json
  def update
    if @manuscript.update(manuscript_params)
      flash[:success] = "Manuscript updated successfully."
      redirect_to @manuscript
    else
      flash[:danger] = "Something went wrong..."
      redirect_to edit_manuscript_path(@manuscript)
    end
  end

  # DELETE /manuscripts/1
  # DELETE /manuscripts/1.json
  def destroy
    @manuscript.destroy
    flash[:success] = "Manuscript deleted successfully."
      redirect_to manuscripts_url
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
