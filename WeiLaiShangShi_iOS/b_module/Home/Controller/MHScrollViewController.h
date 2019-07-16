//
//  ASScrollViewController.h
//  haochedai
//
//  Created by AllenQin on 16/5/9.
//  Copyright © 2016年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHScrollViewController : UIViewController

@property(strong,nonatomic)UIButton *startBtn;
@property (nonatomic, strong)void (^goHomeBlock)(void);

@end
