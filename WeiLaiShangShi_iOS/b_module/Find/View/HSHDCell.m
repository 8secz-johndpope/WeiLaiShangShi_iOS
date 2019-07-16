//
//  HSHDCell.m
//  HSKD
//
//  Created by AllenQin on 2019/4/25.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSHDCell.h"

@implementation HSHDCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(15), 0,kRealValue(345) , kRealValue(105))];
        ViewRadius(self.bgView, kRealValue(8));
        [self.contentView addSubview:_bgView];
        
        self.signBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(88) , kRealValue(10), kRealValue(58), kRealValue(22))];

        self.signBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
        [self.bgView addSubview:self.signBtn];

        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.signBtn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(kRealValue(11), kRealValue(11))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.signBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        self.signBtn.layer.mask = maskLayer;
        
    }
    return self;
}


-(void)createModel:(HSHDModel *)model{

    [self.bgView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:kGetImage(@"emty_movie")];
    if ([model.state isEqualToString:@"GOING"]) {
        self.signBtn.backgroundColor = [UIColor colorWithHexString:@"#FD7215"];
        [self.signBtn setTitle:@"进行中" forState:0];
        [self.signBtn setTitleColor:[UIColor colorWithHexString:@"#FFF7F7"] forState:0];
    }else if ([model.state isEqualToString:@"END"]) {
        self.signBtn.backgroundColor = [UIColor colorWithHexString:@"#999999"];
        [self.signBtn setTitle:@"已结束" forState:0];
        [self.signBtn setTitleColor:[UIColor colorWithHexString:@"#FFF7F7"] forState:0];
    }else if ([model.state isEqualToString:@"UNBEGIN"]){
        self.signBtn.backgroundColor = [UIColor colorWithHexString:@"#FD7215"];
        [self.signBtn setTitle:@"未开始" forState:0];
        [self.signBtn setTitleColor:[UIColor colorWithHexString:@"#FFF7F7"] forState:0];
    }
}

@end
