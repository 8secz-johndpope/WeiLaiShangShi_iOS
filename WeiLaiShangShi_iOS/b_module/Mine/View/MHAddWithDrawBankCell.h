//
//  MHAddWithDrawBankCell.h
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHAddWithDrawBankCell : UIView

@property(strong,nonatomic)UILabel *titleLabel;

@property(strong,nonatomic)UILabel *contentLabel;

@property (nonatomic,copy) void(^selectClick)(void);

@end

NS_ASSUME_NONNULL_END
