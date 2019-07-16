//
//  HSWalletXJView.h
//  HSKD
//
//  Created by AllenQin on 2019/5/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLTableViewPlaceHolder.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HSWalletXJViewDelegate <NSObject>

- (void)reloadHome;

@end


@interface HSWalletXJView : UIView

-(void)reloadViewData;

@property (nonatomic, weak) id<HSWalletXJViewDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
