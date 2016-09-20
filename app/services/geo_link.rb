class GeoLink

  STARTING_LINK = 'https://www.amazon'
  $country_suffix = {
      DE: '.de',
      IT: '.it',
      BR: '.com.br',
      IN: '.in',
      GB: '.co.uk',
      MX: '.com.mx',
      FR: '.fr',
      ES: '.es',
      CN: '.cn',
      JP: '.co.jp',
      AU: '.com.au',
      NL: '.nl',
      CA: '.ca',
      US: '.com'
  }

  $country_hash = {
      DE: '21',
      IT: '21',
      BR: '20',
      IN: '20',
      GB: '21',
      MX: '20',
      FR: '21',
      ES: '21',
      CN: '23',
      JP: '22',
      AU: '20',
      NL: '20',
      CA: '20',
      US: '20'
  }


  def initialize(country_code)
    @country_code = country_code.to_s.upcase
  end

  def simple_link
    if $country_suffix.key? @country_code.to_sym
      "#{STARTING_LINK}#{$country_suffix[@country_code.to_sym]}"
    else
      "#{STARTING_LINK}.com"
    end
  end

  def review_url(review)
    "#{simple_link}/dp/#{review.reviewfiable.asin}/"
  end

  def affiliate_url(review)
    "#{review_url(review)}?tag=#{review.affiliate_tag}-#{suffix_code(review)}"
  end

  def self.get_country_name(country_code = 'US')
    ISO3166::Country[country_code].name || nil
  end

  def self.get_country_code(country_name = 'United States')
    if country_name == 'Spain'
      return 'ES'
    elsif country_name == 'China'
      return 'CN'
    elsif country_name == 'Japan'
      return 'JP'
    else
      ISO3166::Country.find_country_by_name(country_name).gec || 'US'
    end
  end

  def self.get_country_code_raw(country_name = 'United States')
    ISO3166::Country.find_country_by_name(country_name).gec || 'US'
  end

  private
  def suffix_code(review)
    user_affiliate_countries = User.find_by(id: review.reviewer_id).affiliate_countries.to_s.split(',')
    user_affiliate_countries.each do |country|
      user_country_code = GeoLink.get_country_code(country)
      if user_country_code == @country_code
        return $country_hash[@country_code.to_sym]
      end
    end
    '20'
  end

end

#METHODS

#simple_link i.e amazon.ca/co.br

#review_url => amazon.ca/dp/31293923792

#affiliate_url => amazon.ca/dp/dadadadad?tag=aasas-20/sasa-21