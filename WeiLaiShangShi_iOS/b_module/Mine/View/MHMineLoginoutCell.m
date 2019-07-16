//
//  MHMineLoginoutCell.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHMineLoginoutCell.h"

@implementation MHMineLoginoutCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createview];
        self.backgroundColor = KColorFromRGB(0xF2F3F5);
    }
    return self;
}
-(void)createview
{
    self.loginout = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginout.backgroundColor = KColorFromRGB(0xffffff);
    self.loginout.titleLabel.font =[UIFont fontWithName:kPingFangLight size:kFontValue(14)];
    [self.loginout setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.loginout setTitleColor:KColorFromRGB(0x333333) forState:UIControlStateNormal];
    self.loginout.layer.masksToBounds =YES;
    self.loginout.layer.cornerRadius = 5;
    [self.loginout addTarget:self action:@selector(loginoutAct) forControlEvents:UIControlEventTouchUpInside];
    self.loginout.frame =CGRectMake(kRealValue(16), kRealValue(20), kRealValue(343), kRealValue(44));
   
    [self addSubview:self.loginout];
    
}

-(void)loginoutAct{
    
    if (self.LoginoutAct) {
        self.LoginoutAct();
    }
    
   
    
}

@end
