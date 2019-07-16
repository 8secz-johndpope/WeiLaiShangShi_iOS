//
//  MHActivityCell.h
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HomepageItemEnterDetailBlock)(NSInteger type);
@interface MHActivityCell : UITableViewCell
@property(copy,nonatomic)HomepageItemEnterDetailBlock block;
@property(nonatomic, strong) NSArray *ActivityArr;
@end
