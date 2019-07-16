//
//  HSNewsFilmViewController.m
//  HSKD
//
//  Created by yuhao on 2019/2/26.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSNewsFilmViewController.h"
#import "SJTableViewCell.h"
#import "SJVideoPlayer.h"
#import "AliyunOSSDemo.h"
#import "HSRewardViewClass.h"
#import <SJBaseVideoPlayer/UIScrollView+ListViewAutoplaySJAdd.h>
@interface HSNewsFilmViewController ()<UITableViewDelegate,UITableViewDataSource,SJPlayerAutoplayDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) SJVideoPlayer *player;
@property (nonatomic, strong) NSMutableArray *filmArr;
@end

@implementation HSNewsFilmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    [self createview];
    [self _configAutoplayForTableView];
    [[HSRewardViewClass sharedApi] creteAnmiatedView];
    [[HSRewardViewClass sharedApi] creteTimeClockWithTimeT:5];
    // Do any additional setup after loading the view.
}
-(void)createview
{
    //    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    //    bgview.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:bgview];
    [self.view addSubview:self.tableView];
    
}

- (void)_configAutoplayForTableView {
    // 配置列表自动播放
    [_tableView sj_enableAutoplayWithConfig:[SJPlayerAutoplayConfig configWithPlayerSuperviewTag:101 autoplayDelegate:self]];
    
    [_tableView sj_needPlayNextAsset];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self.tableView sj_needPlayNextAsset];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.1,kScreenWidth, kScreenHeight-kTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
       
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}
- (void)sj_playerNeedPlayNewAssetAtIndexPath:(NSIndexPath *)indexPath {
    SJTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ( !_player || !_player.isFullScreen ) {
        [_player stopAndFadeOut]; // 让旧的播放器淡出
        _player = [SJVideoPlayer lightweightPlayer]; // 创建一个新的播放器
        _player.generatePreviewImages = YES; // 生成预览缩略图, 大概20张
        // fade in(淡入)
        _player.view.alpha = 0.001;
        [UIView animateWithDuration:0.6 animations:^{
            self.player.view.alpha = 1;
        }];
    }
#ifdef SJMAC
    _player.disablePromptWhenNetworkStatusChanges = YES;
#endif
    [cell.view.coverImageView addSubview:self.player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    NSString *str =[self.filmArr objectAtIndex:indexPath.row];
    //    if (self.PicArr.count > 0) {
    //        MHProductPicModel *model = [self.PicArr objectAtIndex:0];
    //        str =model.filePath;
    //    }
    _player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:str] playModel:[SJPlayModel UITableViewCellPlayModelWithPlayerSuperviewTag:cell.view.coverImageView.tag atIndexPath:indexPath tableView:self.tableView]];
    //    _player.URLAsset.title = self.taskname;
    _player.URLAsset.alwaysShowTitle = YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   return   kRealValue(306);
   
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(SJTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) _self = self;
    cell.view.clickedPlayButtonExeBlock = ^(SJPlayView * _Nonnull view) {
        __strong typeof(_self) self = _self;
        if ( !self ) return;
        [self sj_playerNeedPlayNewAssetAtIndexPath:indexPath];
    };
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.filmArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return [SJTableViewCell cellWithTableView:tableView];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player vc_viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player vc_viewDidDisappear];
}

- (BOOL)prefersStatusBarHidden {
    return [self.player vc_prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.player vc_preferredStatusBarStyle];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
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
