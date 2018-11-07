#
# Be sure to run `pod lib lint SLBaseInfo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SLBaseInfo'
  s.version          = '0.1.2'
  s.summary          = '工程的基础信息'

  s.description      = <<-DESC
工程的基础信息1
                       DESC

  s.homepage         = 'https://github.com/lcd357287797/SLBaseInfo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '陆承东' => '357287797@qq.com' }
  s.source           = { :git => 'https://github.com/lcd357287797/SLBaseInfo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SLBaseInfo/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SLBaseInfo' => ['SLBaseInfo/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
