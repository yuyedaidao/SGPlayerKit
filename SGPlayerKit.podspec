#
# Be sure to run `pod lib lint SGPlayerKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SGPlayerKit'
  s.version          = '0.1.0'
  s.summary          = 'SGPlayerKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'SGPlayerKit'

  s.homepage         = 'https://gitee.com/iqilu/SGPlayerKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WYQ' => 'wyqpadding@gmail.com' }
  s.source           = { :git => 'https://gitee.com/iqilu/SGPlayerKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'SGPlayerKit/Classes/**/*'
  
  s.resource_bundles = {
    'SGPlayerKit' => ['SGPlayerKit/Assets/*']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'

end
