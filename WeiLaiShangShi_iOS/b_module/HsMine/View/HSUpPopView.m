//
//  HSUpPopView.m
//  HSKD
//
//  Created by AllenQin on 2019/3/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSUpPopView.h"

@interface HSUpPopView ()

/** 背景层 */
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation HSUpPopView


- (instancetype)initWithFrame:(CGRect)frame
                     shopList:(NSArray *)shopListArr
                      payList:(NSArray *)payList {
    self = [super initWithFrame:frame];
    if (self) {
        self.shopListArr = shopListArr;
        self.payList = payList;
        self.selectIndex = -1;
        //黑色边框
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.3f;
        [self addSubview:_backgroundView];

        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kRealValue(250)+[payList count]*kRealValue(59))];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
        nameLabel .textColor =[UIColor colorWithHexString:@"#222222"];
        nameLabel .numberOfLines = 1;
        nameLabel.text =  @"确认付款";
        [_contentView addSubview: nameLabel];
        [nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(kRealValue(13));
            make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        }];
        
        //
        UIButton *closeBtn = [[UIButton alloc] init];
        [closeBtn setBackgroundImage:kGetImage(@"ic_cloos_dark") forState:UIControlStateNormal];
        [self.contentView addSubview:closeBtn];
        
        [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(23), kRealValue(23)));
            make.centerY.equalTo(nameLabel.mas_centerY).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(20));
        }];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(46) - 1/kScreenScale, kScreenWidth, 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
        [self.contentView addSubview:lineView];
        
        UILabel *leftLabel = [[UILabel alloc]init];
        leftLabel .font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        leftLabel .textColor =[UIColor colorWithHexString:@"#222222"];
        leftLabel .numberOfLines = 1;
        
        leftLabel.text =  [shopListArr[0] valueForKey:@"productName"];
        [_contentView addSubview: leftLabel];
        [leftLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_top).with.offset(kRealValue(35));
            make.width.mas_equalTo(kScreenWidth/3*2);
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(21));
        }];
        
        UILabel *moneyLabel = [[UILabel alloc]init];
        moneyLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(27)];
        moneyLabel .textColor =[UIColor colorWithHexString:@"#222222"];
        moneyLabel .numberOfLines = 1;
        moneyLabel.text =  [NSString stringWithFormat:@"￥%@",[shopListArr[0] valueForKey:@"retailPrice"]];
        [self.contentView addSubview:moneyLabel];
        [moneyLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(-kRealValue(20));
            make.centerY.equalTo(leftLabel.mas_centerY).with.offset(0);
        }];

        
        UIView *sectionView = [[UIView alloc] init];
        sectionView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        [self.contentView addSubview:sectionView];
        [sectionView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(kRealValue(123));
            make.left.equalTo(self.contentView.mas_left).with.offset(0);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(kRealValue(45));
        }];

        UILabel *sectionLabel = [[UILabel alloc]init];
        sectionLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        sectionLabel .textColor =[UIColor colorWithHexString:@"#666666"];
        sectionLabel .numberOfLines = 1;
        sectionLabel.text =  @"支付方式";
        [sectionView addSubview:sectionLabel];
        [sectionLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(20));
            make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
        }];
        
        if ([payList count] == 2) {
            UIView *lineView1 = [[UIView alloc] init];
            lineView1.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
            [self.contentView addSubview:lineView1];
            [lineView1  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).with.offset(0);
                make.top.equalTo(sectionView.mas_bottom).with.offset(kRealValue(59));
                make.width.mas_equalTo(kScreenWidth);
                make.height.mas_equalTo(1/kScreenScale);
            }];
        }else   if ([payList count] == 3){
            UIView *lineView1 = [[UIView alloc] init];
            lineView1.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
            [self.contentView addSubview:lineView1];
            [lineView1  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).with.offset(0);
                make.top.equalTo(sectionView.mas_bottom).with.offset(kRealValue(59));
                make.width.mas_equalTo(kScreenWidth);
                make.height.mas_equalTo(1/kScreenScale);
            }];
            
            UIView *lineView2 = [[UIView alloc] init];
            lineView2.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
            [self.contentView addSubview:lineView2];
            [lineView2  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).with.offset(0);
                make.top.equalTo(sectionView.mas_bottom).with.offset(kRealValue(118));
                make.width.mas_equalTo(kScreenWidth);
                make.height.mas_equalTo(1/kScreenScale);
            }];
        }
        

        
        
        
        for (int i = 0 ; i< [payList count]; i++) {
            UIImageView *leftImageView1 = [[UIImageView alloc] init];
           
            [self.contentView addSubview:leftImageView1];
            [leftImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kRealValue(23), kRealValue(23)));
                make.top.equalTo(sectionView.mas_bottom).with.offset(kRealValue(18) +i *kRealValue(59));
                make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(20));
            }];
            
            UILabel *titleLabel1 = [[UILabel alloc] init];
            
            titleLabel1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
            titleLabel1.textColor = [UIColor colorWithHexString:@"#666666"];
            [self.contentView addSubview:titleLabel1];
            [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(leftImageView1.mas_centerY).with.offset(0);
                make.left.equalTo(leftImageView1.mas_right).with.offset(kRealValue(12));
            }];
            
            UIButton *selectBtn = [[UIButton alloc] init];
            selectBtn.userInteractionEnabled = NO;
            [selectBtn setBackgroundImage:kGetImage(@"ic_choice_unselect_border") forState:UIControlStateNormal];
            [selectBtn setBackgroundImage:kGetImage(@"ic_choice_select") forState:UIControlStateSelected];
            selectBtn.selected = NO;
            selectBtn.tag = 7621+i;
            [self.contentView addSubview:selectBtn];
            [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kRealValue(23), kRealValue(23)));
                make.centerY.equalTo(leftImageView1.mas_centerY).with.offset(0);
                make.right.equalTo(self.contentView.mas_right).with.offset(-kRealValue(20));
            }];
            NSDictionary *payType  = payList[i];
            [leftImageView1 sd_setImageWithURL:[NSURL URLWithString:payType[@"icon"]]];
            titleLabel1.text = payType[@"name"];
            if (i == 0) {
                selectBtn.selected = YES;
                 self.selectIndex = 0;
            }
            UIButton *payBtn = [[UIButton alloc] init];
            [payBtn addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
            payBtn.tag = 7721+i;

            [self.contentView addSubview:payBtn];
            [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kRealValue(59));
                make.top.equalTo(sectionView.mas_bottom).with.offset(i *kRealValue(59));
                make.width.mas_equalTo(kRealValue(kScreenWidth));
                make.left.equalTo(sectionView.mas_left).offset(0);
            }];
            
        }
        

        UIButton *loginBtn = [[UIButton alloc] init];
        [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [loginBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#FD7215"]];
        loginBtn.layer.masksToBounds = YES;
        loginBtn.layer.cornerRadius = kRealValue(3);
        [self.contentView addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRealValue(44));
            make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
            make.width.mas_equalTo(kRealValue(334));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-kRealValue(19));
        }];
        
        
        
        

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBGLayer:)];
        [_backgroundView addGestureRecognizer:tap];
        
        
                                  
    }
    return self;
}


