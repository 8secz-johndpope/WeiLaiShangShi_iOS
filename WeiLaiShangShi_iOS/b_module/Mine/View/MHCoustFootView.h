//
//  MHCoustFootView.h
//  mohu
//
//  Created by AllenQin on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHCoustFootView : UIView <UIActionSheetDelegate>

@property(strong,nonatomic) UIButton    *isDeployBtn;

@property(strong,nonatomic) UILabel    *titlesLabel;

@property(strong,nonatomic) UIButton    *selectBtn;

@property(strong,nonatomic) YYTextView *textView;

@property(strong,nonatomic) YYLabel    *dianpuLabel;
@property(strong,nonatomic) NSArray    *desc;


@property(strong,nonatomic) UIImageView    *select1;

@property(strong,nonatomic) UIImageView    *select2;

@property (nonatomic,assign) NSInteger    isSelect;

- (instancetype)initWithFrame:(CGRect)frame withArr:(NSArray *)desc;


@end

NS_ASSUME_NONNULL_END
