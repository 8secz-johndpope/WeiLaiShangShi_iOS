//
//  MHTaskDesImage.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskDesImage.h"

@implementation MHTaskDesImage
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
    self.desimageview = [[UIImageView alloc]init];
    self.desimageview.image = kGetImage(@"img_long_bg");
    [self addSubview:self.desimageview];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.desimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(375));
        make.height.mas_equalTo(kRealValue(402));
        make.left.equalTo(self.mas_left).offset(0);
    }];
}


@end
