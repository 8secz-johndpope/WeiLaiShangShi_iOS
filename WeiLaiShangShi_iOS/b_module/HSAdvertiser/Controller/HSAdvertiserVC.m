//
//  HSAdvertiserVC.m
//  HSKD
//
//  Created by AllenQin on 2019/5/14.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSAdvertiserVC.h"

@interface HSAdvertiserVC ()

@end

@implementation HSAdvertiserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广告合伙人";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#FF6128"]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:17],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"]}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
