//
//  HSShopNewCell.h
//  HSKD
//
//  Created by AllenQin on 2019/2/26.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSShopNewCell : UITableViewCell

@property(strong,nonatomic)UINavigationController *shopNav;

@property(strong,nonatomic)NSArray *itemArr;

- (void)creatItemArr:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
