class LeavesController < ApplicationController
  before_action :set_leaf
  before_action :set_quire

  def show
  end

  def new
    @leaf = @quire.leaves.build
  end

  def edit
  end

  # TODO update the redirects, as they still reflect redirecting like quires

  def create
    @leaf = @quire.leaves.build leaf_params

    if @leaf.save
      flash[:success] = "Leaf created successfully."
      redirect_to @quire
    else
      flash[:danger] = "Something went wrong."
      redirect_to new_quires_leaf_path(@quire)
    end
  end

  def update
    if @leaf.update(leaf_params)
      flash[:success] = "Leaf updated successfully."
      redirect_to @leaf.quire
    else
      flash[:danger] = "Something went wrong."
      redirect_to edit_quires_leaf_path(@quire)
    end
  end

  def destroy
    @leaf.destroy
    flash[:success] = "Leaf deleted successfully."
    redirect_to @leaf.quire
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_leaf
    @leaf = Leaf.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def leaf_params
    params.require(:leaf).permit(:single, :mode, :quire_id)
  end

  # the params return the :quire_id as the same value as the :id (leaf id)
  def set_quire
    @quire = @leaf.quire
    @quire = Quire.find(params[:quire_id])
  end
end

