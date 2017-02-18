module ApplicationHelper
  def weather_icon_image(icon_name)
    "#{Settings.weather_api.icon_full_path}#{icon_name}.png" if icon_name
  end
end
