platform :ios, '12.0'
use_frameworks!

target 'kienhomedesign' do
  pod 'SwifterSwift'
  pod 'FCFileManager'
  pod 'SnapKit', '~> 5.6.0'
  pod 'ChameleonFramework'
  pod 'FSPagerView'
  pod 'Then'
  pod 'lottie-ios'
  pod 'Spring', :git => 'https://github.com/MussaCharles/Spring.git'
  pod 'SDWebImage', '~> 5.0'
  pod 'SwiftNotificationCenter'
  pod 'SwiftyUserDefaults', '~> 5.0'
  pod 'SDCAlertView'
  pod 'R.swift', '6.1.0'
  pod 'JGProgressHUD'
  pod 'SwiftyStoreKit'
  pod 'SwiftNotificationCenter'
  pod 'UIView+Shimmer'
  pod 'SwiftyShadow', '~> 1.7.0'
  pod 'SwiftyBeaver'
  pod 'RealmSwift', '~> 10.25.2'
  pod 'Permission/Photos'
  pod 'Permission/Camera'
  pod "SwiftRater"
  pod 'Moya', '~> 14.0'
  pod 'ObjectMapper'
  pod 'SwiftyJSON'
  pod 'CryptoSwift', '~> 1.4.1'
  pod 'IronSourceSDK','7.2.3.0'
  pod 'Firebase/Core'
  pod 'Firebase/Analytics'
  pod 'Firebase/RemoteConfig'
  pod 'Firebase/Crashlytics'
  
  pod 'YandexMobileMetrica', '4.2.0'
pod 'SwiftyShadow', '~> 1.7.0'
end


# NOTE
# KHI SU DUNG SIMULATOR M1 -> ENABLE VALID_ARCHS
# PROJECT -> BUILD SETTINGS -> EXCLUDED_ARC: ARM64
#
# NEU BUILD TREN REAL DEVICE THI DISABLE
#
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['VALID_ARCHS'] = 'arm64, arm64e, x86_64'
    end
  end
end
