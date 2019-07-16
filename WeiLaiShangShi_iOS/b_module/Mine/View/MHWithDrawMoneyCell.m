//
//  MHWithDrawMoneyCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHWithDrawMoneyCell.h"


@implementation MHWithDrawMoneyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(60))];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        UILabel *titlesLabel = [[UILabel alloc]init];
        titlesLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(24)];
        titlesLabel.textColor =[UIColor colorWithHexString:@"222222"];
        titlesLabel.text  = @"￥";
        [bgView addSubview:titlesLabel];
        [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(15));
            make.height.mas_equalTo(kRealValue(44));
        }];
        
        
        
        self.tf = [[CSMoneyTextField alloc] initWithFrame:CGRectMake(kRealValue(42), kRealValue(5), kRealValue(200), kRealValue(44))];
        self.tf.borderStyle = UITextBorderStyleNone;
        self.tf.tag = 6666;
        self.tf.placeholder = @"请输入提现金额";
        self.tf.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(21)];
        self.tf.keyboardType = UIKeyboardTypeNumberPad;
        self.tf.limit.delegate = self;
        self.tf.limit.max = @"9999999.99";
        [bgView addSubview:self.tf];
        self.tf.centerY  = bgView.centerY;
        
        
        UILabel *lineView  = [[UILabel alloc]init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
        [bgView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(15));
            make.width.mas_equalTo(kScreenWidth - kRealValue(30));
            make.height.mas_equalTo(1/kScreenScale);
            make.top.equalTo(bgView.mas_top).offset(kRealValue(58));
        }];
        
        
        self.stateLabel = [[UILabel alloc]init];
        self.stateLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.stateLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        self.stateLabel.tag  = 8527;
        [self addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).with.offset(kRealValue(10));
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(15));
        }];
        
        
    }
    
    return self;
}

#pragma mark -CSMoneyTFLimitDelegate
- (void)valueChange:(id)sender{
//    _stateLabel.text  = @"余额不足";
//    if ([sender isKindOfClass:[CSMoneyTextField class]]) {
//        CSMoneyTextField *tf = (CSMoneyTextField *)sender;
//        if ([tf.text doubleValue] > [self.maxString doubleValue]) {
//            _stateLabel.hidden = NO;
//        }else{
//            _stateLabel.hidden = YES;
//        }
//    }
}

@end
