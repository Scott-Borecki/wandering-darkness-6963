require 'rails_helper'

RSpec.describe Garden do
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

  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'instance methods' do
    describe '#plants_by_harvest_time' do
      it 'returns the plants from the plots in the garden with no duplicates'\
         ' and only plants with less than given days to harvest'\
         ' and sorts by most plants that appear in the garden' do
        actual = garden1.plants_by_harvest_time(100).map(&:id)
        expected = [plant3.id, plant1.id]

        expect(actual).to eq(expected)

        actual = garden1.plants_by_harvest_time(30).map(&:name)
        expected = [plant1.name]

        expect(actual).to eq(expected)
      end
    end
  end
end
