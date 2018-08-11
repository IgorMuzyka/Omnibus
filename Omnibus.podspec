
Pod::Spec.new do |s|

  s.name = 'Omnibus'
  s.version = '1.0.0'
  s.swift_version = '4.2'
  s.summary = 'Swift dependency container.\nA bus like the one on your motherboard.'
  s.homepage = 'https://github.com/igormuzyka/Omnibus'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'igormuzyka' => 'igormuzyka42@gmail.com' }
  s.source = { :git => 'https://github.com/igormuzyka/Omnibus.git', :tag => s.version.to_s }
  s.source_files = 'Sources/*'

  s.osx.deployment_target = "10.10"
  s.ios.deployment_target  = "9.0"
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '3.0'

end
