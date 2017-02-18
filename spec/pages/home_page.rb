class HomePage
  include Capybara::DSL

  def initialize
    visit '/'
  end

  def query_weather(query_text)
    # Fill form
    # Press button
  end
end
