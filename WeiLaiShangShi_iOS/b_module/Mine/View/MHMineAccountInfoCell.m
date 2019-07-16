//
//  MHMineAccountInfoCell.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHMineAccountInfoCell.h"
#import "MHWithDrawVC.h"

@implementation MHMineAccountInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(16), kRealValue(15), kRealValue(343), kRealValue(163))];
        bgView.userInteractionEnabled = YES;
        bgView.image = kGetImage(@"mine_user_bg");
        ViewRadius(bgView, 5);
        [self.contentView addSubview:bgView];
        
        UILabel *titlesLabel = [[UILabel alloc] init];
        titlesLabel.frame =CGRectMake(kRealValue(16), kRealValue(16), kRealValue(80), kRealValue(20));
        titlesLabel.text = @"账户余额";
        titlesLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(15)];
        titlesLabel.textColor = [UIColor whiteColor];
        titlesLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:titlesLabel];
        
        
        _richLabel = [[RichStyleLabel alloc]init];
        _richLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _richLabel.textColor =[UIColor colorWithHexString:@"#ffffff"];
        _richLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_richLabel];
        [_richLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).with.offset(kRealValue(45));
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(16));
            make.height.mas_equalTo(kRealValue(25));
        }];
        

        
        
        self.btn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(343) - kRealValue(76), kRealValue(46), kRealValue(60), kRealValue(24))];
        self.btn .backgroundColor = [UIColor whiteColor];
        self.btn .titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        [self.btn  setTitleColor:[UIColor colorWithHexString:@"#FF3344"] forState:UIControlStateNormal];
        [self.btn  setTitle:@"提现" forState:UIControlStateNormal];

        ViewRadius(self.btn , kRealValue(12));
        [bgView addSubview:self.btn ];
        
        _addLabel = [[UILabel alloc] init];
        _addLabel.frame = CGRectMake(0,  kRealValue(101), kRealValue(343)/4, kRealValue(25));
        _addLabel.text = @" ";
        _addLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
        _addLabel.textColor = [UIColor whiteColor];
        _addLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:_addLabel];
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.frame = CGRectMake(kRealValue(343)/4,  kRealValue(101), kRealValue(343)/4, kRealValue(25));
        _leftLabel.text = @" ";
        _leftLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
        _leftLabel.textColor = [UIColor whiteColor];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:_leftLabel];
        
        _midLabel = [[UILabel alloc] init];
        _midLabel.frame = CGRectMake(kRealValue(343)/4*2,  kRealValue(101), kRealValue(343)/4, kRealValue(25));
        _midLabel.text = @" ";
        _midLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
        _midLabel.textColor = [UIColor whiteColor];
        _midLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:_midLabel];
        
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.frame = CGRectMake(kRealValue(343)/4*3,  kRealValue(101), kRealValue(343)/4, kRealValue(25));
        _rightLabel.text = @" ";
        _rightLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
        _rightLabel.textColor = [UIColor whiteColor];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:_rightLabel];
        
        
        
        UILabel *addTitleLabel = [[UILabel alloc] init];
        addTitleLabel.frame = CGRectMake(0,  kRealValue(131), kRealValue(343)/4, kRealValue(20));
        addTitleLabel.text = @"冻结审核";
        addTitleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        addTitleLabel.textColor = [UIColor colorWithHexString:@"#F7CCB4"];
        addTitleLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:addTitleLabel];
        
        
        UILabel *leftTitleLabel = [[UILabel alloc] init];
        leftTitleLabel.frame = CGRectMake(kRealValue(343)/4,  kRealValue(131), kRealValue(343)/4, kRealValue(20));
        leftTitleLabel.text = @"今日收入";
        leftTitleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        leftTitleLabel.textColor = [UIColor colorWithHexString:@"#F7CCB4"];
        leftTitleLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:leftTitleLabel];
        
        UILabel *midTitleLabel = [[UILabel alloc] init];
        midTitleLabel.frame = CGRectMake(kRealValue(343)/4*2,  kRealValue(131), kRealValue(343)/4, kRealValue(20));
        midTitleLabel.text = @"累计收入";
        midTitleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        midTitleLabel.textColor = [UIColor colorWithHexString:@"#F7CCB4"];
        midTitleLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:midTitleLabel];
        
        
        UILabel *rightTitleLabel = [[UILabel alloc] init];
        rightTitleLabel.frame = CGRectMake(kRealValue(343)/4*3,  kRealValue(131), kRealValue(343)/4, kRealValue(20));
        rightTitleLabel.text = @"累计提现";
        rightTitleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        rightTitleLabel.textColor = [UIColor colorWithHexString:@"#F7CCB4"];
        rightTitleLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:rightTitleLabel];
        
    }
    return self;
}


@end
