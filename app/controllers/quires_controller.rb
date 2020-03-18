class QuiresController < ApplicationController
  before_action :set_manuscript, only: [:new, :create, :show]
  before_action :set_quire, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @quire = Quire.new
  end

  def edit
  end

  def create
    @quire = @manuscript.quires.build(quire_params)

    respond_to do |format|
      if @quire.save
        format.html { redirect_to @manuscript, notice: 'Quire was successfully created.'}
        format.json { render :'manuscripts/show', status: :created, location: @quire}
      else
        format.html { render :'quires/new'}
        format.json { render json: @quire.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @quire.update(quire_params)
        format.html { redirect_to @manuscript, notice: 'Quire was successfully updated.' }
        format.json { render :'manuscripts/show', status: :ok, location: @quire }
      else
        format.html { render :edit }
        format.json { render json: @quire.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quire.destroy
    respond_to do |format|
      format.html { redirect_to @manuscript, notice: 'Quire was successfully destroyed.' }
      format.json { head :no_content }
    end
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
