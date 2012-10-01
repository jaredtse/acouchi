require "httparty"
require "json"

class Solo
  MENU = 82
end

options = {
  :body => {
    :parameters => [
      {"type" => "int", "value" => Solo::MENU},
    ].to_json
  }
}

puts HTTParty.post("http://127.0.0.1:7103/execute_method/sendKey", options).body
