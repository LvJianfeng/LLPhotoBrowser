Pod::Spec.new do |s|
  s.name         = "LLPhotoBrowser"
  s.version      = "1.1.0"
  s.summary      = "Swift 3&4 图片浏览工具"
  s.homepage     = "https://github.com/LvJianfeng/LLPhotoBrowser"
  s.license      = "MIT"
  s.author             = { "LvJianfeng" => "coderjianfeng@foxmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/LvJianfeng/LLPhotoBrowser.git", :tag => "#{s.version}" }
  s.source_files  = "Class/*.{swift}"
  s.resource  = "Class/LLPhotoBrowser.bundle"
  s.dependency 'Kingfisher'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
