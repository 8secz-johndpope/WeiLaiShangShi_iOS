//
//  MHAlertViewController.h
//  mohu
//
//  Created by AllenQin on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKAlertAction : NSObject

@property (nonatomic, readonly) NSString *title;

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(CKAlertAction *action))handler;

@end


@interface MHAlertViewController : UIViewController

@property (nonatomic, readonly) NSArray<CKAlertAction *> *actions;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSTextAlignment messageAlignment;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message;
+ (instancetype)alertControllerWithMessage:(NSString *)message;
- (void)addAction:(CKAlertAction *)action;
- (void)showDisappearAnimation;

@end
