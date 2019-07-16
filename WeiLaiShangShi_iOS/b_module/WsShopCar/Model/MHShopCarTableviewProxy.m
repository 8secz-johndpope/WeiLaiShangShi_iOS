//
//  MHShopCarTableviewProxy.m
//  mohu
//
//  Created by 余浩 on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHShopCarTableviewProxy.h"
#import "MHShopCarCell.h"
#import "MHShopCarProductModel.h"
#import "MHShopCarBrandModel.h"
#import "MHShopCarHeadView.h"




@implementation MHShopCarTableviewProxy
#pragma mark UITableViewDataSource

- (UIView *)makePlaceHolderView
{
    
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        view.backgroundColor =KColorFromRGB(0xF1F2F1);
        
        UIImageView *image = [[UIImageView alloc]init];
        image.frame =CGRectMake(kRealValue(163), kRealValue(151), kRealValue(49), kRealValue(49));
        image.image = kGetImage(@"gucwu");
        [view addSubview:image];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(224),kScreenWidth, kRealValue(15))];
        label.text= @"购物车空空如也,";
        label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        label.textColor =KColorFromRGB(0xc4c4c4);
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(240), kScreenWidth, kRealValue(20))];
        label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        label1.text= @"快去挑选喜欢的宝贝吧!";
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor =KColorFromRGB(0xc4c4c4);
        [view addSubview:label1];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"立即前往" forState:UIControlStateNormal];
        [button setTitleColor:KColorFromRGB(0xffffff) forState:UIControlStateNormal];
        button.backgroundColor = KColorFromRGB(0xf74b16);
        button.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    button.layer.cornerRadius = kRealValue(6);
        [button addTarget:self action:@selector(goaround) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(kRealValue(132), kRealValue(280), kRealValue(110), kRealValue(30));
        [view addSubview:button];
    
    return view;;

}
-(void)goaround{
    [self.delegate goaround];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MHShopCarBrandModel *model = self.dataArray[section];
    NSArray *productArr = model.products;
    return productArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MHShopCarCell"];
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"  删除  " backgroundColor:[UIColor redColor]]];
    cell.rightSwipeSettings.transition = MGSwipeStateSwipingRightToLeft;
    cell.delegate = self;
    if (indexPath.row == 0) {
        cell.viewline.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    MHShopCarBrandModel *brand = self.dataArray[indexPath.section];
    NSArray *productArray = brand.products;
    if (productArray.count > indexPath.row) {
        MHShopCarProductModel *productmodel = productArray[indexPath.row];
      
        
        [cell configureShopcartCellWithProductURL:productmodel.productSmallImage productName:productmodel.productName productSize:productmodel.productStandard productPrice:productmodel.productPrice productCount:[productmodel.productCount integerValue] productStock:productmodel.skuAmount productSelected:productmodel.isSelected isEdit:self.isEdit];
    }
    __weak __typeof(self) weakSelf = self;
    cell.shopCarCellBlock = ^(BOOL isSelected){
        if (weakSelf.shopCarProxyProductSelectBlock) {
            weakSelf.shopCarProxyProductSelectBlock(isSelected, indexPath);
        }
    };
    
    cell.shopCarCellEditBlock = ^(NSInteger count){
        if (weakSelf.shopCarProxyChangeCountBlock) {
            weakSelf.shopCarProxyChangeCountBlock(count, indexPath);
        }
    };
    cell.shopCarCellShowSizeBlock = ^(NSString *des) {
        if (weakSelf.shopCarProxyShowProductSizeBlock) {
            weakSelf.shopCarProxyShowProductSizeBlock(indexPath);
        }
    };
    
    return cell;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shopCarProxyEnterDetail) {
        self.shopCarProxyEnterDetail(indexPath);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MHShopCarHeadView *shopcartHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MHShopCarHeadView"];
    kWeakSelf(self);
    if ([[GVUserDefaults standardUserDefaults].userRole integerValue] == 0) {
        shopcartHeaderView.imge.hidden = YES;
        shopcartHeaderView.goUpdatelabel.hidden = YES;
    }
    
    
    shopcartHeaderView.Gotoupgrade = ^{
        if (weakself.UsergotoUpgrade) {
            weakself.UsergotoUpgrade();
        }
    };
    if (self.dataArray.count > section) {
        MHShopCarBrandModel *brandModel = self.dataArray[section];
        
        [shopcartHeaderView configureShopcartHeaderViewWithBrandName:brandModel.sellerName imgaeurl:brandModel.sellerIcon brandSelect:brandModel.isSelected userInfo:brandModel.moneyDesc];
    }
    
    __weak __typeof(self) weakSelf = self;
    shopcartHeaderView.shopcartHeaderViewBlock = ^(BOOL isSelected){
        if (weakSelf.shopcarProxyBrandSelectBlock) {
            weakSelf.shopcarProxyBrandSelectBlock(isSelected, section);
        }
    };
    return shopcartHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kRealValue(75);
}


-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion{
    
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
        if (self.shopCarProxyDeleteBlock) {
            self.shopCarProxyDeleteBlock(indexPath);
        }
        return NO; //Don't autohide to improve delete expansion animation
    }
    
    return YES;
}

//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        if (self.shopCarProxyDeleteBlock) {
//            self.shopCarProxyDeleteBlock(indexPath);
//        }
//    }];
//
//
//
//    return @[deleteAction];
//}


@end
