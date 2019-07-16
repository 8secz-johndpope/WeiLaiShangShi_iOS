//
//  MHGoodsKindsCell.h
//  mohu
//
//  Created by 余浩 on 2018/9/15.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HomepageItemchooseBlock)(NSInteger type ,NSString *titile);

@interface MHGoodsKindsCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray ImageArray:(NSMutableArray *)ImageArray;
@property (nonatomic, strong)NSMutableArray *Arr;
@property(copy,nonatomic)HomepageItemchooseBlock block;


@end
