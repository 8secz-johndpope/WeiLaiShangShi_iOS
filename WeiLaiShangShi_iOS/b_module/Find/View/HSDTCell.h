//
//  HSDTCell.h
//  HSKD
//
//  Created by AllenQin on 2019/5/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSDTCell : UITableViewCell

@property(strong,nonatomic)UIImageView *bgView;

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *datetitle;

@end

NS_ASSUME_NONNULL_END
