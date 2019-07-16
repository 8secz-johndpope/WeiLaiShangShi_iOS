


//
//  MHBannerProductItem.m
//  mohu
//
//  Created by yuhao on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBannerProductItem.h"

@implementation MHBannerProductItem
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}


- (void)addLabel {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    [self addSubview:label];
    _label = label;
    
    self.img = [[UIImageView alloc]init];
    self.img.layer.masksToBounds = YES;
    [self addSubview:self.img];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.img.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
}
@end
