//
//  MHGuessActivityCell.h
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^tapActblock)(NSInteger index);
@interface MHGuessActivityCell : UITableViewCell
@property (nonatomic, strong)tapActblock tapactblock;
@property (nonatomic, strong) UILabel *title;
@property(nonatomic, strong) NSMutableArray *MHfuliArr;
@end
