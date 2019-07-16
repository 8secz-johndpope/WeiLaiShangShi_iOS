//
//  MHMineitemView.h
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHMineitemView : UIView
@property (nonatomic, strong)UIImageView *leftIcon;
@property (nonatomic, strong)UIImageView *rightIcon;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *subtitle;
@property (nonatomic, strong)UILabel *righttitle;

-(id)initWithFrame:(CGRect)frame title:(NSString *)title subtitle:(NSString *)subtitle imageStr:(NSString *)imageStr righttitle:(NSString *)righttitle
            isline:(BOOL)isline isRighttitle:(BOOL)isRight;
@end
