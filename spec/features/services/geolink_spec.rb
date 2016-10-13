require 'rails_helper'

AZ = 'https://www.amazon'

describe GeoLink do

  prod = FactoryGirl.build(:product, asin: 'aaaaaaaa12')
  review = FactoryGirl.build(:review, reviewfiable: prod)

  context 'when no country prefix is provided' do
    it 'should set to default US' do
      link = GeoLink.new('')
      expect(link.simple_link).to eq "#{AZ}.com"
    end
  end


  context 'when country_code IS NOT AVAILABLE ON AMAZON NETWORK' do
    it 'provides with the right link' do
      link = GeoLink.new('XYZ')
      message = link.simple_link
      expect(message).to eq "#{AZ}.com"
    end
  end

  context 'When a default review url is requested' do
    it 'returns a default url with asin in its link' do
      link = GeoLink.new('')
      message = link.review_url(review)
      expect(message).to eq "#{AZ}.com/dp/#{prod.asin}/"
    end
  end

  context 'When a url from Canada is requested' do
    it 'returns a link formatted for Canada' do
      link = GeoLink.new('CA')
      message = link.review_url(review)
      expect(message).to eq "#{AZ}.ca/dp/#{review.reviewfiable.asin}/"
    end
  end

  context 'When a url from China is requested' do
    it 'returns a link formatted for China' do
      link = GeoLink.new(GeoLink.get_country_code('China').to_s)
      message = link.review_url(review)
      expect(message).to eq "#{AZ}.cn/dp/#{review.reviewfiable.asin}/"
    end
  end

  context 'When a url from Mexico is requested' do
    it 'returns a link formatted for Mexico' do
      link = GeoLink.new(GeoLink.get_country_code('Mexico').to_s)
      message = link.review_url(review)
      expect(message).to eq "#{AZ}.com.mx/dp/#{review.reviewfiable.asin}/"
    end
  end


end