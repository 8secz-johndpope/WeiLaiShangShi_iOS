//
//  MHOrderDetailView.m
//  mohu
//
//  Created by AllenQin on 2018/10/12.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHOrderDetailView.h"

@implementation MHOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr withMoney:(NSString *)money withContent:(NSArray *)contentArr{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(10))];
        lineView1.backgroundColor = kBackGroudColor;
        [self addSubview:lineView1];
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

        NSArray *arr = @[@"支付方式",@"商品数量",@"商品总额",@"运费",@"总计"];
        
        
        for (int i = 0 ; i < 5; i++) {
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
            if (i == 4 || i == 3) {
                 label2.textColor = [UIColor colorWithHexString:@"#FF0116"];
            }else{
                 label2.textColor = [UIColor blackColor];
            }
           
            [sectionView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
                make.right.equalTo(self.mas_right).with.offset(-kRealValue(15));
            }];
            
        }
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(197), kScreenWidth, kRealValue(10))];
        lineView2.backgroundColor = kBackGroudColor;
        [self addSubview:lineView2];
//
//        //title
        UIView *titleView1 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(207), kScreenWidth, kRealValue(37))];
        titleView1.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleView1];
        UILabel *titleLabel3 = [[UILabel alloc] init];
        titleLabel3.text = @"订单信息";
        titleLabel3.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        titleLabel3.textColor = [UIColor blackColor];
        [titleView1 addSubview:titleLabel3];
        [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleView1.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(16));
        }];
        
        NSArray *arr1 = @[@"订单编号",@"下单时间",@"付款时间"];

        for (int i = 0 ; i < 3; i++) {
            UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(244) + (i*kRealValue(30)), kScreenWidth, kRealValue(30))];
            [self addSubview:sectionView];

            UILabel *label1 = [[UILabel alloc] init];
            label1.text = arr1[i];
            label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
            label1.textColor = [UIColor blackColor];
            [sectionView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
                make.left.equalTo(self.mas_left).with.offset(kRealValue(31));
            }];
            
            if ( i == 0 ) {
                NSString *desc = [NSString stringWithFormat:@"%@ | 复制",contentArr[i]];
                NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
                textdesc.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
                textdesc.color = [UIColor blackColor];
                [textdesc setTextHighlightRange:[desc rangeOfString:@"复制"]
                                          color:[UIColor colorWithHexString:@"689DFF"]
                                backgroundColor:[UIColor colorWithHexString:@"666666"]
                                      tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                          UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                                          pasteboard.string = contentArr[i];
                                          KLToast(@"复制成功");
                                      }];
                YYLabel *foot2Label = [YYLabel new];
                foot2Label.textAlignment = NSTextAlignmentRight;
                foot2Label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
                foot2Label.textColor = [UIColor blackColor];
                [sectionView addSubview:foot2Label];
                [foot2Label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
                    make.right.equalTo(self.mas_right).with.offset(-kRealValue(15));
                }];
                foot2Label.attributedText = textdesc;
                
            }else{
                UILabel *label2 = [[UILabel alloc] init];
                label2.text = contentArr[i];
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


        
        
    }
    return self;
}

@end
