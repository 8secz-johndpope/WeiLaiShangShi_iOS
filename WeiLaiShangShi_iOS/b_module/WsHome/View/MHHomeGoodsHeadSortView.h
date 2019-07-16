//
//  MHHomeGoodsHeadSortView.h
//  mohu
//
//  Created by 余浩 on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^sortBykey)(NSString *typeID, NSString *brandname , NSString * maxprice, NSString * minprice,NSString *titlename);

@interface MHHomeGoodsHeadSortView : UIView

@property(nonatomic, copy)sortBykey sortwithkey;
/*
 *隐藏弹窗
 */
-(void)hideView;
/*
 *展示弹窗
 */
-(void)showAlert;
/*
 *初始化方法,height是白色区域的高度
 */
-(instancetype)initWithFrame:(CGRect)frame width:(NSInteger)width dataArr:(NSMutableDictionary*)dict typeid:(NSString *)typeId;

/*
 *初始化方法,给数据
 */

@end
