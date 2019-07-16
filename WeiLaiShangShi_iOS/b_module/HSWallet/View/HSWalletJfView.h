//
//  HSWalletJfView.h
//  HSKD
//
//  Created by AllenQin on 2019/5/8.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLTableViewPlaceHolder.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HSWalletJfDelegate <NSObject>

- (void)xjreloadHome;

@end


@interface HSWalletJfView : UIView

@property (nonatomic, weak) id<HSWalletJfDelegate> delegate;


-(void)reloadViewData;



@end

NS_ASSUME_NONNULL_END
