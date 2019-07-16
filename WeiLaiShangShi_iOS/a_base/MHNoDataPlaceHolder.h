//
//  WeChatStylePlaceHolder.h
//  CYLTableViewPlaceHolder
//
//  Created by 陈宜龙 on 15/12/23.
//  Copyright © 2015年 http://weibo.com/luohanchenyilong/ ÂæÆÂçö@iOSÁ®ãÂ∫èÁä≠Ë¢Å. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MHNoDataPlaceHolderDelegate <NSObject>

@required
- (void)NodataemptyOverlayClicked:(id)sender;

@end
@interface MHNoDataPlaceHolder : UIView

@property(strong,nonatomic) UILabel *textLabel;

@property (nonatomic, weak) id<MHNoDataPlaceHolderDelegate> delegate;
@end
