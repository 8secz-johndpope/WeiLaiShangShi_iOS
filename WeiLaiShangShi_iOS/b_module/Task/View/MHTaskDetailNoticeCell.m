//
//  MHTaskDetailNoticeCell.m
//  wgts
//
//  Created by yuhao on 2018/12/5.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskDetailNoticeCell.h"

@implementation MHTaskDetailNoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)createview
{
    
    UILabel *headtitle = [[UILabel alloc]init];
    headtitle.text =@"提醒:任务当天有效,每日24点清零重置,届时,未完成任务默认过期。";
    headtitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    headtitle.textColor = KColorFromRGB(0xFE3344);
    headtitle.numberOfLines=2;
    headtitle.textAlignment=NSTextAlignmentLeft;
    [self addSubview:headtitle];
    [headtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.width.mas_equalTo(kRealValue(343));
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(0));
        
    }];
}



@end
