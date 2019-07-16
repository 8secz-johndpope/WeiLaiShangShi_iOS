//
//  HSShopChildVC.h
//  HSKD
//
//  Created by AllenQin on 2019/2/26.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSShopChildVC : UIViewController

- (instancetype)initWithCategoryId:(NSString *)typeId;

@property (strong, nonatomic)  UICollectionView *collectionView;

@property (nonatomic, assign) BOOL vcCanScroll;

@end

NS_ASSUME_NONNULL_END
