# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Timer' do
pod 'SnapKit', '~> 3.2'
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Timer

  target 'TimerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TimerUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
end
