Pod::Spec.new do |s|

  s.name           = "synth-ios"
  s.version        = "1.0.0"
  s.summary        = "A library to render neumorphic components in iOS"
  s.description    = "A framework designed over neumorphic style which provides an extension over UIKit elements UIView and UIButton"
  s.homepage       = "https://www.cred.club/"
  s.license          = { :type => 'Apache', :file => 'LICENSE' }
  s.author         = "Prashant"
  s.platform       = :ios, "11.0"
  s.source         = { :path => '.' }
  s.source_files   = "Synth/**/*.swift"
  s.swift_version  = "5.1"
  s.module_name    = 'Synth'
  s.header_dir     = 'Synth'
  
end
