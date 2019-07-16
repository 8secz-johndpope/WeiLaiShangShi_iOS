
//
//  MHTaskDetailHeadTitleCell.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskDetailHeadTitleCell.h"

@implementation MHTaskDetailHeadTitleCell
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
    UILabel *tasknamelabel = [[UILabel alloc]init];
    tasknamelabel.text =@"任务名称：";
    tasknamelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
    tasknamelabel.textColor = KColorFromRGB(0x666666);
    tasknamelabel.textAlignment=NSTextAlignmentLeft;
    tasknamelabel.frame = CGRectMake(kRealValue(12), kRealValue(17), kRealValue(70), kRealValue(17));
    [self addSubview:tasknamelabel];
    
    self.taskname = [[UILabel alloc]init];
    self.taskname.text =@"【皇爵霸业】APP下载任务";
    self.taskname.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.taskname.textColor = KColorFromRGB(0x222222);
    self.taskname.textAlignment=NSTextAlignmentLeft;
    self.taskname.frame = CGRectMake(kRealValue(82), kRealValue(17), kRealValue(277), kRealValue(17));
     [self addSubview:self.taskname];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(12), kRealValue(45), kScreenWidth - kRealValue(24), 1/kScreenScale)];
    line1.backgroundColor= KColorFromRGB(0xE2E2E2);
    [self addSubview:line1];
    
    
    
    UILabel *tasknumlabel = [[UILabel alloc]init];
    tasknumlabel.text =@"任务奖励:";
    tasknumlabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
    tasknumlabel.textColor = KColorFromRGB(0x666666);
    tasknumlabel.textAlignment=NSTextAlignmentLeft;
    tasknumlabel.frame = CGRectMake(kRealValue(12), kRealValue(60), kRealValue(70), kRealValue(17));
    [self addSubview:tasknumlabel];
    
    self.tasknum = [[UILabel alloc]init];
    self.tasknum.text =@"1000积分";
    self.tasknum.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.tasknum.textColor = KColorFromRGB(0x222222);
    self.tasknum.textAlignment=NSTextAlignmentLeft;
    self.tasknum.frame = CGRectMake(kRealValue(82), kRealValue(60), kRealValue(277), kRealValue(17));
    [self addSubview:self.tasknum];
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(12), kRealValue(90), kScreenWidth - kRealValue(24), 1/kScreenScale)];
    line2.backgroundColor= KColorFromRGB(0xE2E2E2);
    [self addSubview:line2];
    
    
    UILabel *tasktimelabel = [[UILabel alloc]init];
    tasktimelabel.text =@"任务数量：";
    tasktimelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
    tasktimelabel.textColor = KColorFromRGB(0x666666);
    tasktimelabel.textAlignment=NSTextAlignmentLeft;
    tasktimelabel.frame = CGRectMake(kRealValue(12), kRealValue(103), kRealValue(70), kRealValue(17));
    [self addSubview:tasktimelabel];

    self.tasktime = [[UILabel alloc]init];
    self.tasktime.text =@"150/300";
    self.tasktime.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.tasktime.textColor = KColorFromRGB(0x222222);
    self.tasktime.textAlignment=NSTextAlignmentLeft;
    self.tasktime.frame = CGRectMake(kRealValue(82), kRealValue(103), kRealValue(277), kRealValue(17));
    [self addSubview:self.tasktime];
    
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(12), kRealValue(135), kScreenWidth - kRealValue(24), 1/kScreenScale)];
    line3.backgroundColor= KColorFromRGB(0xE2E2E2);
    [self addSubview:line3];
    
    
    


    UILabel *tasklimitlabel = [[UILabel alloc]init];
    tasklimitlabel.text =@"任务限制：";
    tasklimitlabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
    tasklimitlabel.textColor = KColorFromRGB(0x666666);
    tasklimitlabel.textAlignment=NSTextAlignmentLeft;
    tasklimitlabel.frame = CGRectMake(kRealValue(12), kRealValue(146), kRealValue(70), kRealValue(17));
    [self addSubview:tasklimitlabel];

    self.tasklimit= [[UILabel alloc]init];
    self.tasklimit.text =@"仅会员以上用户可参与";
    self.tasklimit.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.tasklimit.textColor = KColorFromRGB(0x000000);
    self.tasklimit.textAlignment=NSTextAlignmentLeft;
    self.tasklimit.frame = CGRectMake(kRealValue(82), kRealValue(146), kRealValue(277), kRealValue(17));
    [self addSubview:self.tasklimit];
//
//
//
    
    
    
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
