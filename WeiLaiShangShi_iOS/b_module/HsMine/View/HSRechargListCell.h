//
//  HSRechargListCell.h
//  HSKD
//
//  Created by AllenQin on 2019/3/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSRechargListCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *headView ;
@property (nonatomic, strong) UILabel *jifenLabel;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UILabel *paimingLabel;
@property (nonatomic, strong) UIImageView *paimingView;

@end

NS_ASSUME_NONNULL_END
