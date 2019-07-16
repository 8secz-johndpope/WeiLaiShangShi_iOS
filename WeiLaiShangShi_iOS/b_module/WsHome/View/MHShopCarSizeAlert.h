//
//  MHShopCarSizeAlert.h
//  mohu
//
//  Created by 余浩 on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ShopCarCountViewAddBlock)(NSInteger count);
typedef void(^ShopCarCountViewDecreaseBlock)(NSInteger count);
typedef void(^changeName)(NSString *str);
typedef void(^AddShopCar)(NSString *productId , NSString *skuId, NSString *amount);
@interface MHShopCarSizeAlert : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, strong)UIView *showView;
@property(nonatomic, strong)UIImageView *productImg;
@property(nonatomic, strong)UIImageView *closeImg;
@property(nonatomic, assign)NSInteger Height;
@property(nonatomic, strong)NSMutableArray *sectionArr;
@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *decreaseButton;
@property (nonatomic, strong) UILabel *editTextField;
@property (nonatomic, strong) NSMutableArray *skulistArr;
@property (nonatomic, strong)UILabel *skulaber;
@property (nonatomic, strong) NSString *skuStr;
@property (nonatomic, strong) UILabel *pricelabel;
@property (nonatomic, strong) UILabel *stocknumlabel;
@property (nonatomic, strong) UILabel *showNoticelabel;
@property (nonatomic, strong)ShopCarCountViewAddBlock CountViewAddBlock;
@property (nonatomic, strong)ShopCarCountViewDecreaseBlock CountViewDecreaseBlock;
@property (nonatomic, strong)AddShopCar makesureAct;
@property (nonatomic, strong)changeName changeName;
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)NSMutableDictionary *dict;
@property (nonatomic, strong)NSString *DesStr;
@property (nonatomic, strong)UILabel *DesStrlabel;
@property (nonatomic, strong)NSString *skuId;
@property (nonatomic, assign)NSInteger fromtype;
@property (nonatomic, strong)UIButton *Buybtn;
/*
 *隐藏弹窗
 */
-(void)hideAlert;
/*
 *展示弹窗
 */
-(void)showAlert;
-(void)showAlertwithShopCar:(NSInteger )type;
-(void)showAlertwithbyNow:(NSInteger )type;
/*
 *初始化方法,height是白色区域的高度
 */
-(instancetype)initWithFrame:(CGRect)frame height:(NSInteger)height data:(NSMutableDictionary *)dic;
@end
