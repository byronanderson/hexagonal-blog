configuration = YAML::load(File.open("config/twitter.yml").read)[Rails.env]
Twitter.configure do |config|
  configuration.each { |option, value| config.send(:"#{option}=", value) }
end
