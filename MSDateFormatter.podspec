Pod::Spec.new do |s|
  s.name             = "MSDateFormatter"
  s.version          = '0.1.0'
  s.summary          = "A delightful NSDate category for iOS"
  s.homepage         = "https://github.com/Namvt/MSDateFormatter",
  s.license          = 'MIT'
  s.author           = { "Michael Vu" => "namvt@rubify.com" }
  s.source           = { :git => "https://git@github.com:Namvt/MSDateFormatter.git", :tag => '0.1.0' }
  s.source_files = 'MSDateFormatter/MSDateFormatter.swift'
  s.requires_arc = true
end
