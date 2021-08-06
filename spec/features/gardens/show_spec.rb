require 'rails_helper'

RSpec.describe 'garden show page (/garden/:id)' do
  let!(:garden1) { Garden.create!(name: 'Echters Garden', organic: true) }
  let!(:garden2) { Garden.create!(name: 'Jims Garden', organic: false) }
  let!(:garden3) { Garden.create!(name: 'Harrys Garden', organic: true) }

  let!(:plot1) { garden1.plots.create!(number: 25, size: 'large', direction: 'east') }
  let!(:plot2) { garden1.plots.create!(number: 10, size: 'medium', direction: 'west') }
  let!(:plot3) { garden2.plots.create!(number: 7, size: 'small', direction: 'north') }

  let!(:plant1) { Plant.create!(name: 'Basil', description: 'Great on a pizza', days_to_harvest: 25) }
  let!(:plant2) { Plant.create!(name: 'Lettuce', description: 'Great for beginners', days_to_harvest: 25) }
  let!(:plant3) { Plant.create!(name: 'Bell Pepper', description: 'Great in a steak and cheese sub', days_to_harvest: 25) }
  let!(:plant4) { Plant.create!(name: 'Strawberry', description: 'Yummy!', days_to_harvest: 25) }
  let!(:plant5) { Plant.create!(name: 'Oregano', description: 'Grows like a weed', days_to_harvest: 25) }
  let!(:plant6) { Plant.create!(name: 'Thyme', description: 'bushy', days_to_harvest: 25) }

  let!(:plot1_plant3) {PlotPlant.create!(plot: plot1, plant: plant3) }
  let!(:plot1_plant4) {PlotPlant.create!(plot: plot1, plant: plant4) }
  let!(:plot2_plant1) {PlotPlant.create!(plot: plot2, plant: plant1) }
  let!(:plot2_plant3) {PlotPlant.create!(plot: plot2, plant: plant3) }
  let!(:plot3_plant5) {PlotPlant.create!(plot: plot3, plant: plant5) }
  let!(:plot3_plant6) {PlotPlant.create!(plot: plot3, plant: plant6) }
  let!(:plot3_plant4) {PlotPlant.create!(plot: plot3, plant: plant4) }

  describe 'as a visitor' do
    describe 'when I visit a gardens show page' do
      context 'when there are no plants' do
        before { visit garden_path(garden3) }

        it 'diplays no plants' do
          Plant.all.each do |plant|
            expect(page).to have_no_content(plant.name)
          end
        end
      end

      context 'when there are plants' do
        before { visit garden_path(garden1) }

        it 'displays a list of the plants that are in the gardens plots (with no duplicates)' do
          save_and_open_page
          plants = []
          garden1.plots.each do |plot|
            plants << plot.plants
          end

          plants.flatten.each do |plant|
            expect(page).to have_content(plant.name)
          end
        end
      end
    end
  end
end
