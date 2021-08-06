class Garden < ApplicationRecord
  has_many :plots

  def plants_by_harvest_time(days = 100)
    plots.joins(plot_plants: :plant)
         .select('plants.*')
         .where('plants.days_to_harvest < ?', days)
         .distinct
  end
end
