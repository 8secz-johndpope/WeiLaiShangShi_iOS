
//
//  MHTeamPersionViewController.m
//  wgts
//
//  Created by yuhao on 2018/11/12.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTeamPersionViewController.h"
#import "MHMineitemViewThird.h"
#import "MHTeamPersionListViewController.h"
@interface MHTeamPersionViewController ()
@property(nonatomic, strong)MHMineitemViewThird * itemview;
@property(nonatomic, strong)NSMutableArray * righttitleArr;
@end

@implementation MHTeamPersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的团队";
    self.righttitleArr = [NSMutableArray array];
    [[MHUserService sharedInstance]initWithFansSummaryCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSArray *rightArr = response[@"data"];
            [rightArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.righttitleArr addObject:[NSString stringWithFormat:@"%@人",obj[@"count"]]];
            }];
           [self createview];
        }
    }];


}
-(void)createview
{
    self.bgview = [[UIView alloc] init];
    self.bgview.frame = CGRectMake(kRealValue(16),kRealValue(8),kRealValue(343),kRealValue(306));
    self.bgview.backgroundColor= [UIColor whiteColor];
    self.bgview.layer.cornerRadius = kRealValue(10);
    [self.view addSubview:self.bgview];
    NSArray *imageArr = [NSArray arrayWithObjects:@"icon_team_class",@"icon_team_second",nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"一级粉丝",@"二级粉丝",nil];
    NSArray *subtitleArr = [NSArray arrayWithObjects:@"您邀请的直属粉丝",@"您的直属粉丝邀请的其他粉丝",nil];
    for (int i = 0; i < 2; i ++) {
    
            self.itemview  = [[MHMineitemViewThird alloc]initWithFrame:CGRectMake(0, kRealValue(60) *i, kScreenWidth-kRealValue(16), kRealValue(60)) title:titleArr[i] subtitle:subtitleArr[i] imageStr:imageArr[i] righttitle:self.righttitleArr[i] isline:YES isRighttitle:YES];
            self.itemview.tag = 18000+i;
            [self.bgview addSubview:self.itemview];
        UITapGestureRecognizer *tapact = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtapAct:)];
        [ self.itemview addGestureRecognizer:tapact];
        
        
    }
    
    
    
}
-(void)viewtapAct:(UITapGestureRecognizer *)sender
{
    if (sender.view.tag == 18000) {
        MHTeamPersionListViewController *vc = [[MHTeamPersionListViewController alloc]init];
        vc.pagetitle = @"一级粉丝";
        vc.relation = 0;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (sender.view.tag == 18001) {
        MHTeamPersionListViewController *vc = [[MHTeamPersionListViewController alloc]init];
        vc.pagetitle = @"二级粉丝";
        vc.relation = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
