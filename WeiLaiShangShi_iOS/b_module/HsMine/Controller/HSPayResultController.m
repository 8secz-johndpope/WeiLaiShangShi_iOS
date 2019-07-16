//
//  HSPayResultController.m
//  HSKD
//
//  Created by AllenQin on 2019/3/11.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSPayResultController.h"
#import "HSChargeController.h"
#import "HSFriendShopViewController.h"
#import "HSOrderVC.h"


@interface HSPayResultController ()

@property(strong ,nonatomic) UIView  *successView;

@property(strong ,nonatomic) NSString  *payResult;

@property(strong ,nonatomic) UIView  *errorView;

@end

@implementation HSPayResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值结果";
    self.payResult = @"-1";
    [MBProgressHUD showActivityMessageInWindow:@""];
    [[MHUserService sharedInstance]initwithHSCallBackHostPayResult:self.orderCode payType:self.payType CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response) ) {
            [MBProgressHUD hideHUD];
            [self showSuccess];
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[MHUserService sharedInstance]initwithHSCallBackHostPayResult:self.orderCode payType:self.payType CompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response) ) {
                        [MBProgressHUD hideHUD];
                        [self showSuccess];
                    }else{
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [[MHUserService sharedInstance]initwithHSCallBackHostPayResult:self.orderCode payType:self.payType CompletionBlock:^(NSDictionary *response, NSError *error) {
                                if (ValidResponseDict(response) ) {
                                    [MBProgressHUD hideHUD];
                                    [self showSuccess];
                                }else{
                                    [MBProgressHUD hideHUD];
                                    [self showError];
                                }
                            }];
                        });
                    }
                }];
            });
        }
    }];
}



- (void)backBtnClicked{
    
    if ( [self.payResult  isEqualToString:@"0"]) {
        
            [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[HSChargeController class]]) {
                HSChargeController *revise =(HSChargeController *)controller;
                [self.navigationController popToViewController:revise animated:YES];
                return;
            }
            if ([controller isKindOfClass:[HSFriendShopViewController class]]) {
                HSFriendShopViewController *revise =(HSFriendShopViewController *)controller;
                [self.navigationController popToViewController:revise animated:YES];
                return;
            }
            if ([controller isKindOfClass:[HSOrderVC class]]) {
                HSOrderVC *revise =(HSOrderVC *)controller;
                [self.navigationController popToViewController:revise animated:YES];
                return;
            }
            
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    

}




-(void)showSuccess{
    self.payResult = @"0";
    if (!_successView) {
        _successView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(450))];
        [self.view addSubview:_successView];
        
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kRealValue(89), kRealValue(73), kRealValue(73))];
        iconImageView.image = kGetImage(@"secc_icon");
        [self.view addSubview:iconImageView];
        iconImageView.centerX = self.view.centerX;
        
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(190), kScreenWidth, kRealValue(30))];
        textLabel.text = @"支付成功";
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont fontWithName:kPingFangSemibold size:kRealValue(24)];
        textLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        [self.view addSubview:textLabel];
        textLabel.centerX = self.view.centerX;
        
        UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kRealValue(240), kRealValue(96), kRealValue(39))];
        [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [loginBtn setTitle:@"返回" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        loginBtn.backgroundColor = [UIColor colorWithHexString:@"#FD7215"];
        loginBtn.layer.masksToBounds = YES;
        loginBtn.layer.cornerRadius = kRealValue(20);
        [self.view addSubview:loginBtn];
        loginBtn.centerX = self.view.centerX;
        
    }
    
    
    
    [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [GVUserDefaults standardUserDefaults].phone = response[@"data"][@"phone"];
            [GVUserDefaults standardUserDefaults].userRole = [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
        }
    }];
    
}


-(void)login{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)showError{
     self.payResult = @"1";
    if (!_errorView) {
        _errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(450))];
        [self.view addSubview:_errorView];
        
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kRealValue(89), kRealValue(73), kRealValue(73))];
        iconImageView.image = kGetImage(@"def_icon");
        [self.view addSubview:iconImageView];
        iconImageView.centerX = self.view.centerX;
        
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(190), kScreenWidth, kRealValue(30))];
        textLabel.text = @"支付失败";
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont fontWithName:kPingFangSemibold size:kRealValue(24)];
        textLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        [self.view addSubview:textLabel];
        textLabel.centerX = self.view.centerX;
        
        UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kRealValue(240), kRealValue(96), kRealValue(39))];
        [loginBtn addTarget:self action:@selector(backLogin) forControlEvents:UIControlEventTouchUpInside];
        [loginBtn setTitle:@"重新支付" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        loginBtn.backgroundColor = [UIColor colorWithHexString:@"#FD7215"];
        loginBtn.layer.masksToBounds = YES;
        loginBtn.layer.cornerRadius = kRealValue(20);
        [self.view addSubview:loginBtn];
        loginBtn.centerX = self.view.centerX;
        
    }
}

-(void)backLogin{
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HSChargeController class]]) {
            HSChargeController *revise =(HSChargeController *)controller;
            [self.navigationController popToViewController:revise animated:YES];
            return;
        }
        if ([controller isKindOfClass:[HSFriendShopViewController class]]) {
            HSFriendShopViewController *revise =(HSFriendShopViewController *)controller;
            [self.navigationController popToViewController:revise animated:YES];
            return;
        }
        if ([controller isKindOfClass:[HSOrderVC class]]) {
            HSOrderVC *revise =(HSOrderVC *)controller;
            [self.navigationController popToViewController:revise animated:YES];
            return;
        }
        
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
