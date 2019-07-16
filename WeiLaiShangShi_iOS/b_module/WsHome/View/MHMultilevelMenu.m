//
//  MHMultilevelMenu.m
//  mohu
//
//  Created by AllenQin on 2018/9/8.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHMultilevelMenu.h"
#import "MHMultiCollectionCell.h"
#import "MHMultiTableViewCell.h"
#import "MHMultiCollectionReusableView.h"
#import "MHMenuModel.h"

#define kMultilevelCollectionViewCell @"MultilevelCollectionViewCell"
#define kMultilevelCollectionHeader   @"MultilevelCollectionHeader"
#define kMultilevelTableViewCellId      @"kMultilevelTableViewCell"
#define kLeftWidth 110

@interface MHMultilevelMenu()

@property(strong,nonatomic ) UITableView * leftTablew;
@property(strong,nonatomic ) UICollectionView * rightCollection;

@property(assign,nonatomic) BOOL isReturnLastOffset;

@end


@implementation MHMultilevelMenu

-(id)initWithFrame:(CGRect)frame WithData:(NSArray *)data withSelectIndex:(void (^)(NSInteger, id, id))selectIndex
{
    
    if (self  == [super initWithFrame:frame]) {
        if (data.count==0) {
            return nil;
        }
        
        _block=selectIndex;
        self.leftSelectColor = [UIColor blackColor];
        self.leftSelectBgColor = [UIColor colorWithHexString:@"ffffff"];
        self.leftBgColor = [UIColor whiteColor];
        self.leftSeparatorColor = [UIColor colorWithHexString:@"#F1F2F4"];
        self.leftUnSelectBgColor = [UIColor colorWithHexString:@"F2F3F5"];
        self.leftUnSelectColor = [UIColor blackColor];
        _selectIndex= 0;
        _allData = data;
        /**
         左边的视图
         */
        self.leftTablew=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, frame.size.height)];
        self.leftTablew.dataSource=self;
        self.leftTablew.backgroundColor = [UIColor colorWithHexString:@"F2F3F5"];
        self.leftTablew.delegate=self;
        self.leftTablew.tableFooterView=[[UIView alloc] init];
         [self.leftTablew registerClass:[MHMultiTableViewCell class] forCellReuseIdentifier:kMultilevelTableViewCellId];
        [self addSubview:self.leftTablew];
        self.leftTablew.backgroundColor=[UIColor colorWithHexString:@"F2F3F5"];
        if ([self.leftTablew respondsToSelector:@selector(setLayoutMargins:)]) {
            self.leftTablew.layoutMargins=UIEdgeInsetsZero;
        }
        if ([self.leftTablew respondsToSelector:@selector(setSeparatorInset:)]) {
            self.leftTablew.separatorInset=UIEdgeInsetsZero;
        }
        self.leftTablew.separatorColor=self.leftSeparatorColor;
        
        /**
         右边的视图
         */
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0.f;//左右间隔
        flowLayout.minimumLineSpacing = 0.f;
        self.rightCollection=[[UICollectionView alloc] initWithFrame:CGRectMake(kLeftWidth +kRealValue(10),0,kScreenWidth-kLeftWidth - kRealValue(10),frame.size.height) collectionViewLayout:flowLayout];
        
        self.rightCollection.delegate=self;
        self.rightCollection.dataSource=self;
        self.rightCollection.showsVerticalScrollIndicator = NO;
        [self.rightCollection registerClass:[MHMultiCollectionCell class] forCellWithReuseIdentifier:kMultilevelCollectionViewCell];
        
        [self.rightCollection registerClass:[MHMultiCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMultilevelCollectionHeader];
        [self addSubview:self.rightCollection];
        
        self.isReturnLastOffset=YES;
        self.rightCollection.backgroundColor=self.leftSelectBgColor;
        self.backgroundColor=self.leftSelectBgColor;

    }
    return self;
}

