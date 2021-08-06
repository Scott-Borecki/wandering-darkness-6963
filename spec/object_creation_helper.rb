def create_spec_objects
  # GARDENS
  let!(:garden1) { Garden.create!(name: 'Echters Garden', organic: true) }
  let!(:garden2) { Garden.create!(name: 'Jims Garden', organic: false) }
  let!(:garden3) { Garden.create!(name: 'Harrys Garden', organic: true) }

  # PLOTS - garden1
  let!(:plot1) { garden1.plots.create!(number: 25, size: 'large', direction: 'east') }
  let!(:plot2) { garden1.plots.create!(number: 10, size: 'medium', direction: 'west') }

  # PLOTS - garden2
  let!(:plot3) { garden2.plots.create!(number: 7, size: 'small', direction: 'north') }
  let!(:plot4) { garden2.plots.create!(number: 7, size: 'small', direction: 'north') }
  let!(:plot5) { garden2.plots.create!(number: 7, size: 'small', direction: 'north') }

  # PLANTS
  let!(:plant1) { Plant.create!(name: 'Basil', description: 'Great on a pizza', days_to_harvest: 25) }
  let!(:plant2) { Plant.create!(name: 'Lettuce', description: 'Great for beginners', days_to_harvest: 50) }
  let!(:plant3) { Plant.create!(name: 'Bell Pepper', description: 'Great in a steak and cheese sub', days_to_harvest: 44) }
  let!(:plant4) { Plant.create!(name: 'Strawberry', description: 'Yummy!', days_to_harvest: 110) }
  let!(:plant5) { Plant.create!(name: 'Oregano', description: 'Grows like a weed', days_to_harvest: 22) }
  let!(:plant6) { Plant.create!(name: 'Thyme', description: 'bushy', days_to_harvest: 80) }
  let!(:plant7) { Plant.create!(name: 'Rosemary', description: 'prickly', days_to_harvest: 72) }

  # PLOT PLANTS - garden1
  let!(:plot1_plant3) {PlotPlant.create!(plot: plot1, plant: plant3) }
  let!(:plot1_plant4) {PlotPlant.create!(plot: plot1, plant: plant4) } # days_to_harvest > 100
  let!(:plot2_plant1) {PlotPlant.create!(plot: plot2, plant: plant1) }
  let!(:plot2_plant3) {PlotPlant.create!(plot: plot2, plant: plant3) }

  # PLOT PLANTS - garden2
  let!(:plot3_plant4) {PlotPlant.create!(plot: plot3, plant: plant4) } # days_to_harvest > 100
  let!(:plot3_plant5) {PlotPlant.create!(plot: plot3, plant: plant5) }
  let!(:plot3_plant6) {PlotPlant.create!(plot: plot3, plant: plant6) }
  let!(:plot4_plant4) {PlotPlant.create!(plot: plot4, plant: plant4) } # days_to_harvest > 100
  let!(:plot4_plant5) {PlotPlant.create!(plot: plot4, plant: plant5) }
  let!(:plot5_plant5) {PlotPlant.create!(plot: plot5, plant: plant5) }
end
