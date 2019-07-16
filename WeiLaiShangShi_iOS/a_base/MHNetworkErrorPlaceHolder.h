//
//  WeChatStylePlaceHolder.h
//  CYLTableViewPlaceHolder
//
//  Created by 陈宜龙 on 15/12/23.
//  Copyright © 2015年 http://weibo.com/luohanchenyilong/ ÂæÆÂçö@iOSÁ®ãÂ∫èÁä≠Ë¢Å. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MHNetworkErrorPlaceHolderDelegate <NSObject>

@required
- (void)emptyOverlayClicked:(id)sender;

@end

@interface MHNetworkErrorPlaceHolder : UIView

@property (nonatomic, weak) id<MHNetworkErrorPlaceHolderDelegate> delegate;

@end
