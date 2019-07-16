//
//  HSTaskChirdTwoViewController.m
//  HSKD
//
//  Created by yuhao on 2019/3/7.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSTaskChirdTwoViewController.h"
#import "HSTaskNormalCell.h"
#import "MHBaseTableView.h"
#import "MHTaskDetailModel.h"
#import "HSTaskLastCell.h"
#import "HSTaskTopCell.h"
#import "HSTaskDetailViewViewController.h"
@interface HSTaskChirdTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray *listArr;

@end

@implementation HSTaskChirdTwoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getvipInfo];
    
}
-(void)getvipInfo
{
    self.listArr = [NSMutableArray array];
    
    [[MHUserService sharedInstance]initwithHSVIPTaskListWithType:@"SVIP"
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
    
    self.vcCanScroll = YES;
    // Do any additional setup after loading the view.
}
-(void)createview
{
    [self.view addSubview:self.tableView];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth , kScreenHeight-kBottomHeight-kTabBarHeight-kRealValue(64)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = KColorFromRGB(0xF1F2F1);
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    if (!self.vcCanScroll) {
    //        scrollView.contentOffset = CGPointZero;
    //    }
    CGFloat offsetY = scrollView.contentOffset.y;
    MHLog(@"%f",offsetY);
    if (offsetY >=0) {
        //        self.vcCanScroll = NO;
        //        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationFatherNOSrcoll object:nil userInfo:nil];
    }
    
    if (offsetY <=0) {
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationFatherSrcoll object:nil userInfo:nil];
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        if (self.listArr.count>0) {
            MHTaskDetailModel *model = [self.listArr objectAtIndex:indexPath.row];
            if ([model.property isEqualToString:@"REVIEW"]) {
                //审核任务
                HSTaskDetailViewViewController *vc = [[HSTaskDetailViewViewController alloc]init];
                vc.taskId = [NSString stringWithFormat:@"%@",model.id];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([model.property isEqualToString:@"READ"]) {
                //阅读任务
            }
            if ([model.property isEqualToString:@"APPOINT"]) {
                //阅读指定任务
                
            }
        }
    
    
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
