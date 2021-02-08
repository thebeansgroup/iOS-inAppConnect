Pod::Spec.new do |s|
  s.name         = "SBConnect"
  s.version      = "0.0.1"
  s.summary      = "Connect To Student Beans In Your Native App"
  s.description  = "Offer verified student discounts via student beans without the user leaving your app."
  s.license      = "MIT"
  s.author       = { "Jack Smith Developer" => "jack.smith@thebeansgroup.com" }
  s.platform     = :ios, "11.0"
  s.homepage     = "https://github.com/student-beans/iOS-InAppConnect"
  s.vendored_frameworks = "SBConnect.xcframework"
end
