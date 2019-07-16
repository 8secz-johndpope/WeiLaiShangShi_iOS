//
//  MHNewerActCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHNewerActCell.h"
#import "MHPageItemModel.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView+WebCache.h"


@interface MHNewerActCell()
@property (nonatomic, strong) FLAnimatedImageView *activityImg;
@end
@implementation MHNewerActCell


-(void)setNewActArr:(NSMutableArray *)NewActArr
{
    _NewActArr = NewActArr;
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
            MHPageItemModel *model = [_NewActArr objectAtIndex:0];
            [self.activityImg   sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl]];
            
        }else{
            MHPageItemModel *model = [_NewActArr objectAtIndex:1];
            [self.activityImg   sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl]];
        }
    }else{
        MHPageItemModel *model = [_NewActArr objectAtIndex:0];
        [self.activityImg   sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl]];
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)createview{
    if (!self.activityImg) {
        self.activityImg = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(80))];
        self.activityImg.userInteractionEnabled = YES;
        [self addSubview:self.activityImg];
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAct)];
        [self.activityImg addGestureRecognizer:tap];
    }

}
-(void)tapAct
{
    self.changepage(@"",@"");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
