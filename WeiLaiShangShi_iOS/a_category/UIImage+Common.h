//
//  UIImage+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-4.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface UIImage (Common)

+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
-(UIImage*)scaledToSize:(CGSize)targetSize;
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
-(UIImage*)scaledToMaxSize:(CGSize )size;
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
+ (UIImage *)fullScreenImageALAsset:(ALAsset *)asset;
+ (UIImage *)imageWithFileType:(NSString *)fileType;
+ (UIImage *)big_imageWithFileType:(NSString *)fileType;
- (NSData *)dataSmallerThan:(CGFloat)maxLength;
- (NSData *)dataForCodingUpload;
+ (UIImage *)imageWithImageSimple:( UIImage *)image scaledToSize:( CGSize )size;
// image 存成照片
+(UIImage*)imageFromView:(UIView*)view;



@end