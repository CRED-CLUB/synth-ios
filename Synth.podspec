Pod::Spec.new do |spec|

  spec.name           = "Synth"
  spec.version        = "1.0.0"
  spec.summary        = "A short description of Synth."
  spec.description    = "A long description of Synth"
  spec.homepage       = "https://www.cred.club/"
  spec.license        = "MIT"
  spec.author         = "Prashant"
  spec.platform       = :ios, "11.0"
  spec.source         = { :path => '.' }
  spec.source_files   = "Synth/**/*.swift"
  spec.swift_version  = "5.1"

end
