//
//  MHBaseTableView.m
//  mohu
//
//  Created by AllenQin on 2018/9/12.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseTableView.h"

@implementation MHBaseTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UICollectionView")]) {
//        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
//            return NO;
//        }
//        return YES;
//    }
  return YES;

}
@end
