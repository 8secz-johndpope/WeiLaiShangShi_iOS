//
//  HSWallethotView.h
//  HSKD
//
//  Created by AllenQin on 2019/5/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSWallethotView : UIView

@property(nonatomic, strong)UIImageView *leftView;
@property(nonatomic, strong)UIImageView *rightView;

@property(nonatomic, strong)UILabel *todayValueLabel;
@property(nonatomic, strong)UILabel *allValueLabel;
@property(nonatomic, strong)UILabel *rightLabel;
@property(nonatomic, strong)UINavigationController *nav;

@end

NS_ASSUME_NONNULL_END
