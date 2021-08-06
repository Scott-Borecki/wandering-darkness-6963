class Garden < ApplicationRecord
  has_many :plots

  def plants
    plots.joins(plot_plants: :plant)
         .select('plants.*')
  end
end
