#
# Be sure to run `pod lib lint RxAppleSignIn.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxAppleSignIn'
  s.version          = '0.1.0'
  s.summary          = 'RxSwift extension fot apple sign in.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "RxSwift extension fot apple sign in"

  s.homepage         = 'https://github.com/Pumpkin-SweetPotato/RxAppleSignIn'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pumpkin-SweetPotato' => 'vibrio0102@gmail.com' }
  s.source           = { :git => 'https://github.com/Pumpkin-SweetPotato/RxAppleSignIn.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'RxAppleSignIn/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RxAppleSignIn' => ['RxAppleSignIn/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'AuthenticationServices', 'RxSwift', 'RxCocoa'
   s.dependency   'RxSwift', '~> 5', 'RxCocoa', '~> 5'
end
