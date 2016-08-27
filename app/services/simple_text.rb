require 'cgi'
class SimpleText

  def initialize(text, review)
    @text = ActionController::Base.helpers.strip_tags(text)
    @review = review
  end

  def sanitized_text(text = @text)
    (text).to_s
  end

  def link_names
    sanitized_text.scan(/@@(\w+)/)
  end

  def get_text
    unless link_names.count == 0
      @new_text
      link_names.each do |word|
        reg = Regexp.new("@@(#{word[0]})")
        @new_text = sanitized_text.sub!(reg, "<a href='#' class='external_link'>#{word[0].humanize}</a>".html_safe)
        sanitized_text(@new_text)
      end
      return @new_text
    end
    sanitized_text(@text)
  end

end