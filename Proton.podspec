Pod::Spec.new do |s|
  s.name             = "Proton"
  s.version          = "0.1.0"
  s.summary          = "Platform for easily building iOS apps in Swift"
  s.description      = <<-DESC
    Platform for easily building iOS and OS X apps in Swift.
                       DESC
  s.homepage         = "https://github.com/IMcD23/Proton"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "IMcD23" => "mcdow.ian@gmail.com" }
  s.source           = { :git => "https://github.com/IMcD23/Proton.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'

  s.ios.source_files = 'Source/Core/**/*'
  s.osx.source_files = 'Source/{Core,AppKitBridge}/**/*'

  s.ios.frameworks = 'UIKit'
  s.osx.frameworks = 'AppKit'

end
