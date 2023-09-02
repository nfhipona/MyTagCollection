#
# Be sure to run `pod lib lint MyTagCollection.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'MyTagCollection'
    s.version          = '1.0.0'
    s.swift_version    = '5'
    s.platform         = :ios, '12.0'
    s.summary          = 'MyTagCollection is a utility helper for handling and managing user`s custom tags'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    
    `MyTagCollection` is a utility helper allowing users to handle tags added in application with mix matching custom ui/ux for each tag items. Supports expand and collapse tag item with custom view. Can't think of a good description please make a PR.
    
    DESC
    
    s.homepage         = 'https://github.com/nfhipona/MyTagCollection'
#    s.screenshots     = 'https://github.com/nfhipona/MyTagCollection/blob/main/Example/MyTagCollection/Demo/ss-center', 'https://github.com/nfhipona/MyTagCollection/blob/main/Example/MyTagCollection/Demo/ss-left', 'https://github.com/nfhipona/MyTagCollection/blob/main/Example/MyTagCollection/Demo/ss-right'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Neil Francis Ramirez Hipona' => 'enef.devops@protonmail.ch' }
    s.source           = { :git => 'https://github.com/nfhipona/MyTagCollection.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '12.0'
    
    s.source_files = 'MyTagCollection/Classes/**/*'
    
    s.resource_bundles = {
        'MyTagCollection' => ['MyTagCollection/Assets/**/*']
    }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
