Pod::Spec.new do |s|

  s.name           = "synth-ios"
  s.version        = "1.0.0"
  s.summary        = "A short description of Synth."
  s.description    = "A long description of Synth"
  s.homepage       = "https://www.cred.club/"
  s.license        = "MIT"
  s.author         = "Prashant"
  s.platform       = :ios, "11.0"
  s.source         = { :path => '.' }
  s.source_files   = "Synth/**/*.swift"
  s.swift_version  = "5.1"
  s.module_name    = 'Synth'
  s.header_dir     = 'Synth'
  
end
