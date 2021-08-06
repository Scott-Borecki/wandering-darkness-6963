require 'rails_helper'

RSpec.describe Garden do
  let!(:garden1) { Garden.create!(name: 'Echters Garden', organic: true) }
  let!(:garden2) { Garden.create!(name: 'Jims Garden', organic: false) }
  let!(:garden3) { Garden.create!(name: 'Harrys Garden', organic: true) }

  let!(:plot1) { garden1.plots.create!(number: 25, size: 'large', direction: 'east') }
  let!(:plot2) { garden1.plots.create!(number: 10, size: 'medium', direction: 'west') }
  let!(:plot3) { garden2.plots.create!(number: 7, size: 'small', direction: 'north') }

  let!(:plant1) { Plant.create!(name: 'Basil', description: 'Great on a pizza', days_to_harvest: 25) }
  let!(:plant2) { Plant.create!(name: 'Lettuce', description: 'Great for beginners', days_to_harvest: 50) }
  let!(:plant3) { Plant.create!(name: 'Bell Pepper', description: 'Great in a steak and cheese sub', days_to_harvest: 44) }
  let!(:plant4) { Plant.create!(name: 'Strawberry', description: 'Yummy!', days_to_harvest: 110) }
  let!(:plant5) { Plant.create!(name: 'Oregano', description: 'Grows like a weed', days_to_harvest: 22) }
  let!(:plant6) { Plant.create!(name: 'Thyme', description: 'bushy', days_to_harvest: 80) }

  let!(:plot1_plant3) {PlotPlant.create!(plot: plot1, plant: plant3) }
  let!(:plot1_plant4) {PlotPlant.create!(plot: plot1, plant: plant4) }
  let!(:plot2_plant1) {PlotPlant.create!(plot: plot2, plant: plant1) }
  let!(:plot2_plant3) {PlotPlant.create!(plot: plot2, plant: plant3) }
  let!(:plot3_plant5) {PlotPlant.create!(plot: plot3, plant: plant5) }
  let!(:plot3_plant6) {PlotPlant.create!(plot: plot3, plant: plant6) }
  let!(:plot3_plant4) {PlotPlant.create!(plot: plot3, plant: plant4) }

  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'instance methods' do
    describe '#plants_by_harvest_time' do
      it 'returns the plants from the plots in the garden (no duplicates)' do
        actual = garden1.plants_by_harvest_time(100).map(&:id)
        expected = [plant1.id, plant3.id]

        expect(actual).to eq(expected)

        actual = garden1.plants_by_harvest_time(30).map(&:name)
        expected = [plant1.name]

        expect(actual).to eq(expected)
      end
    end
  end
end
