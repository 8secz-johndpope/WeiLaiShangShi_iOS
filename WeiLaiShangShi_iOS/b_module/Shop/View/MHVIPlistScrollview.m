//
//  MHVIPlistScrollview.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHVIPlistScrollview.h"
#import "MHLevelSrollCell.h"


@implementation MHVIPlistScrollview

-(id)initWithFrame:(CGRect)frame array:(NSArray*)array{
    
    self = [super initWithFrame:frame];
    if (self) {
    
//        self.arrData = array;
        self.rowIndex = 0;
       
//         [self createTimer];
     
    }
    return self;
}


-(void)setArrData:(NSArray *)arrData{
    _arrData = arrData;
    if ([_arrData count] > 0) {
        [self addSubview:self.tableView];
    }
}


- (void)createTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
}

-(void)dealTimer{
    NSLog(@"%ld", self.rowIndex);
    self.rowIndex ++;
    [self.tableView setContentOffset:CGPointMake(0, kRealValue(50) * self.rowIndex) animated:YES];
    
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[SUTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.userInteractionEnabled = NO;
        _tableView.rowHeight = kRealValue(50);
        [_tableView registerClass:[MHLevelSrollCell class] forCellReuseIdentifier:NSStringFromClass([MHLevelSrollCell class])];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHLevelSrollCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHLevelSrollCell class])];
    if (self.arrData.count>0) {
         [cell creatModel:_arrData[indexPath.row]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)stopTimer
{
    if ([_timer isValid] == YES) {
        [_timer invalidate];
        _timer = nil;
    }
}



@end
