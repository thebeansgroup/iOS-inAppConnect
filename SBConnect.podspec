Pod::Spec.new do |s|
  s.name         = "SBConnect"
  s.version      = "1.0.0"
  s.summary      = "Connect To Student Beans In Your Native App"
  s.description  = "Offer verified student discounts via student beans without the user leaving your app."
  s.license      = "MIT"
  s.author       = { "Jack Smith" => "jack.smith@thebeansgroup.com" }
  s.platform     = :ios, "11.0"
  s.homepage     = "https://github.com/thebeansgroup/iOS-InAppConnect"
  s.vendored_frameworks = "SBConnect.xcframework"
  s.source       = { :path => "./SBConnect.xcframework" }
end
