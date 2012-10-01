require "httparty"
require "json"

class Solo
  MENU = 82
  METHODS = [
    {:name => "sendKey", :argument_types => ["int"]},
    {:name => "clickOnImageButton", :argument_types => ["int"]},
    {:name => "enterText", :argument_types => ["int", "java.lang.String"]},
    {:name => "clearEditText", :argument_types => ["int"]}
  ]

  class << self
    METHODS.each do |method|
      ruby_method_name = method[:name].gsub(/([A-Z])/) { |capture| "_" + capture.downcase }
      define_method(ruby_method_name) do |*arguments|
        parameters = method[:argument_types].map do |argument_type|
          {"type" => argument_type, "value" => arguments.shift}
        end
        options = { :body => {:parameters => parameters.to_json} }
        puts HTTParty.post("http://127.0.0.1:7103/execute_method/#{method[:name]}", options).body
      end
    end

    def wait_until_ready
      while ready? == false
        sleep 0.1
      end
    end

    def ready?
      HTTParty.get("http://127.0.0.1:7103/").body == "RobotiumBridge" rescue false
    end

    def kill_server
      HTTParty.get("http://127.0.0.1:7103/finish") rescue false
    end
  end
end
