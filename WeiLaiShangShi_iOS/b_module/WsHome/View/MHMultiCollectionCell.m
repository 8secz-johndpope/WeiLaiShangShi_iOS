//
//  MHMultiCollectionCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/8.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHMultiCollectionCell.h"

@implementation MHMultiCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //图片
        _imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(0);
            make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kRealValue(70),kRealValue(70)));
        }];
        //文字
        _titile = [[UILabel alloc] init];
        _titile.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titile.textAlignment = NSTextAlignmentCenter;
        _titile.textColor = [UIColor colorWithHexString:@"#6E6E6E"];
        [self.contentView addSubview:_titile];
        [_titile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).with.offset(kRealValue(5));
            make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
            make.width.mas_equalTo(kRealValue(70));
        }];
        
    }
    return self;
}

@end
