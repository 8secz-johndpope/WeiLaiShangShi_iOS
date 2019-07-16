//
//  HSWebviewCell.h
//  HSKD
//
//  Created by yuhao on 2019/4/11.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN


@protocol scrollviewdelege <NSObject>

-(void)webviewscroller;

@end
@interface HSWebviewCell : UITableViewCell
-(void)createwebviewheight;
-(void)createwebviewheight2;
@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, weak) id<scrollviewdelege>delegate;
@end

NS_ASSUME_NONNULL_END
