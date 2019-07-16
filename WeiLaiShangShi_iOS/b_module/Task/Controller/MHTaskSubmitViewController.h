//
//  MHTaskSubmitViewController.h
//  wgts
//
//  Created by yuhao on 2018/11/9.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHBaseViewController.h"

@interface MHTaskSubmitViewController : MHBaseViewController
@property(nonatomic, strong) UIImageView *wxShareImage;
@property(nonatomic, assign) BOOL haveUpload;
@property(nonatomic, assign) BOOL haveChoosePic;;
@property(nonatomic, strong)NSMutableDictionary *dic;
@property(nonatomic, assign) BOOL iscompelete;
@property(nonatomic, strong) NSString *pagetitle;
@property(nonatomic, strong) UIImageView *plachImage;
@property(nonatomic, strong) UILabel *plachlabel;
@end
