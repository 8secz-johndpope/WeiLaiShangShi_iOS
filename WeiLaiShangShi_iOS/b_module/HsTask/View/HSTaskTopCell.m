//
//  HSTaskTopCell.m
//  HSKD
//
//  Created by yuhao on 2019/3/7.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSTaskTopCell.h"

@implementation HSTaskTopCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColorFromRGB(0xF1F2F1);
        [self createview];
    }
    return self;
}
-(void)createview
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(12), 0,kScreenWidth- kRealValue(24), kRealValue(71))];
    view.backgroundColor = KColorFromRGB(0xffffff);
    [self addSubview:view];
    
    self.bgview = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(10), 0,view.frame.size.width - kRealValue(20), kRealValue(71))];
//    self.bgview.backgroundColor = kRandomColor;
    self.bgview.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.bgview];
   
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
