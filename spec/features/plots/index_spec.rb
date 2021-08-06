require 'rails_helper'

RSpec.describe 'plots index page (/plots)' do
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
    describe 'when I visit the plots index page (/plots)' do
      before { visit plots_path }
      specify { expect(current_path).to eq(plots_path) }

      it 'displays a list of all plot numbers and names of each plots plants' do
        within "#plot-#{plot1.id}" do
          expect(page).to have_content("Plot Number: #{plot1.number}")
          expect(page).to have_content(plant3.name)
          expect(page).to have_content(plant4.name)

          expect(page).to have_no_content("Plot Number: #{plot2.number}")
          expect(page).to have_no_content("Plot Number: #{plot3.number}")
          expect(page).to have_no_content(plant1.name)
          expect(page).to have_no_content(plant2.name)
          expect(page).to have_no_content(plant5.name)
          expect(page).to have_no_content(plant6.name)
        end

        within "#plot-#{plot2.id}" do
          expect(page).to have_content("Plot Number: #{plot2.number}")
          expect(page).to have_content(plant1.name)
          expect(page).to have_content(plant3.name)

          expect(page).to have_no_content("Plot Number: #{plot1.number}")
          expect(page).to have_no_content("Plot Number: #{plot3.number}")
          expect(page).to have_no_content(plant2.name)
          expect(page).to have_no_content(plant4.name)
          expect(page).to have_no_content(plant5.name)
          expect(page).to have_no_content(plant6.name)
        end

        within "#plot-#{plot3.id}" do
          expect(page).to have_content("Plot Number: #{plot3.number}")
          expect(page).to have_content(plant4.name)
          expect(page).to have_content(plant5.name)
          expect(page).to have_content(plant6.name)

          expect(page).to have_no_content("Plot Number: #{plot1.number}")
          expect(page).to have_no_content("Plot Number: #{plot2.number}")
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

          it 'still displays the removed plant in other plots' do
            within "#plot-#{plot2.id}" do
              expect(page).to have_content(plant3.name)
            end
          end
        end
      end
    end
  end
end
