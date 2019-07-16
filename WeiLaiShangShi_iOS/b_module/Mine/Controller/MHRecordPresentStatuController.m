//
//  MHRecordPresentStatuController.m
//  mohu
//
//  Created by yuhao on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHRecordPresentStatuController.h"

@interface MHRecordPresentStatuController ()
@end

@implementation MHRecordPresentStatuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"提现进度";
    self.view.backgroundColor = [UIColor whiteColor];
    self.isShowLiftBack = YES;
    if (!_model) {
        return;
    }
    
//    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(70), kRealValue(32), kRealValue(16), kRealValue(97))];
//    if (_model.status == 0) {
//        image.image = kGetImage(@"withdraw_begain");
//    }else if (_model.status == 1){
//        image.image = kGetImage(@"withdraw_success");
//    }else{
//        image.image = kGetImage(@"withdraw_fail");
//    }
//    [self.view addSubview:image];
//    
//    self.applytitle = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(101), kRealValue(30), kRealValue(200), kRealValue(20))];
//    self.applytitle.text = _model.progress[0][@"state"];
//    self.applytitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
//    self.applytitle.textColor = KColorFromRGB(0x000000);
//    [self.view addSubview:self.applytitle];
//    
//    
//    
//    self.applySubtitle = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(101),kRealValue(58),kRealValue(190),kRealValue(15))];
//    self.applySubtitle.text = _model.progress[0][@"msg"];
//    self.applySubtitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//    self.applySubtitle.textColor = KColorFromRGB(0x6E6E6E);
//    [self.view addSubview:self.applySubtitle];
//    
//    self.applySubtime = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(101),kRealValue(75),kRealValue(190),kRealValue(15))];
//    self.applySubtime.text = _model.progress[0][@"stateTime"];
//    self.applySubtime.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//    self.applySubtime.textColor = KColorFromRGB(0x6E6E6E);
//    [self.view addSubview:self.applySubtime];
//    
//    self.noticetitle = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(101), kRealValue(110), kRealValue(200), kRealValue(20))];
//    self.noticetitle.text = _model.progress[1][@"state"];
//    self.noticetitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
//    self.noticetitle.textColor = KColorFromRGB(0x000000);
//    [self.view addSubview:self.noticetitle];
//    
//    
//    
//    self.noticeSubtitle = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(101),kRealValue(138),kRealValue(190),kRealValue(15))];
//    self.noticeSubtitle.text = _model.progress[1][@"msg"];
//    self.noticeSubtitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//    self.noticeSubtitle.textColor = KColorFromRGB(0x6E6E6E);
//    [self.view addSubview:self.noticeSubtitle];
//    
//    self.noticeSubtime = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(101),kRealValue(155),kRealValue(190),kRealValue(15))];
//    self.noticeSubtime.text = _model.progress[1][@"stateTime"];
//    self.noticeSubtime.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//    self.noticeSubtime.textColor = KColorFromRGB(0x6E6E6E);
//    [self.view addSubview:self.noticeSubtime];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (void)backBtnClicked{
    if ([self.rootStr isEqualToString:@"root"]) {
       [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)setModel:(MHWithDrawRecordModel *)model{
    _model = model;
    
  
//
//
//
//
//
//
//    NSString *desc = @"您与2018-9-13 14:05提交了提现NN陌币申请，后台工作人员正在审核中。如有任何问题请拨打客服电话400-051-8180";
//    NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
//    textdesc.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
//    textdesc.color = [UIColor colorWithHexString:@"000000"];
//    [textdesc setTextHighlightRange:[desc rangeOfString:@"400-051-8180"]
//                              color:[UIColor colorWithHexString:@"689DFF"]
//                    backgroundColor:[UIColor colorWithHexString:@"666666"]
//                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
//
//                              [[MHBaseClass sharedInstance] presentAlertWithtitle:@"联系客服" message:@"拨打客服热线" leftbutton:@"取消" rightbutton: @"确认" leftAct:^{
//
//
//                              } rightAct:^{
//
//                                  NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-051-8180"];
//
//                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//
//                              }];
//                          }];
//    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kScreenWidth - kRealValue(53)*2, CGFLOAT_MAX) text:textdesc];
//    YYLabel *textLabel = [YYLabel new];
//    textLabel.numberOfLines = 0;
//    [self.view addSubview:textLabel];
//    textLabel.frame = CGRectMake(kRealValue(53),kRealValue(328), kScreenWidth - kRealValue(53)*2,layout.textBoundingSize.height );
//    textLabel.attributedText = textdesc;
//
    
}

@end