-(void)login{
    if (self.selectIndex == -1) {
        KLToast(@"请选择支付方式");
    }
    if (self.payClick) {
        self.payClick(self.payList[self.selectIndex][@"type"], self.shopListArr[0]);
    }
}


-(void)payClick:(UIButton *)sender{
    
    UIButton *selectBtn1 = [self viewWithTag:7621];
    UIButton *selectBtn2 = [self viewWithTag:7622];
    UIButton *selectBtn3 = [self viewWithTag:7623];
    
    if (sender.tag ==  7721) {
        selectBtn1.selected = YES;
        selectBtn2.selected = NO;
        selectBtn3.selected = NO;
         self.selectIndex = 0;
    }
    if (sender.tag ==  7722) {
        selectBtn1.selected = NO;
        selectBtn2.selected = YES;
          selectBtn3.selected = NO;
        self.selectIndex = 1;
    }
    
    if (sender.tag ==  7723) {
        selectBtn1.selected = NO;
        selectBtn2.selected = NO;
        selectBtn3.selected = YES;
        self.selectIndex = 2;
    }
}

#pragma mark 点击背景(Click background)
- (void)tapBGLayer:(UITapGestureRecognizer *)tap{
    [self dismiss];
}


-(void)closeClick{
     [self dismiss];
}

-(void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth,kRealValue(250)+[self.payList count]*kRealValue(59));
        self.alpha = 0.0;
        self.backgroundView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
    }];
    //不加上移不掉
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{//2秒以后移除
        [self removeFromSuperview];
    });
}



-(void)pop{
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(0, kScreenHeight - kRealValue(250)-[self.payList count]*kRealValue(59), kScreenWidth, kRealValue(250)+[self.payList count]*kRealValue(59));
    }];

    
    
}

@end
