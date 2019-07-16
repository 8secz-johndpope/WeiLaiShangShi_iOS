//
//  HSCircle.h
//  HSKD
//
//  Created by yuhao on 2019/2/27.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSCircle : UIView
-(instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth;
@property(nonatomic,assign)CGFloat progress;
@end

NS_ASSUME_NONNULL_END
