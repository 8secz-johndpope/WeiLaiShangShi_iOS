//
//  MHGoodsKindsBtnView.m
//  mohu
//
//  Created by 余浩 on 2018/9/15.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHGoodsKindsBtnView.h"

@implementation MHGoodsKindsBtnView

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(50), kRealValue(50))];
        //        imageView.backgroundColor =[UIColor redColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageStr]] placeholderImage:[UIImage imageNamed:imageStr]];
        [self addSubview:imageView];
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(55), frame.size.width, 20)];
        self.titleLable.text = title;
        self.titleLable.textColor = [UIColor blackColor];
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.titleLable.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
        [self addSubview:self.titleLable];
        self.titleLable.centerX = imageView.centerX;
    }
    return self;
}

@end
