//
//  MHMineUserInfoCommonViewThrid.h
//  mohu
//
//  Created by yuhao on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHMineUserInfoCommonViewThrid : UIView
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UITextField *textfield;
-(id)initWithFrame:(CGRect)frame lefttitle:(NSString *)lefttitle textfield:(NSString *)textfield  istopLine:(BOOL)isTopline isBottonLine:(BOOL)isbottomLine;
@end
