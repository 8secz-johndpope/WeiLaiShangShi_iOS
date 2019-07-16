//
//  HSUpPopView.h
//  HSKD
//
//  Created by AllenQin on 2019/3/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSUpPopView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                     shopList:(NSArray *)shopListArr
                      payList:(NSArray *)payList;



@property(strong,nonatomic)NSArray *shopListArr;
@property(strong,nonatomic)NSArray *payList;
@property(assign,nonatomic)NSInteger selectIndex;


-(void)pop;
-(void)dismiss;

@property (nonatomic,copy) void(^payClick)(NSString * payType,NSDictionary *shopDict);

@end

NS_ASSUME_NONNULL_END
