Pod::Spec.new do |s|
    s.source_files = '*.swift'
    s.name = 'FitnessAPI'
    s.authors = 'Yonas Kolb'
    s.summary = 'Api for fitness app'
    s.version = '0.0.1'
    s.homepage = 'https://github.com/yonaskolb/SwagGen'
    s.source = { :git => 'git@github.com:https://github.com/yonaskolb/SwagGen.git' }
    s.ios.deployment_target = '13.0'
    s.platform = :ios, '13.0'
    s.source_files = 'Sources/**/*.swift'
    s.dependency 'Alamofire', '~> 4.9.0'
end
