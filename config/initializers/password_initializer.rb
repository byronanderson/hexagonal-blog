AUTHOR_PASSWORD  = YAML::load(File.open("config/passwords.yml").read)[Rails.env]
