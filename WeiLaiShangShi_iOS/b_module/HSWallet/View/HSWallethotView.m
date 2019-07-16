//
//  HSWallethotView.m
//  HSKD
//
//  Created by AllenQin on 2019/5/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSWallethotView.h"
#import "RichStyleLabel.h"
#import "HSWalletTodayVC.h"
#import "UIControl+BlocksKit.h"
#import "HSWalletTodayVC.h"
#import "HSWalletAllView.h"
#import "MHWebviewViewController.h"
#import "HSWalletExplainVC.h"


@implementation HSWallethotView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *shouruLabel = [[UILabel alloc] init];
        shouruLabel.text = @"收入";
        shouruLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(16)];
        shouruLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:shouruLabel];
        [shouruLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(self.mas_left).offset(kRealValue(10));
        }];
        
        
        
        
        UIImageView *oneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(10), kRealValue(32), kRealValue(49), kRealValue(49))];
        oneImageView.image = kGetImage(@"wallet_today");
        [self addSubview:oneImageView];
        
        RichStyleLabel *todayLabel = [[RichStyleLabel alloc]initWithFrame:CGRectMake(kRealValue(70), kRealValue(30), kRealValue(150), kRealValue(30))];
        todayLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(16)];
        todayLabel.textColor =[UIColor colorWithHexString:@"#333333"];
        [self addSubview:todayLabel];
        
        [todayLabel setAttributedText:@"今日收入（火币）" withRegularPattern:@"[（火币）]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#666666"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(12)]}];
        
        UILabel *todayDescLabel = [[UILabel alloc] init];
        todayDescLabel.text = @"银勺及以上会员可全额兑换";
        todayDescLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        todayDescLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview:todayDescLabel];
        [todayDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(oneImageView.mas_bottom).offset(0);
            make.left.equalTo(self.mas_left).offset(kRealValue(70));
        }];
        
        
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0,kRealValue(100), kRealValue(345), 1/kScreenScale)];
        lineview.backgroundColor = KColorFromRGB(0xE2E2E2);
        [self addSubview:lineview];
        
        UIImageView *twoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(10), kRealValue(118), kRealValue(49), kRealValue(49))];
        twoImageView.image = kGetImage(@"wallet_all");
        [self addSubview:twoImageView];
        
        RichStyleLabel *allLabel = [[RichStyleLabel alloc]initWithFrame:CGRectMake(kRealValue(70), kRealValue(116), kRealValue(150), kRealValue(30))];
        allLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(16)];
        allLabel.textColor =[UIColor colorWithHexString:@"#333333"];
        [self addSubview:allLabel];
        
        [allLabel setAttributedText:@"累计收入（火币）" withRegularPattern:@"[（火币）]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#666666"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(12)]}];
        
        UILabel *allDescLabel = [[UILabel alloc] init];
        allDescLabel.text = @"银勺及以上会员可全额兑换";
        allDescLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        allDescLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview:allDescLabel];
        [allDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(twoImageView.mas_bottom).offset(0);
            make.left.equalTo(self.mas_left).offset(kRealValue(70));
        }];
        
        UIImageView *rightView = [[UIImageView alloc] init];
        rightView.image = kGetImage(@"leve_desc_arrow");
        [self addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRealValue(22));
            make.width.mas_equalTo(kRealValue(22));
            make.centerY.equalTo(twoImageView.mas_centerY).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(10));
        }];
        
        UIImageView *rightView1 = [[UIImageView alloc] init];
        rightView1.image = kGetImage(@"leve_desc_arrow");
        [self addSubview:rightView1];
        [rightView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRealValue(22));
            make.width.mas_equalTo(kRealValue(22));
            make.centerY.equalTo(oneImageView.mas_centerY).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(10));
        }];
        
        
        _todayValueLabel = [[UILabel alloc] init];
        _todayValueLabel.text = @"";
        _todayValueLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
        _todayValueLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:_todayValueLabel];
        [_todayValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(oneImageView.mas_centerY).offset(0);
            make.right.equalTo(rightView1.mas_left).offset(-kRealValue(1));
        }];
        
        
        _allValueLabel = [[UILabel alloc] init];
        _allValueLabel.text = @" ";
        _allValueLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
        _allValueLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:_allValueLabel];
        [_allValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(twoImageView.mas_centerY).offset(0);
            make.right.equalTo(rightView.mas_left).offset(-kRealValue(1));
        }];
        
        
        UILabel *gengduo = [[UILabel alloc] init];
        gengduo.text = @"更多";
        gengduo.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(16)];
        gengduo.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:gengduo];
        [gengduo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twoImageView.mas_bottom).offset(kRealValue(33));
            make.left.equalTo(self.mas_left).offset(kRealValue(10));
        }];
        
        
        self.leftView = [[UIImageView alloc]init];
        self.leftView.userInteractionEnabled = YES;
        self.leftView.image = kGetImage(@"wallet_left");
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClick)];
        
        [self.leftView addGestureRecognizer:tap1];
        [self addSubview:self.leftView];
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(gengduo.mas_bottom).offset(kRealValue(14));
            make.left.equalTo(self.mas_left).offset(kRealValue(10));
            make.size.mas_equalTo(CGSizeMake(kRealValue(153), kRealValue(88)));
        }];
        
        
        self.rightView = [[UIImageView alloc]init];
        [self addSubview:self.rightView];
        self.rightView.image = kGetImage(@"wallet_right");
        self.rightView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bossClick)];
        [self.rightView addGestureRecognizer:tap2];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(gengduo.mas_bottom).offset(kRealValue(14));
            make.right.equalTo(self.mas_right).offset(-kRealValue(10));
            make.size.mas_equalTo(CGSizeMake(kRealValue(153), kRealValue(88)));
        }];
        
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text = @"  ";
        _rightLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _rightLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        [self.rightView addSubview:_rightLabel];
        [self.rightLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightView.mas_top).offset(kRealValue(37));
            make.left.equalTo(self.rightView.mas_left).offset(kRealValue(14));
        }];
        
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.text = @"点击查看";
        leftLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        leftLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        [self.leftView addSubview:leftLabel];
        [leftLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftView.mas_top).offset(kRealValue(37));
            make.left.equalTo(self.leftView.mas_left).offset(kRealValue(14));
        }];
        
        
        UIView *todayClickView = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(32), kRealValue(350), kRealValue(86))];
        todayClickView.userInteractionEnabled = YES;
        todayClickView.backgroundColor = [UIColor clearColor];
        [self addSubview:todayClickView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            HSWalletTodayVC *vc = [[HSWalletTodayVC alloc] init];
            vc.allStr = [NSString stringWithFormat:@"%@",self.todayValueLabel.text];
            [_nav pushViewController:vc animated:YES];
        }];
        [todayClickView addGestureRecognizer:tap];
        
        
        UIView *ALlClickView = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(118), kRealValue(350), kRealValue(86))];
        ALlClickView.userInteractionEnabled = YES;
        ALlClickView.backgroundColor = [UIColor clearColor];
        [self addSubview:ALlClickView];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            HSWalletAllView *vc = [[HSWalletAllView alloc] init];
            vc.allStr = [NSString stringWithFormat:@"%@",self.allValueLabel.text];
            [_nav pushViewController:vc animated:YES];
        }];
        [ALlClickView addGestureRecognizer:tap3];
        
      
    }
    return self;
}

-(void)bossClick{
    
    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:[NSString stringWithFormat:@"%@/graphs.html",[GVUserDefaults standardUserDefaults].hostWapName] comefrom:@"mine"];
     [self.nav pushViewController:vc animated:YES];
}

-(void)shopClick{
    
    HSWalletExplainVC *vc = [[HSWalletExplainVC alloc]init];
    [self.nav pushViewController:vc animated:YES];
}
@end
