//
//  MHSumbitFootView.h
//  mohu
//
//  Created by AllenQin on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHSumbitFootView : UIView

@property(strong,nonatomic) UILabel    *titlesLabel;

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr ;


@end
