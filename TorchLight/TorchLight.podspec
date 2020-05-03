Pod::Spec.new do |s|

  s.name                    = "TorchLight"
  s.version                 = "1.0.0"
  s.summary                 = "The framework for full and easy control of the iPhone Torch for Swift"
  s.description             = "The framework for full and easy control of the iPhone Torch for Swift"
  s.homepage                = "https://github.com/suhfangmbeng/TorchLight"
  s.license                 = "MIT"
  s.author                  = { "Suh Fangmbeng" => "me@suhfangmbeng.com" }
  s.platform                = :ios
  s.requires_arc            = true
  s.ios.deployment_target   = '10.0'
  s.source                  = { :git => "https://github.com/suhfangmbeng/TorchLight.git", :tag => "1.0.0" }
  s.source_files            = "TorchLight", "TorchLight/**/*.{h,m}"
  s.swift_versions          = "4.0", "5.0"
  
end
