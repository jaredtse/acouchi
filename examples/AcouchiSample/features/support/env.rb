require "acouchi"
require "acouchi/cucumber"

configuration = Acouchi::Configuration.from_json(File.read("acouchi_configuration.json"))
Acouchi::Cucumber.prepare(configuration)

def page
  Acouchi::Cucumber.page
end
