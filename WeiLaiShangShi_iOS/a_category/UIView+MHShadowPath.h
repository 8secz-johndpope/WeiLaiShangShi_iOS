//
//  UIView+MHShadowPath.h
//  mohu
//
//  Created by AllenQin on 2018/9/12.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum :NSInteger{
    
    MHShadowPathLeft,
    
    MHShadowPathRight,
    
    MHShadowPathTop,
    
    MHShadowPathBottom,
    
    MHShadowPathNoTop,
    
    MHShadowPathMohu,
    
    MHShadowPathAllSide
    
} MHShadowPathSide;

@interface UIView (MHShadowPath)

/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，
 
 */

-(void)shadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(MHShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;

@end
