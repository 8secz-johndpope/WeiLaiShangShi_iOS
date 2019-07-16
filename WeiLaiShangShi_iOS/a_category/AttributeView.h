//
//  AttributeCollectionView.h
//
//
//  Created by yuhao on 15/12/15.
//  Copyright © 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AttributeView;

@protocol AttributeViewDelegate<NSObject>
@optional
-(void)Attribute_View:(AttributeView *)view didClickBtn:(UIButton *)btn;
@end

@interface AttributeView : UIView
@property(nonatomic,assign)id <AttributeViewDelegate>Attribute_delegate;
/**
 *  返回一个创建好的属性视图,并且带有标题.创建好之后必须设置视图的Y值.
 *
 *  @param texts 属性数组
 *
 *  @return attributeView
 */
+ (AttributeView *)attributeViewWithTitle:(NSString *)title titleFont:(UIFont *)font attributeTexts:(NSArray *)texts viewWidth:(CGFloat)viewWidth IsSort:(BOOL)isSort;
+(AttributeView *)attributeViewWithTitle:(NSString *)title titleFont:(UIFont *)font attributeTexts:(NSArray *)texts viewWidth:(CGFloat)viewWidth IsSort:(BOOL)isSort IsSelectDefault:(NSString *)IsSelectDefault tag:(NSInteger) tag;
@end
