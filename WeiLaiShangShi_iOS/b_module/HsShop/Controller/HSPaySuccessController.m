//
//  HSPaySuccessController.m
//  HSKD
//
//  Created by AllenQin on 2019/3/11.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSPaySuccessController.h"

@interface HSPaySuccessController ()

@end

@implementation HSPaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    self.title = @"兑换结果";
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kRealValue(89), kRealValue(168), kRealValue(111))];
    iconImageView.image = kGetImage(@"shop_good_icon1");
    [self.view addSubview:iconImageView];
    iconImageView.centerX = self.view.centerX;
    
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(220), kScreenWidth, kRealValue(30))];
    textLabel.text = @"兑换成功";
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(18)];
    textLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    [self.view addSubview:textLabel];
    textLabel.centerX = self.view.centerX;
    
    
    UILabel *text1Label = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(260), kScreenWidth, kRealValue(50))];
    text1Label.text = @"您购买的商品将在7个工作日寄出，请注意查收。";
    text1Label.numberOfLines = 0;
    text1Label.textAlignment = NSTextAlignmentCenter;
    text1Label.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
    text1Label.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.view addSubview:text1Label];
    text1Label.centerX = self.view.centerX;
}


-(void)backBtnClicked{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
