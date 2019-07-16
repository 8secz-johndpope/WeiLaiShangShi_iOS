//
//  MHOrderDetailView.h
//  mohu
//
//  Created by AllenQin on 2018/10/12.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHOrderDetailView : UIView


@property(strong,nonatomic) UILabel    *titlesLabel;

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr  withMoney:(NSString *)money withContent:(NSArray *)contentArr ;

@end

NS_ASSUME_NONNULL_END