-(void)setNeedToScorllerIndex:(NSInteger)needToScorllerIndex{
    if (needToScorllerIndex>0) {
        
        /**
         *  滑动到 指定行数
         */
        [self.leftTablew selectRowAtIndexPath:[NSIndexPath indexPathForRow:needToScorllerIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        
        MHMultiTableViewCell * cell=(MHMultiTableViewCell*)[self.leftTablew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:needToScorllerIndex inSection:0]];
        UILabel * line=(UILabel*)[cell viewWithTag:100];
        line.backgroundColor=cell.backgroundColor;
        cell.leftTitle.textColor=self.leftSelectColor;
        cell.backgroundColor=self.leftSelectBgColor;
        _selectIndex=needToScorllerIndex;
        
        [self.rightCollection reloadData];
        
    }
    _needToScorllerIndex=needToScorllerIndex;
}
-(void)setLeftBgColor:(UIColor *)leftBgColor{
    _leftBgColor=leftBgColor;
    self.leftTablew.backgroundColor=leftBgColor;
    
}
-(void)setLeftSelectBgColor:(UIColor *)leftSelectBgColor{
    
    _leftSelectBgColor=leftSelectBgColor;
    self.rightCollection.backgroundColor=leftSelectBgColor;
    
    self.backgroundColor=leftSelectBgColor;
}
-(void)setLeftSeparatorColor:(UIColor *)leftSeparatorColor{
    _leftSeparatorColor=leftSeparatorColor;
    self.leftTablew.separatorColor=leftSeparatorColor;
}
-(void)reloadData{
    
    [self.leftTablew reloadData];
    [self.rightCollection reloadData];
    
}
#pragma mark---左边的tablew 代理
#pragma mark--deleagte
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark--dcollectionView里有多少个组
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allData.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    MHMultiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMultilevelTableViewCellId];
    MHMenuModel * title=self.allData[indexPath.row];
    cell.leftTitle.text=title.typeName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    UILabel * line=(UILabel*)[cell viewWithTag:100];
    
    if (indexPath.row==self.selectIndex) {
        cell.leftTitle.textColor=self.leftSelectColor;
        cell.backgroundColor=self.leftSelectBgColor;
        cell.leftIcon.hidden = NO;
        cell.leftTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
//        line.backgroundColor= cell.backgroundColor;
        cell.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    else{
        cell.leftIcon.hidden = YES;
        cell.leftTitle.textColor=self.leftUnSelectColor;
        cell.leftTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        cell.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
        cell.backgroundColor=self.leftUnSelectBgColor;
//        line.backgroundColor=tableView.separatorColor;
    }
    
    
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins=UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(49);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHMultiTableViewCell *cell=(MHMultiTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:_selectIndex inSection:0];
    MHMultiTableViewCell *oldCell=(MHMultiTableViewCell*)[tableView cellForRowAtIndexPath:oldIndexPath];
    oldCell.leftTitle.textColor = self.leftUnSelectColor;
    oldCell.leftIcon.hidden = YES;
    oldCell.leftTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    oldCell.backgroundColor = [UIColor colorWithHexString:@"F2F3F5"];
    cell.leftTitle.textColor = self.leftSelectColor;
    cell.backgroundColor = self.leftSelectBgColor;
    cell.leftTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    cell.backgroundColor = [UIColor whiteColor];
    cell.leftIcon.hidden = NO;
    _selectIndex = indexPath.row;
    MHMenuModel * title=self.allData[indexPath.row];
    UILabel * line=(UILabel*)[cell viewWithTag:100];
    line.backgroundColor=cell.backgroundColor;
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.isReturnLastOffset=NO;
    [self.rightCollection reloadData];
    if (self.isRecordLastScroll) {
        [self.rightCollection scrollRectToVisible:CGRectMake(0, title.offsetScorller, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }
    else{
        
        [self.rightCollection scrollRectToVisible:CGRectMake(0, 0, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }
    
    
}



#pragma mark---imageCollectionView--------------------------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
//    if (self.allData.count==0) {
//        return 0;
//    }
//
//    MHMenuModel * title=self.allData[self.selectIndex];
//    return title.nextArray.count;
    return 1;
    
}
#pragma mark---每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    MHMenuModel * title=self.allData[self.selectIndex];
    
    if (title.nextArray.count>0) {
        
//        MHMenuModel *sub=title.nextArray[section];
        
//        if (sub.nextArray.count==0){//没有下一级
//
//            return 1;
//
//        }else{
//
//            return sub.nextArray.count;
//        }
         return title.nextArray.count;
        
    }else{
        
        return title.nextArray.count;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MHMenuModel * title=self.allData[self.selectIndex];
    MHMenuModel * meun =title.nextArray[indexPath.section];
    MHMenuModel * meun1 =title.nextArray[indexPath.section];
    if (meun.nextArray.count>0) {
        meun=title.nextArray[indexPath.section];
        NSArray * list=meun.nextArray;
        meun=list[indexPath.row];
    }
    
    void (^select)(NSInteger left,id right,id info) = self.block;
    select(self.selectIndex,meun1,meun);
    
}

#pragma mark---定义并返回每个cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    MHMultiCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: kMultilevelCollectionViewCell forIndexPath:indexPath];
    MHMenuModel * title=self.allData[self.selectIndex];
    MHMenuModel * meun=title.nextArray[indexPath.row];
//
//    if (meun.nextArray.count>0) {
//        meun=title.nextArray[indexPath.section];
//        NSArray * list=meun.nextArray;
//        meun=list[indexPath.row];
//    }
    
    cell.titile.text=meun.typeName;
    //给一张默认图片，先使用默认图片，当图片加载完成后再替换
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:meun.typeImage]
                      placeholderImage:nil];
    return cell;
}

#pragma mark---定义并返回每个headerView或footerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSString *reuseIdentifier = kMultilevelCollectionHeader;
        MHMultiCollectionReusableView *sectionHeaderView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            MHMenuModel * title=self.allData[self.selectIndex];
        if (title.nextArray.count>0) {
            
            MHMenuModel * meun = title.nextArray[indexPath.section];
            sectionHeaderView.headTitle.text=meun.typeName;
            
        }else{
            
            sectionHeaderView.headTitle.text=@" ";
        }
        return sectionHeaderView;
        
    }
    
    return nil;
}

#pragma mark---UICollectionViewDelegateFlowLayout 是UICollectionViewDelegate的子协议
#pragma mark---每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kRealValue(70), kRealValue(100));
}
#pragma mark---设置每组的cell的边界, 具体看下图
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kRealValue(10), 0, kRealValue(10), kRealValue(10));
}

#pragma mark---cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
#pragma mark---
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={kScreenWidth,kRealValue(34)};
    return size;
}



#pragma mark---记录滑动的坐标
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.rightCollection]) {
        
        self.isReturnLastOffset=YES;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:self.rightCollection]) {
        
        MHMenuModel * title=self.allData[self.selectIndex];
        title.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rightCollection]) {
        
        MHMenuModel * title=self.allData[self.selectIndex];
        title.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
        
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.rightCollection] && self.isReturnLastOffset) {
        MHMenuModel * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        
        
    }
}



#pragma mark--Tools
-(void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}



@end
