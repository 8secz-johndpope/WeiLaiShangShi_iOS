
//  MHMineUserAddressCell.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineUserAddressCell.h"
#import "MHMineuserAddress.h"
@implementation MHMineUserAddressCell
-(void)setAdressModel:(MHMineuserAddress *)adressModel
{
//    _adressModel = adressModel;
//    self.namelabel.text = [NSString stringWithFormat:@"%@",adressModel.userName];
//    self.userphone.text =[NSString stringWithFormat:@"%@",adressModel.userPhone];
//    self.userAddress.text = [NSString stringWithFormat:@"%@ %@ %@ %@",adressModel.province,adressModel.city, adressModel.area, adressModel.details];
//    if ([[NSString stringWithFormat:@"%@",adressModel.addressState] isEqualToString:@"0"]) {
//        self.selelctBtn.selected = NO;
//         [_selelctBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
//    }else{
//        self.selelctBtn.selected = YES;
//         [_selelctBtn setTitle:@"默认地址" forState:UIControlStateNormal];
//    }
//
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)createview
{
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kRealValue(10))];
    lineview.backgroundColor =KColorFromRGB(0xF1F3F4);
    [self addSubview:lineview];
    [self addSubview:self.namelabel];
    [self addSubview:self.userphone];
    [self addSubview:self.userAddress];
   
    [self addSubview:self.selelctBtn];
   
    [self addSubview:self.deleteBtn];
     [self addSubview:self.editBtn];
    [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(10));
        make.top.equalTo(self.mas_top).offset(kRealValue(25));
    }];
    [self.userphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.namelabel.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.mas_top).offset(kRealValue(25));
    }];
    self.userAddress.numberOfLines =1;
    [self.userAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(10));
        make.right.equalTo(self.mas_right).offset(kRealValue(-15));
        make.top.equalTo(self.namelabel.mas_bottom).offset(kRealValue(8));
    }];
    UIView *lineSmallview = [[UIView alloc]init];
    lineSmallview.backgroundColor =KColorFromRGB(0xf0f0f0);
    [self addSubview:lineSmallview];
    [lineSmallview mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.mas_left).offset(kRealValue(15));
        make.top.equalTo(self.userAddress.mas_bottom).offset(kRealValue(10));
        make.width.mas_equalTo(kRealValue(345));
        make.height.mas_equalTo(kRealValue(1/kScreenScale));
    }];
    [self.selelctBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kRealValue(10));
        make.top.equalTo(lineSmallview.mas_bottom).offset(kRealValue(15));
        make.width.mas_equalTo(kRealValue(100));
        make.height.mas_equalTo(kRealValue(22));
    }];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(kRealValue(-15));
        make.centerY.mas_equalTo(self.selelctBtn.mas_centerY);
        make.width.mas_equalTo(kRealValue(30));
        make.height.mas_equalTo(kRealValue(22));
    }];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.deleteBtn.mas_left).offset(kRealValue(-30));
        make.centerY.mas_equalTo(self.selelctBtn.mas_centerY);
        make.width.mas_equalTo(kRealValue(30));
        make.height.mas_equalTo(kRealValue(22));
    }];
    
    
}
-(UILabel *)namelabel
{
    if (!_namelabel) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        _namelabel.textColor = [UIColor blackColor];
//        _namelabel.text = @"阿静静呐";
        _namelabel.textAlignment = NSTextAlignmentLeft;
    }
    return _namelabel;
}
-(UILabel *)userphone
{
    if (!_userphone) {
        _userphone = [[UILabel alloc]init];
        _userphone.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        _userphone.textColor = KColorFromRGB(0x666666);
//        _userphone.text = @"188 8888 8888";
        _userphone.textAlignment = NSTextAlignmentLeft;
    }
    return _userphone;
}
-(UILabel *)userAddress
{
    if (!_userAddress) {
         _userAddress = [[UILabel alloc]init];
        _userAddress.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        _userAddress.textColor = KColorFromRGB(0x666666);
//         _userAddress.text = @"安徽省 合肥市 蜀山区 莲花路与石门交口 西北口向西10米 尚泽大都会 写字楼 D栋";
        _userAddress.textAlignment = NSTextAlignmentLeft;
    }
    return _userAddress;
}
- (UIButton *)selelctBtn {
    if (_selelctBtn == nil){
        _selelctBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selelctBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
        [_selelctBtn setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_selelctBtn setTitleColor:KColorFromRGB(0x000000) forState:UIControlStateSelected];
        _selelctBtn.titleLabel.font = [UIFont systemFontOfSize:kFontValue(12)];
        [_selelctBtn setImage:[UIImage imageNamed:@"ic_public_choice_unselect"] forState:UIControlStateNormal];
        [_selelctBtn setImage:[UIImage imageNamed:@"ic_public_choice_select_main"] forState:UIControlStateSelected];
//        [_selelctBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        _selelctBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_selelctBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
        [_selelctBtn addTarget:self action:@selector(SelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selelctBtn;
}
-(void)SelectButtonAction:(UIButton *)sender
{
    if (sender.selected == YES) {
        return;
    }
    if (self.setdefaultAct) {
        self.setdefaultAct(self.tag);
    }
    
    sender.selected = !sender.selected;
}


- (UIButton *)editBtn {
    if (_editBtn == nil){
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:kFontValue(12)];
        [_editBtn addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}
-(void)editButtonAction
{
    if (self.editAct) {
        self.editAct(self.tag);
    }
    
}
- (UIButton *)deleteBtn {
    if (_deleteBtn == nil){
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteAct:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:kFontValue(12)];
        [_deleteBtn addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
-(void)deleteAct:(UIButton *)sender
{
    if (self.deleteAct) {
        self.deleteAct(self.tag);
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
