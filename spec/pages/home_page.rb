class HomePage
  include Capybara::DSL

  def initialize
    visit '/'
  end

  def query_weather(query_text)
    unless query_text.blank?
      # Fill form
      # Press button
    end
  end
end
