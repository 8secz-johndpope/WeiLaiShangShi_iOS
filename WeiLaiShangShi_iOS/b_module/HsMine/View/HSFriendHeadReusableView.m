//
//  HSFriendHeadReusableView.m
//  HSKD
//
//  Created by AllenQin on 2019/5/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSFriendHeadReusableView.h"

@implementation HSFriendHeadReusableView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(15), 0, kScreenWidth - kRealValue(31), kRealValue(103))];
        header.image = kGetImage(@"auforce_bg2");
//        header.backgroundColor = [UIColor colorWithHexString:@"#FF8F0D"];
        [self addSubview:header];
        ViewRadius(header, kRealValue(4));
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"我的友力值";
        titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
        titleLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        [header addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(header.mas_top).offset(kRealValue(21));
            make.left.equalTo(header.mas_left).offset(kRealValue(15));
        }];
        
        
        self.ylzLabel = [[UILabel alloc] init];
//        self.ylzLabel.text = @"80000";
        self.ylzLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(30)];
        self.ylzLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        [header addSubview:self.ylzLabel];
        [self.ylzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(header.mas_top).offset(kRealValue(40));
            make.left.equalTo(titleLabel.mas_left).offset(0);
        }];
        
        
        
        UILabel *titleLabel1 = [[UILabel alloc] init];
        titleLabel1.text = @"累计消耗友力值";
        titleLabel1.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(11)];
        titleLabel1.textColor = [UIColor colorWithHexString:@"#ffffff"];
        [header addSubview:titleLabel1];
        [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(titleLabel.mas_bottom).offset(0);
            make.right.equalTo(header.mas_right).offset(-kRealValue(74));
        }];
        
        
        self.allLabel = [[UILabel alloc] init];
//        self.allLabel.text = @"80000";
        self.allLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(16)];
        self.allLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        [header addSubview:self.allLabel];
        [self.allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(header.mas_top).offset(kRealValue(50));
            make.left.equalTo(titleLabel1.mas_left).offset(0);
        }];
        
        
        self.yaoqing = [[UIImageView alloc]init];
        self.yaoqing.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
        [self.yaoqing addGestureRecognizer:tap];
        [self addSubview:self.yaoqing];
        [self.yaoqing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.width.mas_equalTo(kRealValue(358));
            make.height.mas_equalTo(kRealValue(70));
            make.top.equalTo(header.mas_bottom).offset(kRealValue(17));
        }];
        
        UIView *arrowView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(15), kRealValue(207), kRealValue(3), kRealValue(16))];
        arrowView.backgroundColor = [UIColor colorWithHexString:@"#F6AE18"];
        [self addSubview:arrowView];
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = @"火币兑换";
        textLabel.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(16)];
        textLabel.textColor = [UIColor colorWithHexString:@"222222"];
        [self addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(arrowView.mas_centerY).offset(0);
            make.left.equalTo(arrowView.mas_right).offset(kRealValue(5));
        }];
        
        
        self.descLabel = [[UILabel alloc] init];
        self.descLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
        self.descLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(textLabel.mas_centerY).offset(0);
            make.left.equalTo(textLabel.mas_right).offset(kRealValue(5));
        }];
        
        
        self.tf = [[CSMoneyTextField alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(240), kRealValue(259), kRealValue(43))];
        self.tf.borderStyle = UITextBorderStyleRoundedRect;
        self.tf.placeholder = @"输入兑换友力值数额";
        self.tf.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(13)];
        self.tf.keyboardType = UIKeyboardTypeNumberPad;
        self.tf.limit.max = @"9999999";
        [self addSubview:self.tf];
        
        
        UIButton *jhBtn = [[UIButton alloc] init];
        [jhBtn setTitle:@"兑换" forState:0];
        [jhBtn addTarget:self action:@selector(jihuo) forControlEvents:UIControlEventTouchUpInside];
        jhBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        [jhBtn setTitleColor:[UIColor colorWithHexString:@"#F6AE18"] forState:0];
        ViewBorderRadius(jhBtn, kRealValue(15), 1, [UIColor colorWithHexString:@"#F6AE18"]);
        [self addSubview:jhBtn];
        [jhBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.tf.mas_centerY).offset(0);
            make.left.equalTo(self.tf.mas_right).offset(kRealValue(10));
            make.height.mas_equalTo(kRealValue(30));
            make.width.mas_equalTo(kRealValue(72));
        }];
        
        self.stateLabel = [[UILabel alloc] init];
        self.stateLabel.font = [UIFont fontWithName:kPingFangLight size:kRealValue(13)];
        self.stateLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        [self addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tf.mas_bottom).offset(kRealValue(7));
            make.left.equalTo(self.mas_left).offset(kRealValue(15));
        }];
        
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"#F2F3F3"];
        [self addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-kRealValue(52));
            make.left.equalTo(self.mas_left).offset(0);
            make.height.mas_equalTo(kRealValue(10));
            make.width.mas_equalTo(kScreenWidth);
        }];
        
        
        UIView *arrowView1 = [[UIView alloc]init];
        arrowView1.backgroundColor = [UIColor colorWithHexString:@"#F6AE18"];
        [self addSubview:arrowView1];
        [arrowView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineLabel.mas_bottom).offset(kRealValue(21));
            make.left.equalTo(self.mas_left).offset(kRealValue(15));
            make.height.mas_equalTo(kRealValue(16));
            make.width.mas_equalTo(kRealValue(3));
        }];
        
        UILabel *textLabel1 = [[UILabel alloc] init];
        textLabel1.text = @"现金充值";
        textLabel1.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(16)];
        textLabel1.textColor = [UIColor colorWithHexString:@"222222"];
        [self addSubview:textLabel1];
        [textLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(arrowView1.mas_centerY).offset(0);
            make.left.equalTo(arrowView1.mas_right).offset(kRealValue(5));
        }];
        

        
//        UILabel *topLine = [[UILabel alloc] init];
//        topLine.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
//        [self addSubview:topLine];
//        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.mas_bottom).offset(0);
//            make.left.equalTo(self.mas_left).offset(kRealValue(15));
//            make.height.mas_equalTo(1);
//            make.width.mas_equalTo(kRealValue(345));
//        }];
    }
    return self;
    
}



-(void)imageTap{
    if (self.imageClick) {
        self.imageClick();
    }
}

-(void)jihuo{
    if (self.exchargeClick) {
        self.exchargeClick(_tf.text);
    }
}

@end
