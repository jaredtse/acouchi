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

    def clear_edit_text index
      call_method("clearEditText", [{:type => "int", :value => index}])
    end

    def has_text? text, options={}
      options = {
        :scroll          => true,
        :minimum_matches => 0,
        :must_be_visible => true
      }.merge(options)

      call_method("searchText", [
        {:type => "java.lang.String", :value => text},
        {:type => "int", :value => options[:minimum_matches]},
        {:type => "boolean", :value => options[:scroll]},
        {:type => "boolean", :value => options[:must_be_visible]}
      ])
    end

    private
      def call_method name, arguments
        options = { :body => {:parameters => arguments.to_json} }
        json = JSON.parse(HTTParty.post("http://127.0.0.1:7103/execute_method/#{name}", options).body)
        if json["emptyResult"]
          nil
        else
          json["result"]
        end
      end
  end
end
