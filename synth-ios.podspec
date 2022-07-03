Pod::Spec.new do |s|

  s.name           = "synth-ios"
  s.version        = "1.0.1"
  s.summary        = "Synth is CRED's inbuilt library for using Neuromorphic components in your app."
  s.description    = "What really is Neumorphism? It's an impressionistic style, playing with light, shadow, and depth to create a digital experience inspired by the physical world."
  s.homepage       = "https://www.cred.club/"
  s.license        = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author         = { 'CRED' => 'opensource@cred.club' }
  s.platform       = :ios, "11.0"
  s.source         = { :git => 'https://github.com/CRED-CLUB/synth-ios.git', :tag => s.version.to_s }
  s.source_files   = "Synth/**/*.swift"
  s.swift_version  = "5.1"
  s.module_name    = 'Synth'
  s.header_dir     = 'Synth'

end
