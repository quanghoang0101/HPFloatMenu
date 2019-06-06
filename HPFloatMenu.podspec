#
#  Be sure to run `pod spec lint HPFloatMenu.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "HPFloatMenu"
  spec.version      = "1.1.0"
  spec.summary      = "HPFloatMenu with cool animation for your iOS app, easy setup and use!"
  spec.description  = "A library for floating menu, user can easy custom the menu with icons and text."
  spec.homepage     = "https://github.com/quanghoang0101/HPFloatMenu"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Hoang" => "quanghoang0101@yahoo.com.vn" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/quanghoang0101/HPFloatMenu.git", :tag => "#{spec.version}" }
  spec.source_files  = "HPFloatMenu/**/*.{swift}"
  spec.dependency "SnapKit", "5.0.0"
  spec.swift_version = "5"
end
