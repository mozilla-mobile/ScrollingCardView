#
# Be sure to run `pod lib lint ScrollingCardView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ScrollingCardView'
  s.version          = '0.1.0'
  s.summary          = 'A scrolling card view for iOS that grow with its content.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A card view widget for iOS that hugs its content, dynamically expanding the
height when the content height expands. If the content is taller than the card,
scrolling will automatically be enabled so all content can be seen.
                       DESC

  s.homepage         = 'https://github.com/mozilla-mobile/ScrollingCardView'
  s.screenshots     = 'https://raw.githubusercontent.com/mozilla-mobile/ScrollingCardView/master/docs/short-text.png', 'https://raw.githubusercontent.com/mozilla-mobile/ScrollingCardView/master/docs/long-text.png'
  s.license          = { :type => 'MPLv2', :file => 'LICENSE' }
  s.author           = { 'Michael Comella' => 'michael.l.comella@gmail.com' }
  s.source           = { :git => 'https://github.com/mozilla-mobile/ScrollingCardView.git', :tag => 'v0.1.0' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ScrollingCardView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ScrollingCardView' => ['ScrollingCardView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
