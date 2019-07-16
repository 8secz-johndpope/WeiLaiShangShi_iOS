


//
//  MHtitleCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHtitleCell.h"
@interface MHtitleCell()

@end
@implementation MHtitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createview];
    }
    return self;
}

-(void)createview{
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, 40)];
    self.title.text = @"未来商市福利";
    self.title.font = [UIFont fontWithName:kPingFangMedium size:16];
    self.title.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.alpha = 1;
    self.title.numberOfLines = 0;
    [self addSubview:self.title];
}

@end
