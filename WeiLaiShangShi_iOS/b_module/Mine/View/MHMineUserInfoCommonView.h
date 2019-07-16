//
//  MHMineUserInfoCommonView.h
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHMineUserInfoCommonView : UIView
@property (nonatomic, strong)UIImageView *rightIcon;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *subtitle;
@property (nonatomic, strong)UILabel *righttitle;
-(id)initWithFrame:(CGRect)frame righttitle:(NSString *)righttitle lefttitle:(NSString *)lefttitle istopLine:(BOOL)isTopline isBottonLine:(BOOL)isbottomLine;
@end
