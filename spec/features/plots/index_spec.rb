require 'rails_helper'

RSpec.describe 'plots index page (/plots)' do
  let!(:garden1) { Garden.create!(name: 'Echters Garden', organic: true) }
  let!(:garden2) { Garden.create!(name: 'Jims Garden', organic: false) }
  let!(:garden3) { Garden.create!(name: 'Harrys Garden', organic: true) }

  let!(:plot1) { garden1.plots.create!(number: 25, size: 'large', direction: 'east') }
  let!(:plot2) { garden1.plots.create!(number: 10, size: 'medium', direction: 'west') }
  let!(:plot3) { garden1.plots.create!(number: 7, size: 'small', direction: 'north') }

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

  describe 'object creation' do
    specify { expect(Garden.all.count).to be_positive }
    specify { expect(Plot.all.count).to be_positive }
    specify { expect(Plant.all.count).to be_positive }
    specify { expect(PlotPlant.all.count).to be_positive }
  end

  describe 'as a visitor' do
    describe 'when I visit the plots index page (/plots)' do
      before { visit plots_path }
      specify { expect(current_path).to eq(plots_path) }

      it 'displays a list of all plot numbers and names of each plots plants' do
        within "#plot-#{plot1.id}" do
          expect(page).to have_content(plot1.number)
          expect(page).to have_content(plant3.name)
          expect(page).to have_content(plant4.name)

          expect(page).to have_no_content(plot2.number)
          expect(page).to have_no_content(plot3.number)
          expect(page).to have_no_content(plant1.name)
          expect(page).to have_no_content(plant2.name)
          expect(page).to have_no_content(plant5.name)
          expect(page).to have_no_content(plant6.name)
        end

        within "#plot-#{plot2.id}" do
          expect(page).to have_content(plot2.number)
          expect(page).to have_content(plant1.name)
          expect(page).to have_content(plant3.name)

          expect(page).to have_no_content(plot1.number)
          expect(page).to have_no_content(plot3.number)
          expect(page).to have_no_content(plant2.name)
          expect(page).to have_no_content(plant4.name)
          expect(page).to have_no_content(plant5.name)
          expect(page).to have_no_content(plant6.name)
        end

        within "#plot-#{plot3.id}" do
          expect(page).to have_content(plot3.number)
          expect(page).to have_content(plant4.name)
          expect(page).to have_content(plant5.name)
          expect(page).to have_content(plant6.name)

          expect(page).to have_no_content(plot1.number)
          expect(page).to have_no_content(plot2.number)
          expect(page).to have_no_content(plant1.name)
          expect(page).to have_no_content(plant2.name)
          expect(page).to have_no_content(plant3.name)
        end
      end

      describe 'next to each plants name' do
        it 'displays a link to remove that plant from the plot' do
          Plot.all.each do |plot|
            plot.plants.each do |plant|
              within "#pp-#{plot.id}-#{plant.id}" do
                expect(page).to have_link('Remove Plant from Plot')
              end
            end
          end
        end

        context 'before I click on the remove link' do
          it 'displays the plant in the plot' do
            within "#plot-#{plot1.id}" do
              expect(page).to have_content(plant3.name)
            end
          end
        end

        context 'after I click the remove link' do
          before do
            within "#pp-#{plot1.id}-#{plant3.id}" do
              click_link 'Remove Plant from Plot'
            end
          end

          it 'returns me to the plots index page' do
            expect(current_path).to eq(plots_path)
          end

          it 'no longer displays the removed plant in the plot' do
            within "#plot-#{plot1.id}" do
              expect(page).to have_no_content(plant3.name)
            end
          end
        end
      end
    end
  end
end
