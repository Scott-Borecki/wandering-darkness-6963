require 'rails_helper'

RSpec.describe 'garden show page (/garden/:id)' do
  let!(:garden1) { Garden.create!(name: 'Echters Garden', organic: true) }
  let!(:garden2) { Garden.create!(name: 'Jims Garden', organic: false) }
  let!(:garden3) { Garden.create!(name: 'Harrys Garden', organic: true) }

  let!(:plot1) { garden1.plots.create!(number: 25, size: 'large', direction: 'east') }
  let!(:plot2) { garden1.plots.create!(number: 10, size: 'medium', direction: 'west') }
  let!(:plot3) { garden2.plots.create!(number: 7, size: 'small', direction: 'north') }
  let!(:plot4) { garden2.plots.create!(number: 7, size: 'small', direction: 'north') }
  let!(:plot5) { garden2.plots.create!(number: 7, size: 'small', direction: 'north') }

  let!(:plant1) { Plant.create!(name: 'Basil', description: 'Great on a pizza', days_to_harvest: 25) }
  let!(:plant2) { Plant.create!(name: 'Lettuce', description: 'Great for beginners', days_to_harvest: 50) }
  let!(:plant3) { Plant.create!(name: 'Bell Pepper', description: 'Great in a steak and cheese sub', days_to_harvest: 44) }
  let!(:plant4) { Plant.create!(name: 'Strawberry', description: 'Yummy!', days_to_harvest: 110) }
  let!(:plant5) { Plant.create!(name: 'Oregano', description: 'Grows like a weed', days_to_harvest: 22) }
  let!(:plant6) { Plant.create!(name: 'Thyme', description: 'bushy', days_to_harvest: 80) }
  let!(:plant7) { Plant.create!(name: 'Rosemary', description: 'prickly', days_to_harvest: 72) }

  # garden1
  let!(:plot1_plant3) {PlotPlant.create!(plot: plot1, plant: plant3) }
  let!(:plot1_plant4) {PlotPlant.create!(plot: plot1, plant: plant4) } # days_to_harvest > 100
  let!(:plot2_plant1) {PlotPlant.create!(plot: plot2, plant: plant1) }
  let!(:plot2_plant3) {PlotPlant.create!(plot: plot2, plant: plant3) }

  # garden2
  let!(:plot3_plant4) {PlotPlant.create!(plot: plot3, plant: plant4) } # days_to_harvest > 100
  let!(:plot3_plant5) {PlotPlant.create!(plot: plot3, plant: plant5) }
  let!(:plot3_plant6) {PlotPlant.create!(plot: plot3, plant: plant6) }
  let!(:plot4_plant4) {PlotPlant.create!(plot: plot4, plant: plant4) } # days_to_harvest > 100
  let!(:plot4_plant5) {PlotPlant.create!(plot: plot4, plant: plant5) }
  let!(:plot5_plant5) {PlotPlant.create!(plot: plot5, plant: plant5) }

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
        it 'displays a list of the plants that are in the gardens plots '\
           'with no duplicates or plants greater than 100 days to harvest'\
           'and ordered by most plants in the garden' do
          # Test garden1
          visit garden_path(garden1)

          garden1.plants_by_harvest_time(100).each do |plant|
            expect(page).to have_content(plant.name)
          end

          expect(plant3.name).to appear_before(plant1.name)
          expect(page).to have_no_content(plant2.name)
          expect(page).to have_no_content(plant4.name)
          expect(page).to have_no_content(plant5.name)
          expect(page).to have_no_content(plant6.name)
          expect(page).to have_no_content(plant7.name)

          # Test garden2
          visit garden_path(garden2)

          garden2.plants_by_harvest_time(100).each do |plant|
            expect(page).to have_content(plant.name)
          end

          expect(plant5.name).to appear_before(plant6.name)
          expect(page).to have_no_content(plant1.name)
          expect(page).to have_no_content(plant2.name)
          expect(page).to have_no_content(plant3.name)
          expect(page).to have_no_content(plant4.name)
          expect(page).to have_no_content(plant7.name)
        end
      end
    end
  end
end
