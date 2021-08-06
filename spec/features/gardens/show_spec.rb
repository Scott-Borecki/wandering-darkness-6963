require 'rails_helper'

RSpec.describe 'garden show page (/garden/:id)' do
  # See spec/object_creation_helper.rb for objects created for tests
  create_spec_objects

  describe 'test object creation' do
    it 'creates objects for the tests' do
      expect(Garden.all.size).to be_positive
      expect(Plot.all.size).to be_positive
      expect(Plant.all.size).to be_positive
      expect(PlotPlant.all.size).to be_positive
    end
  end

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
