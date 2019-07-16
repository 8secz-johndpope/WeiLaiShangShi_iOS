//
//  HSMineuserInfoCommonViewSecond.h
//  HSKD
//
//  Created by yuhao on 2019/3/18.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSMineuserInfoCommonViewSecond : UIView
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UIImageView *LeftIcon;
@property (nonatomic, strong)UILabel *righttitle;
@property (nonatomic, strong)UILabel *rightSubtitle;
@property (nonatomic, strong) UIView *smallline;
-(id)initWithFrame:(CGRect)frame lefttitle:(NSString *)lefttitle righttitle:(NSString *)righttitle rightSubtitle:(NSString *)rightSubtitle istopLine:(BOOL)isTopline isBottonLine:(BOOL)isbottomLine;
-(id)initWithFrame:(CGRect)frame lefttitle:(NSString *)lefttitle LeftIcon:(NSString *)leftIcon righttitle:(NSString *)righttitle rightSubtitle:(NSString *)rightSubtitle istopLine:(BOOL)isTopline isBottonLine:(BOOL)isbottomLine;
@end

NS_ASSUME_NONNULL_END
