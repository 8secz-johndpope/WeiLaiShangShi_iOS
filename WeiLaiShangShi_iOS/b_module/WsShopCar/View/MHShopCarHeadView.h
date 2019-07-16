//
//  MHShopCarHeadView.h
//  mohu
//
//  Created by 余浩 on 2018/9/21.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartHeaderViewBlock)(BOOL isSelected);

typedef void(^gotoupgrade)(void);

@interface MHShopCarHeadView : UITableViewHeaderFooterView
@property (nonatomic, copy) ShopcartHeaderViewBlock shopcartHeaderViewBlock;
@property (nonatomic, copy) gotoupgrade Gotoupgrade;

@property (nonatomic,strong) UILabel  *titleLabel;

@property (nonatomic,strong) UIImageView  *leftImageView;

@property (nonatomic,strong) UILabel  *footLabel;

@property (nonatomic,strong) UILabel *goUpdatelabel;

@property (nonatomic,strong) UIImageView *imge;
- (void)configureShopcartHeaderViewWithBrandName:(NSString *)brandName imgaeurl:(NSString *)imageurl brandSelect:(BOOL)brandSelect  userInfo:(NSString *)userinfo;
@end
