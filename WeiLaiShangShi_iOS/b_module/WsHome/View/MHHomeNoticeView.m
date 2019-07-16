
//
//  MHHomeNoticeView.m
//  mohu
//
//  Created by 余浩 on 2018/9/15.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHHomeNoticeView.h"

@implementation MHHomeNoticeView

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr{
    self = [super initWithFrame:frame];
    if (self) {
      self.backgroundColor =KColorFromRGBA(0x000000, 0.5);
      self.layer.cornerRadius = 11;
    [self addSubview:self.noticelabel];
    [self.noticelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(kRealValue(25));
    }];
    [self addSubview:self.headImageView];
    }
    return self;
}
-(UILabel *)noticelabel
{
    if (!_noticelabel) {
        _noticelabel = [[UILabel alloc]init];
        _noticelabel.textColor = [UIColor whiteColor];
        _noticelabel.font = [UIFont fontWithName:kPingFangRegular size:11];
//        _noticelabel.text = @"“能被****有幸”刚刚升级了店主>";
    }
    return _noticelabel;
}
-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kRealValue(22), kRealValue(22))];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = kRealValue(11);
    }
    return _headImageView;
}
@end
