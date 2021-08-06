class PlantsController < ApplicationController
  def destroy
    if params[:plot_id]
      plot_plant = PlotPlant.find_by(plot: params[:plot_id], plant: params[:id])
      plot_plant.destroy!

      redirect_to plots_path
    end
  end
end
