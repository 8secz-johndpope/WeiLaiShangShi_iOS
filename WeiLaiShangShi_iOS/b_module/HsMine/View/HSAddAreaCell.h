//
//  HSAddAreaCell.h
//  HSKD
//
//  Created by AllenQin on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSAddAreaCell : UIView

@property(strong,nonatomic)UILabel *titleLabel;

@property(strong,nonatomic)UILabel *contentLabel;

@property (nonatomic,copy) void(^selectClick)(void);

@end

NS_ASSUME_NONNULL_END
