#
# Be sure to run `pod lib lint TXCSocket.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TXCSocket'
  s.version          = '0.1.1'
  s.summary          = '基于‘CocoaAsyncSocket’所开发的客户端Socket.'
  s.description      = <<-DESC
  由TX所开发的基于‘CocoaAsyncSocket’所开发的客户端Socket.
                       DESC
  s.homepage         = 'https://github.com/xtzPioneer/TXCSocket'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '张雄' => 'xtz_pioneer@163.com' }
  s.source           = { :git => 'https://github.com/xtzPioneer/TXCSocket.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'TXCSocket/Classes/**/*{h,m}'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
  s.dependency 'CocoaAsyncSocket'
end
