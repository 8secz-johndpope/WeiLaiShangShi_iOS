//
//  MHSumbitFootView.m
//  mohu
//
//  Created by AllenQin on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHSumbitFootView.h"

@implementation MHSumbitFootView

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSArray *arr = @[@"商品数量",@"商品总额",@"运费"];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(10))];
        lineView.backgroundColor = kBackGroudColor;
        [self addSubview:lineView];
        
        //title
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(10), kScreenWidth, kRealValue(37))];
        titleView.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"支付信息";
        titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        titleLabel.textColor = [UIColor blackColor];
        [titleView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleView.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(16));
        }];
        
        for (int i = 0 ; i < 3; i++) {
            UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(47) + (i*kRealValue(30)), kScreenWidth, kRealValue(30))];
            [self addSubview:sectionView];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = arr[i];
            label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
            label1.textColor = [UIColor blackColor];
            [sectionView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
                make.left.equalTo(self.mas_left).with.offset(kRealValue(31));
            }];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.text = titleArr[i];
            label2.textAlignment = NSTextAlignmentRight;
            label2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
            label2.textColor = [UIColor blackColor];
            [sectionView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
                make.right.equalTo(self.mas_right).with.offset(-kRealValue(15));
            }];
            
        }
        
        
        
    }
    return self;
}
@end
