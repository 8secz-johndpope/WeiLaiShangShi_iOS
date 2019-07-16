
//
//  MHBannerItem.m
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBannerItem.h"
@interface MHBannerItem ()
@property (nonatomic, weak) UILabel *label;
@end
@implementation MHBannerItem
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
//    UILabel *label = [[UILabel alloc]init];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:18];
//    [self addSubview:label];
//    _label = label;
    
    self.img = [[UIImageView alloc]init];
    self.img.layer.masksToBounds = YES;
    [self addSubview:self.img];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.img.frame = CGRectMake(0, 0, kRealValue(345), kRealValue(170));
}
@end
