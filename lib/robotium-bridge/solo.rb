require "httparty"
require "json"

module RobotiumBridge
  class Solo
    MENU = 82

    def send_key key
      call_method("sendKey", [{:type => "int", :value => key}])
    end

    def enter_text index, text
      call_method("enterText", [
        {:type => "int",              :value => index},
        {:type => "java.lang.String", :value => text}
      ])
    end

    def call_method name, arguments
      options = { :body => {:parameters => arguments.to_json} }
      puts HTTParty.post("http://127.0.0.1:7103/execute_method/#{name}", options).body
    end

    METHODS = [
      {:name => "clickOnImageButton", :argument_types => ["int"]},
      {:name => "clearEditText", :argument_types => ["int"]}
    ]

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
  end
end
