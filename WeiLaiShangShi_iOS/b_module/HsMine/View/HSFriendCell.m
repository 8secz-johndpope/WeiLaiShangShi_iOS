//
//  HSFriendCell.m
//  HSKD
//
//  Created by AllenQin on 2019/5/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSFriendCell.h"

@implementation HSFriendCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

//        UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(172), kRealValue(171), 1)];
//        topLine.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
//        [self.contentView addSubview:topLine];
//        
//        
//        self.leftLine = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(171), 0, 1, kRealValue(173))];
//        self.leftLine .backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
//        [self.contentView addSubview:self.leftLine ];

        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(18), kRealValue(17), kRealValue(141), kRealValue(64))];
        bgView.image = kGetImage(@"ylz_buy");
        [self.contentView addSubview:bgView];
        
        
        UILabel *textLabel1 = [[UILabel alloc] init];
        textLabel1.text = @"友力值";
        textLabel1.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
        textLabel1.textColor = [UIColor colorWithHexString:@"#FDE5B4"];
        [self addSubview:textLabel1];
        [textLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView.mas_centerX).offset(0);
            make.bottom.equalTo(bgView.mas_bottom).offset(-kRealValue(5));
        }];
        
        self.ylzLabel =  [[UILabel alloc] init];
//        self.ylzLabel.text = @"2000";
        self.ylzLabel.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(30)];
        self.ylzLabel.textColor = [UIColor colorWithHexString:@"#FFEED1"];
        [self addSubview:self.ylzLabel];
        [self.ylzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView.mas_centerX).offset(0);
            make.bottom.equalTo(textLabel1.mas_top).offset(0);
        }];
        
        
        self.priceLabel = [[RichStyleLabel alloc]initWithFrame:CGRectMake(0, kRealValue(90), kRealValue(100), kRealValue(30))];
        self.priceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        self.priceLabel.textColor =[UIColor colorWithHexString:@"#222222"];
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.priceLabel];
        
        self.priceLabel.centerX  = bgView.centerX;
        
        UIButton *jhBtn = [[UIButton alloc] init];
        [jhBtn setTitle:@"立即购买" forState:0];
        jhBtn.userInteractionEnabled = NO;
        jhBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        [jhBtn setTitleColor:[UIColor colorWithHexString:@"#FDA119"] forState:0];
        ViewBorderRadius(jhBtn, kRealValue(15), 1, [UIColor colorWithHexString:@"#FDA119"]);
        [self.contentView addSubview:jhBtn];
        [jhBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView.mas_centerX).offset(0);
            make.top.equalTo(self.mas_top).offset(kRealValue(122));
            make.height.mas_equalTo(kRealValue(30));
            make.width.mas_equalTo(kRealValue(100));
        }];
        
    }
    return self;
}


- (void)createModel:(HSShopItemModel *)model{
    
    self.ylzLabel.text = model.productStandard;
   [self.priceLabel setAttributedText:[NSString stringWithFormat:@"%@元",model.retailPrice] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#FDA119"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(14)]}];
}

@end
