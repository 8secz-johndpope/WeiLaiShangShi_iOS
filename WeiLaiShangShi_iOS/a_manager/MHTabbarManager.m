//
//  MHTabbarManager.m
//  mohu
//
//  Created by AllenQin on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//


#import "MHTabbarManager.h"
#import <UIKit/UIKit.h>


@interface CYLBaseNavigationController : UINavigationController
@end

@implementation CYLBaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end


#import "MHHomeViewController.h"
//#import "MHTaskViewController.h"
//#import "MHMineViewController.h"


#import "HSNewsViewController.h"
#import "HSTaskViewController.h"
#import "HSMineViewController.h"
#import "HSWalletViewController.h"
#import "HSAdvertiserVC.h"
#import "HSFindVC.h"


@interface MHTabbarManager ()<UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation MHTabbarManager

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;
        UIOffset titlePositionAdjustment = UIOffsetZero;
        
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                             imageInsets:imageInsets
                                                                                 titlePositionAdjustment:titlePositionAdjustment
                                                                                                 context:self.context
                                                 ];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    MHHomeViewController *firstViewController = [[MHHomeViewController alloc] init];
    UIViewController *firstNavigationController = [[CYLBaseNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    HSWalletViewController *secondViewController = [[HSWalletViewController alloc] init];
    UIViewController *secondNavigationController = [[CYLBaseNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    HSFindVC *cateroyViewController = [[HSFindVC alloc] init];
    UIViewController *cateroyNavigationController = [[CYLBaseNavigationController alloc]
                                                    initWithRootViewController:cateroyViewController];
    
    HSMineViewController *fourthViewController = [[HSMineViewController alloc] init];
    UIViewController *fourthNavigationController = [[CYLBaseNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    
    
    HSAdvertiserVC *fifthViewController = [[HSAdvertiserVC alloc] init];
    UIViewController *fifthNavigationController = [[CYLBaseNavigationController alloc]
                                                    initWithRootViewController:fifthViewController];
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 cateroyNavigationController,
                                 fifthNavigationController,
                                 secondNavigationController,
                                 fourthNavigationController
                                 ];
//    if (ValidStr([GVUserDefaults standardUserDefaults].shenghe)) {
//        viewControllers = @[
//                            firstNavigationController,
////                            secondNavigationController,
//                            cateroyNavigationController,
//                            fourthNavigationController
//                            ];
//    }else{
//        viewControllers = @[
//                            firstNavigationController,
//                            cateroyNavigationController,
//                            fourthNavigationController
//                            ];
//    }

    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"资讯",
                                                 CYLTabBarItemImage : @"home_nomal",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : [UIImage imageNamed:@"home_highlight"],
                                                 };
    
    NSDictionary *categoryTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"钱包",
                                                 CYLTabBarItemImage : @"wallet_nomal",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : [UIImage imageNamed:@"wallet_highlight"],
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"发现",
                                                  CYLTabBarItemImage : @"level_nomal",
                                                  CYLTabBarItemSelectedImage : [UIImage imageNamed:@"level_highlight"],
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"我的",
                                                 CYLTabBarItemImage : @"mine_nomal",
                                                 CYLTabBarItemSelectedImage : [UIImage imageNamed:@"mine_highlight"],
                                                 };
    NSDictionary *fifthTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"广告",
                                                 CYLTabBarItemImage : @"mine_nomal",
                                                 CYLTabBarItemSelectedImage : [UIImage imageNamed:@"mine_highlight"],
                                                 };
    
    NSArray *tabBarItemsAttributes;
    if (ValidStr([GVUserDefaults standardUserDefaults].shenghe)) {
        tabBarItemsAttributes = @[
                                           firstTabBarItemsAttributes,
                                           secondTabBarItemsAttributes,
                                           fifthTabBarItemsAttributes,
                                           categoryTabBarItemsAttributes,
                                           thirdTabBarItemsAttributes,
                                           ];
    }else{
        tabBarItemsAttributes = @[
                                           firstTabBarItemsAttributes,
                                           secondTabBarItemsAttributes,
                                           fifthTabBarItemsAttributes,
                                           categoryTabBarItemsAttributes,
                                           thirdTabBarItemsAttributes,
                                           ];
    }

    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    
    

#pragma mark 设置tabar高度
    // Customize UITabBar height
    // 自定义 TabBar 高度
    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 83 : 49;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#C1C1C1"];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#F6AC19"];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
//    [[UIButton appearance] setExclusiveTouch:YES];
    [[UITabBar appearance] setTranslucent:NO];

//    UITabBar *tabBarAppearance = [UITabBar appearance];
//
//    //FIXED: #196
//    UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"tab_bar"];
//    UIImage *scanedTabBarBackgroundImage = [[self class] scaleImage:tabBarBackgroundImage toScale:1.0];
    CGRect rect = CGRectMake(0, 0, kScreenWidth, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [UIColor colorWithHexString:@"f2f2f2"].CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    [tabBarAppearance setBackgroundImage:img];
    [[UITabBar appearance] setShadowImage:img];
    
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]` 见 AppDelegate 类中的演示;
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];

    
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}



+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize);
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
