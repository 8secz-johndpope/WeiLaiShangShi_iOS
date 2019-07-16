//
//  HSWalletExplainVC.m
//  HSKD
//
//  Created by AllenQin on 2019/5/13.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWalletExplainVC.h"

@interface HSWalletExplainVC ()

@end

@implementation HSWalletExplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包说明";
    self.descLabel = [[UILabel alloc]init];
    self.descLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.descLabel .textColor =[UIColor colorWithHexString:@"#999999"];
    self.descLabel .numberOfLines = 0;
    [self.view addSubview:self.descLabel];
    [self.descLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(kRealValue(20));
        make.left.equalTo(self.view.mas_left).with.offset(kRealValue(13));
        make.right.equalTo(self.view.mas_right).with.offset(-kRealValue(13));
    }];
    
    [[MHUserService sharedInstance]initwithHSRuleType:@"PURSE_RULE" CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.descLabel.text = response[@"data"];
        }
    }];
}


@end
