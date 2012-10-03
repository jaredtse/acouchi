Acouchi
=======

WARNING
-------

This gem was initially a spike, and has since then become rather useful. It is very much not unit tested. For this I apologise, and offer up this picture of an [Acouchi](http://en.wikipedia.org/wiki/Acouchi):

![acouchi](https://github.com/AndrewVos/acouchi/raw/master/acouchi.jpg)

Requirements
------------

* [Android SDK](http://developer.android.com/sdk/installing/index.html) (Make sure to add SDK/tools and SDK/platform-tools to your PATH)
* [apktool](http://code.google.com/p/android-apktool/)

The Build Process
-----------------

Acouchi needs to make some tweaks to your APK to allow functional testing. This is roughly the process:

* Temporarily add some source files, and the Robotium jar file to your project
* Build your project in debug mode with ant
* Hack the APK file and inject some need elements in your AndroidManifest.xml

Please note that the build only has to happen again if your java code for the application under test changes.

How It Works
------------

Acouchi builds Robotium and a HTTP server into your Android application. Robotium is an API that has some amazing functionality for functional testing on Android.
In the Ruby API we post method calls via HTTP to the server on your device, which in turn returns meaningful data.

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
