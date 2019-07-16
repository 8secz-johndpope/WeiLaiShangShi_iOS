//
//  HSPlusButton.m
//  HSKD
//
//  Created by yuhao on 2019/2/20.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSPlusButton.h"
#import "HSDisCoverViewController.h"
@interface HSPlusButton () {
    CGFloat _buttonImageHeight;
}
@end
@implementation HSPlusButton
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //        self.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}



#pragma mark -
#pragma mark - Public Methods

/*
 *
 Create a custom UIButton without title and add it to the center of our tab bar
 *
 */
+ (instancetype)plusButton
{
    
    UIImage *buttonImage = [UIImage imageNamed:@"guafen"];
    UIImage *highlightImage = [UIImage imageNamed:@"guafen"];
    UIImage *iconImage = [UIImage imageNamed:@"guafen"];
    UIImage *highlightIconImage = [UIImage imageNamed:@"guafen"];
    
    HSPlusButton *button = [HSPlusButton buttonWithType:UIButtonTypeCustom];
    
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setImage:iconImage forState:UIControlStateNormal];
    [button setImage:highlightIconImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
  
}



#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %ld", buttonIndex);
}

+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 2;
}
+(UIViewController *)plusChildViewController
{
    HSDisCoverViewController *plus = [[HSDisCoverViewController alloc]init];
//    plus.view.backgroundColor = [UIColor redColor];
//    plus.navigationItem.title = @"lallala";
    UIViewController *vc = [[UINavigationController alloc]initWithRootViewController:plus];
    return vc;
};
+ (BOOL)shouldSelectPlusChildViewController {
    BOOL isSelected = CYLExternPlusButton.selected;
    if (isSelected) {
//        NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
    } else {
//        NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
    }
    return YES;
}
+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (CYL_IS_IPHONE_X ? - 6 : -2);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
