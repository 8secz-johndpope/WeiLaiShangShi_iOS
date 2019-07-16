//
//  MHSrollView.m
//  mohu
//
//  Created by AllenQin on 2018/10/23.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHSrollView.h"

@implementation MHSrollView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer * tap =   (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint velocity = [tap velocityInView:gestureRecognizer.view];
        
        if(velocity.x>0){
            
            if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
                return YES;
            }
            
            return NO;
            
        }else{
            if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentSize.width == (self.contentOffset.x + kScreenWidth)) {
                return YES;
            }
            
            return NO;
        }

    }
    return NO;
}



@end
