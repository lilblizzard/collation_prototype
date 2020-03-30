class QuiresController < ApplicationController
  before_action :set_manuscript, only: [:new, :create, :show]
  before_action :set_quire, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @quire = @manuscript.quires.build
  end

  def edit
  end

  def create
    @quire = @manuscript.quires.build(quire_params)

    if @quire.save
      flash[:success] = "Quire created successfully."
      redirect_to @manuscript
    else
      flash[:danger] = "Something went wrong."
      redirect_to new_manuscript_quire_path(@manuscript)
    end
  end

  def update
    if @quire.update(quire_params)
      flash[:success] = "Quire updated successfully."
      redirect_to @quire.manuscript
    else
      flash[:danger] = "Something went wrong."
      redirect_to edit_manuscript_quire_path(@manuscript)
    end
  end

  def destroy
    @quire.destroy
    flash[:success] = "Quire deleted successfully."
    redirect_to @quire.manuscript
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quire
    @quire = Quire.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def quire_params
    params.require(:quire).permit(:leaf_count)
  end

  def set_manuscript
    @manuscript = Manuscript.find(params[:manuscript_id])
  end
end
