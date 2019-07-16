//
//  MHMineItemCell.m
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHMineItemCell.h"
#import "CTUUID.h"
#import "MHMineitemView.h"
@implementation MHMineItemCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createview];
    }
    return self;
}
-(void)createview
{
    self.bgview = [[UIView alloc] init];
    self.bgview.frame = CGRectMake(kRealValue(16),kRealValue(0),kRealValue(343),kRealValue(360));
    self.bgview.backgroundColor= [UIColor whiteColor];
   
    [self addSubview:self.bgview];
    NSArray *imageArr = [NSArray arrayWithObjects:@"icon_my_function_news",@"icon_my_function_order",@"icon_my_function_map",@"icon_my_function_team",@"icon_my_function_capital",@"icon_my_function_edition",nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"消息中心",@"我的订单",@"收货地址",@"我的团队",@"资金流水",@"版本信息",nil];
    NSArray *subtitleArr = [NSArray arrayWithObjects:@"我的粉丝/资金变化消息",@"查看我的购物订单",@"管理我的收货地址",@"查看我的团队信息",@"查看我的账户资金流水信息",@"当前app的版本信息",nil];
    for (int i = 0; i < 6; i ++) {
        if (i == 0) {
            self.itemview  = [[MHMineitemView alloc]initWithFrame:CGRectMake(0, kRealValue(60) *i, kScreenWidth-kRealValue(16), kRealValue(60)) title:titleArr[i] subtitle:subtitleArr[i] imageStr:imageArr[i] righttitle:@"" isline:YES isRighttitle:NO];
            self.itemview.tag = 15000+i;
            [self.bgview addSubview:self.itemview];
        }else{
            if (i == 5) {
                self.itemview= [[MHMineitemView alloc]initWithFrame:CGRectMake(0, kRealValue(60) *i, kScreenWidth-kRealValue(16), kRealValue(60)) title:titleArr[i] subtitle:subtitleArr[i] imageStr:imageArr[i] righttitle:[NSString stringWithFormat:@"V %@",[CTUUID getAppVersion]] isline:NO isRighttitle:YES];
                self.itemview.tag = 15000+i;
                [self.bgview addSubview:self.itemview];
            }
            else{
                self.itemview = [[MHMineitemView alloc]initWithFrame:CGRectMake(0, kRealValue(60) *i, kScreenWidth-kRealValue(16), kRealValue(60)) title:titleArr[i] subtitle:subtitleArr[i] imageStr:imageArr[i] righttitle:@"" isline:YES isRighttitle:NO];
                self.itemview.tag = 15000+i;
                [self.bgview addSubview:self.itemview];
                
            }
        }
        UITapGestureRecognizer *tapact = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtapAct:)];
        [ self.itemview addGestureRecognizer:tapact];
        
        
    }
    
    
    
    
}
-(void)viewtapAct:(UITapGestureRecognizer *)sender
{
    if (self.tapAct) {
        self.tapAct(sender.view.tag);
    }
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
