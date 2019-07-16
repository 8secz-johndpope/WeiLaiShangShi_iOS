//
//  HSTsakSectionHeadCell.m
//  HSKD
//
//  Created by yuhao on 2019/2/28.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSTsakSectionHeadCell.h"

@implementation HSTsakSectionHeadCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColorFromRGB(0xF1F2F1);
        [self createview];
    }
    return self;
}
-(void)createview
{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(12), kRealValue(0), kScreenWidth - kRealValue(24), kRealValue(50))];
    bgview.backgroundColor = KColorFromRGB(0xffffff);
    [self addSubview:bgview];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: bgview.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6,6)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bgview.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    bgview.layer.mask = maskLayer;
    
    self.titlelabel = [[UILabel alloc]init];
    self.titlelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    self.titlelabel.textColor = KColorFromRGB(0x222222);
    self.titlelabel.textAlignment = NSTextAlignmentCenter;
    self.titlelabel.text = @"福利任务";
    [self addSubview:self.titlelabel];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(kRealValue(0));
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(0));
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
