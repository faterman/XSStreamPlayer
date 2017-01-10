
Pod::Spec.new do |s|

  s.name         = "XSStreamPlayer"
  s.version      = "0.0.1"
  s.summary      = "第三方解耦组件，设计用来实现音频流播放，实现音频播放统一接口。"
  s.homepage     = "https://github.com/faterman/XSStreamPlayer"
  s.license      = "MIT"
  s.author       = { "" => "xxyformobile@163.com" }
  s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/faterman/XSStreamPlayer.git", :tag => "#{s.version}" }
  s.source_files = "XSStreamPlayer/*.{h,m}"
  s.requires_arc = true
  s.dependency "StreamingKit"

end
