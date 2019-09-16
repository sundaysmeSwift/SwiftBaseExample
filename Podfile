platform:ios,'9.0'
#source 'http://github.com/CocoaPods/Specs.git'
inhibit_all_warnings!
use_frameworks!

target 'SwiftBaseExample' do
#布局
pod 'SnapKit'
#image
pod 'Kingfisher'
pod 'Alamofire', '~> 4.9.0'
#pod 'YYKit'
pod 'SDWebImage'
#tabbar样式
pod 'ESTabBarController-swift', '~> 2.7'
#banner滚动图片
pod 'FSPagerView', '~> 0.8.3'
#解析
pod 'Moya'
pod 'HandyJSON', '~> 4.2.0'
pod 'SwiftyJSON'
# 分页
pod 'DNSPageView', '~> 1.2.0'
#跑马灯
pod 'JXMarqueeView'
#滚动页
pod 'LTScrollView', '~> 0.2.1'
#页面刷新
pod 'MJRefresh'
#pod 'SkeletonView'
#消息提示
pod 'SwiftMessages'
pod 'SVProgressHUD'
#播放网络音频
pod 'StreamingKit'

#
pod 'SlideMenuController'
#统计
pod 'UMengAnalytics-NO-IDFA'
#
pod 'CHIPageControl', '~> 0.2'
#
pod 'Charts', '~> 3.3.0'
#键盘
pod 'IQKeyboardManagerSwift', '~> 6.4.2'
#
#
#
pod 'Starscream', '3.0.6'



    swift4 = ['LTScrollView', 'SlideMenuController']

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                if swift4.include?(target.name)
                    config.build_settings['SWIFT_VERSION'] = '4.0'
                end
            end
        end
    end
end
