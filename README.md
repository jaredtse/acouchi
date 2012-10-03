Acouchi
=======

Requirements
------------

* [apktool](http://code.google.com/p/android-apktool/) installed and in your path

Cucumber
--------

### PROJECT_ROOT/features/support/env.rb

    require "acouchi"
    require "acouchi/cucumber"

    configuration = Acouchi::Configuration.from_json(File.read("acouchi_configuration.json"))
    Acouchi::Cucumber.prepare(configuration)

    def page
      Acouchi::Cucumber.page
    end

### PROJECT_ROOT/acouchi_configuration.json

    {
      "target_package": "com.acouchi.sample",
      "activity"      : "com.acouchi.sample.StartupActivity",
      "project_path"  : ".",
      "apk"           : "AcouchiSample-debug.apk"
    }

### PROJECT_ROOT/Rakefile

    require "cucumber"
    require "cucumber/rake/task"
    require "acouchi"

    desc "build project with Acouchi code included"
    task :build do
      configuration = Acouchi::Configuration.from_json(File.read("acouchi_configuration.json"))
      Acouchi::ProjectBuilder.new(configuration).build
    end

    Cucumber::Rake::Task.new(:features) do |t|
      t.cucumber_opts = "features --format pretty"
    end
