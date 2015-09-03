require 'rails_helper'

RSpec.describe ReviewsHelper, type: :helper do
  context '#star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end
  end
end
