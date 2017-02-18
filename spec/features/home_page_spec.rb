require 'rails_helper'
require 'features/pages/home_page'

RSpec.feature 'Weather Query Page' do
  let(:home_page) { HomePage.new }

  scenario 'information is in place', :js do
    expect(home_page).to have_selector('.container')
  end
end
