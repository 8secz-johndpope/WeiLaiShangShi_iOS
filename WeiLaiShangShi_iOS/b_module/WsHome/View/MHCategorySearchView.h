//
//  MHCategorySearchView.h
//  mohu
//
//  Created by AllenQin on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHCategorySearchView : UIView

@property(strong,nonatomic)YYLabel  *titlesLabel;

//跳转
@property (nonatomic,copy) void(^searchBarBlock)(void);

-(void)createSeachContent:(NSString *)desc;




@end
