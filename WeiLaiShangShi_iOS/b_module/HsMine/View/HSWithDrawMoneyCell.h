//
//  HSWithDrawMoneyCell.h
//  HSKD
//
//  Created by AllenQin on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HSWithDrawCellDelegate <NSObject>

- (void)clickBtnValues:(NSInteger )value;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HSWithDrawMoneyCell : UITableViewCell

@property(strong,nonatomic) NSMutableArray *btnArr;

@property (nonatomic, weak) id<HSWithDrawCellDelegate> delegate;


-(void)creatBtn:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
