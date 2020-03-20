class LeavesController < ApplicationController
  before_action :set_quire, only: [:new, :create, :show]
  before_action :set_leaf, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @leaf = @quire.leaves.build
  end

  def edit
  end

  def create
    @leaf = @quire.leaves.build leaf_params

    if @leaf.save
      flash[:success] = "Leaf created successfully."
      redirect_to @quire.manuscript
    else
      flash[:danger] = "Something went wrong."
      redirect_to new_quires_leaf_path(@quire)
    end
  end

  def update
    if @leaf.update(leaf_params)
      flash[:success] = "Leaf updated successfully."
      redirect_to @quire.manuscript
    else
      flash[:danger] = "Something went wrong."
      redirect_to edit_quires_leaf_path(@quire)
    end
  end

  def destroy
    @leaf.destroy
    flash[:success] = "Leaf deleted successfully."
    redirect_to @quire.manuscript
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_leaf
    @leaf = Leaf.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def leaf_params
    params.require(:leaf).permit(:leaf_count)
  end

  def set_manuscript
    @manuscript = Manuscript.find(params[:manuscript_id])
  end
end

