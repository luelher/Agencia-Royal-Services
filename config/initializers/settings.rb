# Load config/settings.yml into FB_OG_CONFIG

unless File.exists?(File.join(Rails.root, "config", "settings.yml"))
  raise "config/settings.yml should exists!"
end

APP_CONFIG = YAML.load_file(File.join(Rails.root, "config", "settings.yml"))[Rails.env]

Date::DATE_FORMATS[:default] = '%d/%m/%Y'


Holidays.between(Date.civil(2011, 1, 1), 2.years.from_now, :ve, :observed).map{|holiday| BusinessTime::Config.holidays << holiday[:date]}

