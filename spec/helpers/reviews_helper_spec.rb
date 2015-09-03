require 'rails_helper'

RSpec.describe ReviewsHelper, type: :helper do
  describe '#star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'returns five black stars for 5' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end

    it 'returns 3 black stars and 2 white stars for 3' do
      expect(helper.star_rating(3)).to eq '★★★☆☆'
    end

    it 'returns 4 black stars and 1 white star for 3.5' do
      expect(helper.star_rating(3.5)).to eq '★★★★☆'
    end
  end
end
