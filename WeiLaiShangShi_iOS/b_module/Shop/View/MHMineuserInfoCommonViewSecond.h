//
//  MHMineuserInfoCommonViewSecond.h
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHMineuserInfoCommonViewSecond : UIView
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *righttitle;
@property (nonatomic, strong)UILabel *rightSubtitle;
@property (nonatomic, strong) UIView *smallline;
-(id)initWithFrame:(CGRect)frame lefttitle:(NSString *)lefttitle righttitle:(NSString *)righttitle rightSubtitle:(NSString *)rightSubtitle istopLine:(BOOL)isTopline isBottonLine:(BOOL)isbottomLine;
@end
