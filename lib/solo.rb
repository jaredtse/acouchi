require "httparty"
require "json"

class Solo
  MENU = 82
  METHODS = [
    {:name => "sendKey", :argument_types => ["int"]}
  ]

  class << self
    METHODS.each do |method|
      ruby_method_name = method[:name].gsub(/([A-Z])/) { "_" + $1.downcase }
      define_method(ruby_method_name) do |*arguments|
        parameters = method[:argument_types].map do |argument_type|
          {"type" => argument_type, "value" => arguments.shift}
        end
        options = { :body => {:parameters => parameters.to_json} }
        puts HTTParty.post("http://127.0.0.1:7103/execute_method/#{method[:name]}", options).body
      end
    end
  end
end
