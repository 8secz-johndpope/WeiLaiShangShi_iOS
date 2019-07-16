//
//  HSScrollView.m
//  HSKD
//
//  Created by AllenQin on 2019/3/13.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSScrollView.h"

@implementation HSScrollView

-(BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    [super touchesShouldCancelInContentView:view];
    return YES;
}

@end
