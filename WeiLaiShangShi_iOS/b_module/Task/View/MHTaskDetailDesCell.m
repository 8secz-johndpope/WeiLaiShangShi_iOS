//
//  MHTaskDetailDesCell.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskDetailDesCell.h"

@implementation MHTaskDetailDesCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)createview
{
    self.deslabel = [[UILabel alloc]init];
    self.deslabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.deslabel.textColor = KColorFromRGB(0x000000);
    self.deslabel.numberOfLines = 0;
    self.deslabel.textAlignment=NSTextAlignmentLeft;
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距设置为30
    [paragraphStyle  setLineSpacing:kRealValue(7)];
    NSString  *testString = @"山东省烟台栖霞红富士 \n天然味美，无污染，甜度高，水分足，\n 健康美味，礼宴佳品，可来果园亲手采摘亦可网络下单全国包邮。一箱五斤每箱35-80个大果，满十箱送一箱、满六箱优惠现金30元。\n 联系电话：\n 徐总 15553566678 \n乔女士 15165798079 \n广告来自》微广告";
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString length])];
    [self.deslabel setAttributedText:setString];
    [self addSubview:self.deslabel];
    
//    UIButton *copybtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [copybtn setTitle:@"复制文案" forState:UIControlStateNormal];
//    copybtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
//    copybtn.backgroundColor = KColorFromRGB(0xFF3344);
//    [copybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self addSubview:copybtn];
//    
//    [copybtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.deslabel.mas_bottom).offset(kRealValue(15));
//        make.width.mas_equalTo(kRealValue(153));
//        make.height.mas_equalTo(kRealValue(30));
//        make.left.mas_equalTo(kRealValue(111));
//    }];
//    [copybtn addTarget:self action:@selector(CppyAct) forControlEvents:UIControlEventTouchUpInside];
//    copybtn.layer.cornerRadius = kRealValue(15);
    
}

-(void)CppyAct
{
    if (self.CopyAct) {
        self.CopyAct();
    }
}


-(void)layoutSubviews{

    [super layoutSubviews];
    [self.deslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(343));
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.mas_top).offset(kRealValue(10));
    }];
}


@end
