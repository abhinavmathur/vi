class GeoLink

  AMAZON_LINK = 'https://www.amazon'
  $country_suffix = {
      IN: '.in',
      CN: '.cn',
      JP: '.co.jp',
      FR: '.fr',
      DE: '.de',
      IT: '.it',
      NL: '.nl',
      ES: '.es',
      UK: '.co.uk',
      CA: '.ca',
      MX: '.com.mx',
      US: '.com',
      AU: '.com.au',
      BR: '.com.br'
  }

  $country_hash = {
      DE: '21',
      IT: '21',
      BR: '20',
      IN: '20',
      UK: '21',
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

  def amazon_search_link(review,user)
    product_title = review.reviewfiable.title.split(' ').join('+')
    "#{simple_link}/s/?tag=#{review.affiliate_tag}-#{suffix_code(user)}&field-keywords=#{product_title}"
  end

  def affiliate_url(review,user)
    if amazon_url_present?(review)
      "#{review_url(review)}?tag=#{review.affiliate_tag}-#{suffix_code(user)}"
    else
      review.affiliate_link
    end
  end

  def self.construct_product_link(review)
    target_countries_array = ['']
    unless review.target_countries.nil?
      target_countries_array = review.target_countries.split(',')
    end
    user = User.where(id: review.reviewer_id).first
    affiliate_countries = user.affiliate_countries.split(',')
    affiliate_countries.each do |country_name|
      country_code = GeoLink.get_country_code(country_name)
      if target_countries_array.include?(country_name)
        return  GeoLink.new(country_code).amazon_search_link(review,user)
      else
        return  GeoLink.new(country_code).affiliate_url(review,user)
      end
    end

  end

  def self.construct_links_for(review)
    target_countries_array = ['']
    unless review.target_countries.nil?
      target_countries_array = review.target_countries.split(',')
    end
    user = User.where(id: review.reviewer_id).first
    affiliate_countries = user.affiliate_countries.split(',')
    countries_hash = Hash.new
    affiliate_countries.each do |country_name|
      country_code = GeoLink.get_country_code(country_name)
      unless target_countries_array.include?(country_name)
        countries_hash[country_name] = GeoLink.new(country_code).affiliate_url(review,user)
      else
        countries_hash[country_name] = GeoLink.new(country_code).amazon_search_link(review,user)
      end
    end
    countries_hash
  end



  def self.check_errors(review,user)
    affiliate_countries_size = 0
    unless user.affiliate_countries.nil?
      affiliate_countries_size = user.affiliate_countries.split(',').count
    end
    if affiliate_countries_size < 1
      return 'No Affiliate Country specified in User Settings'
    end
    if review.affiliate_link.present? && review.affiliate_tag.present?
      return 'Both affiliate link and tag cannot be present'
    end
    if review.reviewfiable.asin.present? && review.affiliate_tag == ''
      return 'No affiliate tag specified'
    end
    'None'
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
    elsif country_name == 'Australia'
      return 'AU'
    elsif country_name == 'Germany'
      return 'DE'
    else
      ISO3166::Country.find_country_by_name(country_name).gec || 'US'
    end
  end

  def self.get_country_code_raw(country_name = 'United States')
    ISO3166::Country.find_country_by_name(country_name).gec || 'US'
  end

  def amazon_url_present?(review)
    review.reviewfiable.asin.present?
  end

  private

  def simple_link
    if $country_suffix.key? @country_code.to_sym
      "#{AMAZON_LINK}#{$country_suffix[@country_code.to_sym]}"
    else
      "#{AMAZON_LINK}.com"
    end
  end

  def review_url(review)
    "#{simple_link}/dp/#{review.reviewfiable.asin}/"
  end

  def suffix_code(user)
    user_affiliate_countries = user.affiliate_countries.to_s.split(',')
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