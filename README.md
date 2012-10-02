RobotiumBridge
==============

Requirements
------------

* [apktool](http://code.google.com/p/android-apktool/) installed and in your path

Cucumber
--------

### PROJECT_ROOT/features/support/env.rb

    require "robotium-bridge"
    require "robotium-bridge/cucumber"

    configuration = RobotiumBridge::Configuration.from_json(File.read("robotium_bridge_configuration.json"))
    RobotiumBridge::Cucumber.prepare(configuration)

    def page
      RobotiumBridge::Cucumber.page
    end

### PROJECT_ROOT/robotium_bridge_configuration.json

    {
      "target_package": "com.robotiumbridge.sample",
      "activity"      : "com.robotiumbridge.sample.StartupActivity",
      "project_path"  : ".",
      "apk"           : "RobotiumBridgeSample-debug.apk"
    }

### PROJECT_ROOT/Rakefile

    require "cucumber"
    require "cucumber/rake/task"
    require "robotium-bridge"

    desc "build project with RobotiumBridge code included"
    task :build do
      configuration = RobotiumBridge::Configuration.from_json(File.read("robotium_bridge_configuration.json"))
      RobotiumBridge::ProjectBuilder.new(configuration).build
    end

    Cucumber::Rake::Task.new(:features) do |t|
      t.cucumber_opts = "features --format pretty"
    end
