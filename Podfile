# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'MyPlayground' do
  # use_frameworks!
  use_modular_headers!
  inhibit_all_warnings!

  # Pods for MyPlayground
  pod 'RxCocoa'
  pod 'SDWebImage'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end
