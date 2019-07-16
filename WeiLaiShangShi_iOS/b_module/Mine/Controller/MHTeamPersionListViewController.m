//
//  MHTeamPersionListViewController.m
//  wgts
//
//  Created by yuhao on 2018/11/12.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTeamPersionListViewController.h"
#import "MHMineitemViewSecond.h"

#import "MHTeamPersionListDetailViewController.h"
@interface MHTeamPersionListViewController ()
@property(nonatomic, strong)MHMineitemViewSecond * itemview;
@property(nonatomic, strong)NSMutableArray * righttitleArr;
@end

@implementation MHTeamPersionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.pagetitle;
    self.righttitleArr = [NSMutableArray array];
    [[MHUserService sharedInstance]initWithFansSummaryRelationLevel:self.relation CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSArray *rightArr = response[@"data"];
            [rightArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.righttitleArr addObject:[NSString stringWithFormat:@"%@人",obj[@"count"]]];
            }];
            [self createview];
        }
    }];
    // Do any additional setup after loading the view.
}
-(void)createview
{
    self.bgview = [[UIView alloc] init];
    self.bgview.frame = CGRectMake(kRealValue(16),kRealValue(8),kRealValue(343),kRealValue(306));
    self.bgview.backgroundColor= [UIColor whiteColor];
    self.bgview.layer.cornerRadius = kRealValue(10);
    [self.view addSubview:self.bgview];
    NSArray *imageArr = [NSArray arrayWithObjects:@"fans_gold_icon",@"fans_monr_icon",@"fans_silver_icon",nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"金勺会员",@"银勺会员",@"普通用户",nil];
    NSArray *subtitleArr = [NSArray arrayWithObjects:@"",@"",@"",nil];
    for (int i = 0; i < 3; i ++) {
        self.itemview  = [[MHMineitemViewSecond alloc]initWithFrame:CGRectMake(0, kRealValue(60) *i, kScreenWidth-kRealValue(16), kRealValue(60)) title:titleArr[i] subtitle:subtitleArr[i] imageStr:imageArr[i] righttitle:self.righttitleArr[i] isline:YES isRighttitle:YES];
        self.itemview.tag = 19000+i;
        [self.bgview addSubview:self.itemview];
        UITapGestureRecognizer *tapact = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtapAct:)];
        [ self.itemview addGestureRecognizer:tapact];
        
        
    }
}
-(void)viewtapAct:(UITapGestureRecognizer *)sender
{
    if (sender.view.tag == 19000) {
        MHTeamPersionListDetailViewController *vc = [[MHTeamPersionListDetailViewController alloc]init];
        vc.pagetitle = @"金勺会员";
        vc.level = @"SVIP";
        vc.relation  = self.relation;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.view.tag == 19001) {
        MHTeamPersionListDetailViewController *vc = [[MHTeamPersionListDetailViewController alloc]init];
        vc.pagetitle = @"银勺会员";
        vc.level = @"VIP";
        vc.relation  = self.relation;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.view.tag == 19002) {
        MHTeamPersionListDetailViewController *vc = [[MHTeamPersionListDetailViewController alloc]init];
        vc.pagetitle = @"普通用户";
        vc.level = @"ORD";
        vc.relation  = self.relation;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
