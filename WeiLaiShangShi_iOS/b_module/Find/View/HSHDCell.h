//
//  HSHDCell.h
//  HSKD
//
//  Created by AllenQin on 2019/4/25.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSHDModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface HSHDCell : UITableViewCell

@property(strong,nonatomic)UIImageView *bgView;

@property(strong,nonatomic)UIButton *signBtn;

-(void)createModel:(HSHDModel *)model;

@end

NS_ASSUME_NONNULL_END
