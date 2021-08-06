class Garden < ApplicationRecord
  has_many :plots

  def plants_by_harvest_time(days = 100)
    plots.joins(plot_plants: :plant)
         .select('plants.*, count(plot_plants.id) AS plant_count')
         .where('plants.days_to_harvest < ?', days)
         .group('plants.id')
         .order('plant_count desc')
         .distinct
  end
end
