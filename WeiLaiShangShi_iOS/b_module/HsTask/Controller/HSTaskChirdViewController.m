//
//  HSTaskChirdViewController.m
//  HSKD
//
//  Created by yuhao on 2019/2/28.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSTaskChirdViewController.h"
#import "HSTaskNormalCell.h"
#import "MHBaseTableView.h"
#import "MHTaskDetailModel.h"
#import "HSTaskLastCell.h"
#import "HSTaskTopCell.h"
#import "HSTaskDetailViewViewController.h"
#import "HSNewsDetailViewController.h"
@interface HSTaskChirdViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray *listArr;
@end

@implementation HSTaskChirdViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getvipInfo];
    
}
-(void)getvipInfo
{
    self.listArr = [NSMutableArray array];
    
    [[MHUserService sharedInstance]initwithHSVIPTaskListWithType:self.type
    CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.listArr = [MHTaskDetailModel baseModelWithArr:[response valueForKey:@"data"]];
            //置顶任务
            for (int i = 0; i < self.listArr.count; i++) {
                MHTaskDetailModel *model = [self.listArr objectAtIndex:i];
                if (model.top == 1) {
                    [self.listArr removeObject:model];
                    [self.listArr insertObject:model atIndex:0];
                }
            }
            
            [self.tableView reloadData];
        }
     }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorFromRGB(0xF1F2F1);
     [self createview];
    
   
    // Do any additional setup after loading the view.
}
-(void)createview
{
    [self.view addSubview:self.tableView];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth , kScreenHeight-kBottomHeight-kTabBarHeight-kRealValue(94)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = KColorFromRGB(0xF1F2F1);
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[HSTaskTopCell class] forCellReuseIdentifier:NSStringFromClass([HSTaskTopCell class])];
        [_tableView registerClass:[HSTaskLastCell class] forCellReuseIdentifier:NSStringFromClass([HSTaskLastCell class])];
        [_tableView registerClass:[HSTaskNormalCell class] forCellReuseIdentifier:NSStringFromClass([HSTaskNormalCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return kRealValue(67);
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.listArr.count>0) {
        return self.listArr.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArr.count > 0) {
        
        if (indexPath.row == self.listArr.count-1) {
            
            HSTaskLastCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskLastCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            [cell createWithModel:[self.listArr objectAtIndex:indexPath.row]];
            return cell;
        }
        MHTaskDetailModel *model = [self.listArr objectAtIndex:indexPath.row];
        if (model.top == 1) {
            HSTaskTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskTopCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            [cell.bgview sd_setImageWithURL:[NSURL URLWithString:model.title]];
            return cell;
        }
        HSTaskNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskNormalCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        [cell createWithModel:[self.listArr objectAtIndex:indexPath.row]];
        return cell;
    }
    HSTaskNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSTaskNormalCell class])];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    cell.dotask = ^{
        HSTaskDetailViewViewController *vc =[[HSTaskDetailViewViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}


//手势

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        if (self.listArr.count>0) {
            MHTaskDetailModel *model = [self.listArr objectAtIndex:indexPath.row];
            //1 先判断用户角色
            if ([model.taskType isEqualToString:@"SVIP"]) {
                if (![[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"SVIP"]) {
                    NSString *str = @"";
                    if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"] ) {
                        str =@"你还不是金勺会员,请前往升级";
                    }
                    if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                        str =@"你还不是银勺会员,请前往升级";
                    }
                    
                    MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:str ];
                    alertVC.messageAlignment = NSTextAlignmentCenter;
                    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"确认取消" handler:^(CKAlertAction *action) {
                        [alertVC showDisappearAnimation];
                    }];
                    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"去升级" handler:^(CKAlertAction *action) {
                        [alertVC showDisappearAnimation];
                        [self.tabBarController setSelectedIndex:3];
                    }];
                    [alertVC addAction:cancel];
                    [alertVC addAction:sure];
                    [self presentViewController:alertVC animated:NO completion:nil];
                }
            }
            if ([model.taskType isEqualToString:@"VIP"]) {
                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"VIP"]) {
                    NSString *str = @"";
                    if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"ORD"] ) {
                        str =@"你还不是银勺会员,请前往升级";
                    }
                    
                    MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:str ];
                    alertVC.messageAlignment = NSTextAlignmentCenter;
                    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"确认取消" handler:^(CKAlertAction *action) {
                        [alertVC showDisappearAnimation];
                    }];
                    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"去升级" handler:^(CKAlertAction *action) {
                        [alertVC showDisappearAnimation];
                        [self.tabBarController setSelectedIndex:3];
                    }];
                    [alertVC addAction:cancel];
                    [alertVC addAction:sure];
                    [self presentViewController:alertVC animated:NO completion:nil];
                }
            }
           // 任务类型
            
            
            
            if ([model.property isEqualToString:@"REVIEW"]) {
                //审核任务
                HSTaskDetailViewViewController *vc = [[HSTaskDetailViewViewController alloc]init];
                vc.taskId = [NSString stringWithFormat:@"%@",model.id];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([model.property isEqualToString:@"READ"]) {
                //阅读任务
               // 领取任务
                [self getMHTaskDetailModel:model];
                
            }
            if ([model.property isEqualToString:@"APPOINT"]) {
                //阅读指定任务
                 [self getMHTaskDetailModel2:model];
               
            }
       
    
    
}
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    MHLog(@"%d",offsetY);
    if (offsetY <=0) {
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationFatherSrcoll object:nil userInfo:nil];
    }
    
    
}
-(void)getMHTaskDetailModel:(MHTaskDetailModel *)model
{
    [MBProgressHUD showActivityMessageInWindow:@""];
    [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:model.id taskCode:model.taskType taskUrl:@"" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [MBProgressHUD hideHUD];
           
            HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
            vc.ariticeID = model.remark;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else{
            if ([[response valueForKey:@"code"] isEqualToString:@"20707"]) {
                HSNewsDetailViewController *vc = [[HSNewsDetailViewController alloc]init];
                vc.ariticeID = model.remark;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [MBProgressHUD hideHUD];
                KLToast([response valueForKey:@"message"]);
            }
           
            
        }
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                [MBProgressHUD showActivityMessageInWindow:@"领取失败,请刷新后重试"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUD];
                });
                
            });
        }
        
    }];
    
}
-(void)getMHTaskDetailModel2:(MHTaskDetailModel *)model
{
    [MBProgressHUD showActivityMessageInWindow:@""];
    [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:model.id taskCode:model.taskType taskUrl:@"" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [MBProgressHUD hideHUD];
            KLToast(@"任务领取成功");
            
            
        }else{
            [MBProgressHUD hideHUD];
            KLToast([response valueForKey:@"message"]);
            
        }
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                [MBProgressHUD showActivityMessageInWindow:@"领取失败,请刷新后重试"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUD];
                });
                
            });
        }
        
    }];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
