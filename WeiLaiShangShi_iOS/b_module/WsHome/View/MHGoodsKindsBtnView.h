//
//  MHGoodsKindsBtnView.h
//  mohu
//
//  Created by 余浩 on 2018/9/15.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHGoodsKindsBtnView : UIView
-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr;
@property (nonatomic, strong)UILabel *titleLable;
@end
