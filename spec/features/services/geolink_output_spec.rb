require 'rails_helper'

AZ = 'https://www.amazon'

#ca, us, uk, fr, br, nl, in, cn ,jp, it, es, de, mx

describe GeoLink do

  prod = FactoryGirl.build(:product, asin: 'aaaaaaaa12')
  review = FactoryGirl.build(:review, reviewfiable: prod)
  context 'when country_code is ca(Canada)' do
    it 'provides with the right link' do
      link = GeoLink.new('ca')
      message = link.simple_link
      expect(message).to eq "#{AZ}.ca"
    end
  end

  context 'when country_code is GB(United Kingdom)' do
    it 'provides with the right link' do
      link = GeoLink.new('GB')
      message = link.simple_link
      expect(message).to eq "#{AZ}.co.uk"
    end
  end

  context 'when country_code is GB(United Kingdom)' do
    it 'provides with the right link' do
      link = GeoLink.new('GB')
      message = link.simple_link
      expect(message).to eq "#{AZ}.co.uk"
    end
  end

  context 'when country_code is Fr(France)' do
    it 'provides with the right link' do
      link = GeoLink.new('FR')
      message = link.simple_link
      expect(message).to eq "#{AZ}.fr"
    end
  end

  context 'when country_code is JP(Japan)' do
    it 'provides with the right link' do
      link = GeoLink.new('JP')
      message = link.simple_link
      expect(message).to eq "#{AZ}.co.jp"
    end
  end

  context 'when country_code is BR(Brazil)' do
    it 'provides with the right link' do
      link = GeoLink.new('BR')
      message = link.simple_link
      expect(message).to eq "#{AZ}.com.br"
    end
  end
end