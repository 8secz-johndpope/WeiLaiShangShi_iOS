//
//  HSTaskSkipCell.m
//  HSKD
//
//  Created by yuhao on 2019/2/28.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSTaskSkipCell.h"

@implementation HSTaskSkipCell
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
//    self.bgview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(12), 0,kScreenWidth- kRealValue(24), kRealValue(351))];
//    self.bgview.backgroundColor = KColorFromRGB(0xffffff);
//    [self addSubview:self.bgview];
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: self.bgview.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft |UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6,6)];
//    //创建 layer
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.bgview.bounds;
//    //赋值
//    maskLayer.path = maskPath.CGPath;
//    self.bgview.layer.mask = maskLayer;
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
