#
# Be sure to run `pod lib lint StringParser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StringParser'
  s.version          = '0.0.1'
  s.summary          = 'Syntax sugar for parsing simple strings based on templates.'

  s.description      = <<-DESC
A token-parser with a nice syntax that grabs values from strings based on templates.
                       DESC

  s.homepage         = 'https://github.com/JamesPerlman/StringParser'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jam.e.perl@gmail.com' => 'jam.e.perl@gmail.com' }
  s.source           = { :git => 'https://github.com/jam.e.perl@gmail.com/StringParser.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'StringParser/Classes/**/*'
  
end
