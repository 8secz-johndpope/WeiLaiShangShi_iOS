//
//  MHHomeNoticeView.h
//  mohu
//
//  Created by 余浩 on 2018/9/15.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHHomeNoticeView : UIView
-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr;
@property(nonatomic, strong)UIImageView *headImageView;
@property(nonatomic, strong)UILabel *noticelabel;
@end
