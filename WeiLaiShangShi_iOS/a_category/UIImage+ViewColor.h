//
//  UIImage+ViewColor.h
//  mohu
//
//  Created by AllenQin on 2018/9/12.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    topToBottom = 0,//从上到小
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;


@interface UIImage (ViewColor)

//渐变色
+ (UIImage *) buttonImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType withViewSize:(CGSize )size;

@end
