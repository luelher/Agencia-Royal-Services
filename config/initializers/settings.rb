# Load config/settings.yml into FB_OG_CONFIG

unless File.exists?(File.join(Rails.root, "config", "settings.yml"))
  raise "config/settings.yml should exists!"
end

FB_OG_CONFIG = YAML.load_file(File.join(Rails.root, "config", "settings.yml"))[Rails.env]

Date::DATE_FORMATS[:default] = '%d/%m/%Y'