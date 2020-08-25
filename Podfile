# Uncomment the next line to define a global platform for your project
platform :ios, '13.5'

inhibit_all_warnings!

target 'fitnes' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for fitnes
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  pod 'FSCalendar'

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if Gem::Version.new('13.5') > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.5'
      end
    end
  end
  
  # This removes the warning about swift conversion, hopefuly forever!
  # https://github.com/CocoaPods/CocoaPods/issues/8674
  installer.pods_project.root_object.attributes['LastSwiftMigration'] = 9999
  installer.pods_project.root_object.attributes['LastSwiftUpdateCheck'] = 9999
  installer.pods_project.root_object.attributes['LastUpgradeCheck'] = 9999
  
end
