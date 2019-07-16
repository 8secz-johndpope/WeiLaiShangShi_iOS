//
//  MHMineUserInfoViewController.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineUserInfoViewController.h"
#import "MHMineUserInfoCommonView.h"
#import "MHMineuserInfoCommonViewSecond.h"
#import "MHMineUserInfoChangeNameViewController.h"
#import "MHSetPsdVC.h"
#import "MHFixPhoneOneVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AliyunOSSDemo.h"
#import "MHLoginViewController.h"
#import "HSMineuserInfoCommonViewSecond.h"
@interface MHMineUserInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong)UIScrollView *activityScroll;
@property (nonatomic, strong)UIImageView *headUserImage;
@property (nonatomic, strong)MHMineUserInfoCommonView *usernameView;
@property (nonatomic, strong)MHMineuserInfoCommonViewSecond *yaoqingView;
@property (nonatomic, strong)MHMineuserInfoCommonViewSecond *wxview;
@property (nonatomic, strong)MHMineUserInfoCommonView *txView;
@property (nonatomic, strong)MHMineuserInfoCommonViewSecond *Phoneview ;
//@property(nonatomic,strong) UIImagePickerController *imagePicker;
@end

@implementation MHMineUserInfoViewController
- (instancetype)initWithModel:(NSMutableDictionary *)userInfo
{
    self = [super init];
    if (self) {
       // self.dic = userInfo;
        
       
    }
    return self;
}
-(void)getnetWork
{
    self.dic = [NSMutableDictionary dictionary];
    [[MHUserService sharedInstance] initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.dic  = [response valueForKey:@"data"];
           [self createview];
            if (!klObjectisEmpty(self.dic)) {
                self.usernameView.righttitle.text = [self.dic valueForKey:@"nickname"];
                self.Phoneview.rightSubtitle.text =[self.dic valueForKey:@"phone"];
                [self.headUserImage sd_setImageWithURL:[NSURL URLWithString:[self.dic valueForKey:@"avatar"]]];
                if ( [[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"modifyPayPassword"]] isEqualToString:@"0"]) {
                    self.txView.righttitle.text= @"去设置";
                }else{
                    
                    self.txView.righttitle.text= @"修改支付密码";
                }
                UITapGestureRecognizer *SetCodetap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SetCodetapAct:)];
                [self.txView.righttitle addGestureRecognizer:SetCodetap];
                
                NSString *userRolestr = [NSString stringWithFormat:@"%@",[self.dic valueForKey:@"userRole"]];
                if (![userRolestr isEqualToString:@"ORD"]) {
                    self.yaoqingView.hidden =NO;
                    self.txView.hidden =NO;
                    self.yaoqingView.rightSubtitle.text =[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"inviteCode"]] ;
                }else{
                    
                    self.yaoqingView.hidden =YES;
                    self.txView.hidden =YES;
                    self.txView.frame = CGRectMake(0, kRealValue(125), kScreenWidth, kRealValue(1));
                    self.yaoqingView.hidden =YES;
                    self.Phoneview.frame=CGRectMake(0, self.txView.frame.size.height+self.txView.frame.origin.y, kScreenWidth, kRealValue(50));
                    self.yaoqingView.frame =CGRectMake(0, self.Phoneview.frame.size.height+self.Phoneview.frame.origin.y , kScreenWidth, kRealValue(50));
                }
                UITapGestureRecognizer *copytap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(copyTapact)];
                
                self.yaoqingView.righttitle.userInteractionEnabled =YES;
                [self.yaoqingView.righttitle addGestureRecognizer:copytap];

                
            }
            
        }
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getnetWork];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"设置";
    
    
    // Do any additional setup after loading the view.
}
-(void)copyTapact
{
    UIPasteboard *copy = [UIPasteboard generalPasteboard];
    [copy setString:self.yaoqingView.rightSubtitle.text];
    if (copy == nil || [self.yaoqingView.rightSubtitle.text isEqualToString:@""]==YES)
    {
        
       KLToast(@"复制失败")
        
        
    }else{
         KLToast(@"复制成功")
        
        
    }
    
}
-(void)SetCodetapAct:(UITapGestureRecognizer *)sender
{

    if ([self.txView.righttitle.text isEqualToString:@"去设置"]) {
        MHLog(@"设置修改资金密码");
        MHSetPsdVC *vc = [[MHSetPsdVC alloc] init];
        vc.navtitle =@"设置资金密码";
        vc.dic = self.dic;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MHLog(@"修改资金密码");
        MHSetPsdVC *vc = [[MHSetPsdVC alloc] init];
        vc.navtitle =@"修改资金密码";
        vc.dic = self.dic;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)wxtapAct:(UITapGestureRecognizer *)sender
{
//    UILabel *label = [self.view viewWithTag:45490];
//    if ([label.text isEqualToString:@"已绑定"]) {
//        return;
//    }else{
//        MHLog(@"去绑定微信");
//        [[UMSocialManager defaultManager]getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
//            if (error) {
//                KLToast(@"您取消了微信绑定");
//            }else{
//                UMSocialUserInfoResponse *resp = result;
//                
//                
//                
////                [[MHUserService sharedInstance]initWithChangeUserInfoupdateType:@"BIND_USER_WECHAT" userNickname:@"" userImage:@"" openId:resp.openid unionId:resp.unionId originUserPhone:@"" originUserPhoneCode:@"" newUserPhone:@"" newUserPhoneCode:@"" newPayPassword:@"" newConfirmPassword:@"" newPayPasswordCode:@"" isOldPhone:YES CompletionBlock:^(NSDictionary *response, NSError *error) {
////                    if (ValidResponseDict(response)) {
////                        KLToast(@"绑定成功");
////                        self.wxview.rightSubtitle.hidden= YES;
////                        self.wxview.smallline.hidden = YES;
////                        self.wxview.righttitle.text = @"已绑定";
////                        self.wxview.righttitle.textColor = KColorFromRGB(0x666666);
////
////                    }else{
////                        KLToast([response valueForKey:@"message"]);
////                    }
////                }];
//                
//            }
//        }];
//    }
    

}
-(void)createview
{
    self.activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight)];
    self.activityScroll.backgroundColor = KColorFromRGB(0xf1f2f5);
    self.activityScroll.showsHorizontalScrollIndicator = NO;
    self.activityScroll.showsVerticalScrollIndicator = NO;
    self.activityScroll.contentSize = CGSizeMake(0,kScreenHeight);
    
    //头像
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(0), kScreenWidth, kRealValue(70))];
    headview.backgroundColor = [UIColor whiteColor];
    [self.activityScroll addSubview:headview];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(0), kScreenWidth, 1/kScreenScale)];
    lineview.backgroundColor = KColorFromRGB(0xE1E1E1);
    [headview addSubview:lineview];
    
    UIView *lineview1 = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10), kRealValue(69), kScreenWidth-kRealValue(20), 1/kScreenScale)];
    lineview1.backgroundColor = KColorFromRGB(0xE1E1E1);
    [headview addSubview:lineview1];
    
    
    UILabel *headlabel =[[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(24), 40,kRealValue(30))];
    headlabel.text = @"头像";
    headlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    headlabel.textColor = KColorFromRGB(0x999999);
    headlabel.textAlignment = NSTextAlignmentLeft;
    [headview addSubview:headlabel];
    
    UIImageView *headrightIcon = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(37), kRealValue(26), kRealValue(22), kRealValue(22))];
    headrightIcon.image= kGetImage(@"ic_public_more");
    [headview addSubview:headrightIcon];
    
    self.headUserImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(85), kRealValue(15), kRealValue(44), kRealValue(44))];
     self.headUserImage.image = kGetImage(@"icon-1024");
//    self.headUserImage.backgroundColor = kRandomColor;
    self.headUserImage.layer.masksToBounds =YES;
    self.headUserImage.userInteractionEnabled= YES;
    self.headUserImage.layer.cornerRadius = kRealValue(22);
    [headview addSubview:self.headUserImage];
    UITapGestureRecognizer *usImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(usImageTapAct)];
    [headview addGestureRecognizer:usImageTap];
    
//
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(72), kRealValue(359), 1)];
//    line.backgroundColor = KColorFromRGB(0xf0f0f0);
//    [headview addSubview:line];
    
    self.usernameView = [[MHMineUserInfoCommonView alloc]initWithFrame:CGRectMake(0, kRealValue(70), kScreenWidth, kRealValue(55)) righttitle:@"   " lefttitle:@"昵称" istopLine:NO isBottonLine:YES];
    [self.activityScroll addSubview:self.usernameView];
    
    UITapGestureRecognizer *usernameTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userNameTapAct)];
    [self.usernameView addGestureRecognizer:usernameTap];
    

    self.txView = [[MHMineUserInfoCommonView alloc]initWithFrame:CGRectMake(0,kRealValue(125)  , kScreenWidth, kRealValue(50)) righttitle:@"未设置/安全" lefttitle:@"资金密码" istopLine:NO isBottonLine:YES];
    [self.activityScroll addSubview:self.txView ];
    
   
    
    
//
//    self.wxview = [[MHMineuserInfoCommonViewSecond alloc]initWithFrame:CGRectMake(0, self.yaoqingView.frame.size.height+self.yaoqingView.frame.origin.y + 10, kScreenWidth, kRealValue(50)) lefttitle:@"微信号" righttitle:@"去绑定" rightSubtitle:@"* * * *" istopLine:YES isBottonLine:YES];
//    [self.activityScroll addSubview:self.wxview];
    
    self.Phoneview = [[MHMineuserInfoCommonViewSecond alloc]initWithFrame:CGRectMake(0, self.txView.frame.size.height+self.txView.frame.origin.y , kScreenWidth, kRealValue(50)) lefttitle:@"手机号" righttitle:@"" rightSubtitle:@"188-8888-8888" istopLine:NO isBottonLine:YES];
    [self.activityScroll addSubview:self.Phoneview];
    
    
    UITapGestureRecognizer *changePhonetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePhone)];
    [self.Phoneview.righttitle addGestureRecognizer:changePhonetap];
    
    self.yaoqingView = [[HSMineuserInfoCommonViewSecond alloc]initWithFrame:CGRectMake(0, self.Phoneview.frame.size.height+self.Phoneview.frame.origin.y, kScreenWidth, kRealValue(50)) lefttitle:@"邀请码" righttitle:@"复制" rightSubtitle:@"  " istopLine:NO isBottonLine:YES];
    [self.activityScroll addSubview:self.yaoqingView];
   
    
    [self.view addSubview:self.activityScroll];
    
    
    self.loginout = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginout.backgroundColor = KColorFromRGB(0xffffff);
    self.loginout.titleLabel.font =[UIFont fontWithName:kPingFangLight size:kFontValue(14)];
    [self.loginout setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.loginout setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.loginout.layer.masksToBounds =YES;
    self.loginout.layer.cornerRadius = 5;
    [self.loginout addTarget:self action:@selector(loginoutAct) forControlEvents:UIControlEventTouchUpInside];
    self.loginout.frame =CGRectMake(kRealValue(0), kScreenHeight - kBottomHeight - kRealValue(44)- kTopHeight, kScreenWidth, kRealValue(44)+kBottomHeight);
    [self.view addSubview:self.loginout];
}

-(void)loginoutAct
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"确认退出未来商市" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [[MHBaseClass sharedInstance]loginOut];
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
       
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    
    //显示弹出框
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}

-(void)changePhone
{
    MHLog(@"%@",@"修改手机号");
    MHFixPhoneOneVC *vc = [[MHFixPhoneOneVC alloc] initWithModel:self.dic];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)usImageTapAct{
    
    //自定义消息框
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    //显示消息框
    [sheet showInView:self.view];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
        NSUInteger sourceType = 0;
        // 判断系统是否支持相机
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerController.delegate = self; //设置代理
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = sourceType; //图片来源
            if (buttonIndex == 0) {
                //拍照
                sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerController.sourceType = sourceType;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }else if (buttonIndex == 1){
                //相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePickerController.sourceType = sourceType;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
        }else {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.sourceType = sourceType;
            imagePickerController.delegate = self; //设置代理
            imagePickerController.allowsEditing = YES;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
}


#pragma mark -实现图片选择器代理-（上传图片的网络请求也是在这个方法里面进行，这里我不再介绍具体怎么上传图片）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
   
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]) {
        UIImage *theimage = nil;
        if ([picker allowsEditing]) {
            theimage = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            theimage =[info objectForKey:UIImagePickerControllerOriginalImage];
        }
        NSData *data = UIImageJPEGRepresentation(theimage, 0.5);
  
        [MBProgressHUD showActivityMessageInWindow:@"正在上传"];
        [[AliyunOSSDemo sharedInstance] uploadObjectAsync:data destinName:@"head" withComplete:^(NSString *urlStr, NSError *error) {
            
            if (urlStr) {
                MHLog(@"%@",urlStr);
                
                [[MHUserService sharedInstance]initWithChangeUserInfoupdateType:@"UPDATE_USER_IMAGE" userNickname:@"" userImage:urlStr openId:@"" unionId:@"" originUserPhone:@"" originUserPhoneCode:@"" newUserPhone:@"" newUserPhoneCode:@"" newPayPassword:@"" newConfirmPassword:@"" newPayPasswordCode:@"" isOldPhone:@"" CompletionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                         [MBProgressHUD showActivityMessageInWindow:@"上传成功"];
                        
                         [MBProgressHUD hideHUD];
                        
                        
                    }else{
                        [MBProgressHUD showActivityMessageInWindow:@"上传失败"];
                        [MBProgressHUD hideHUD];
                        
                    }
                     [picker dismissViewControllerAnimated:YES completion:nil];
                    
                }];
            }
          
            
            
        }];
        UIImageWriteToSavedPhotosAlbum(theimage, self, nil, nil);
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        KLToast(@"不支持视频");
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
   
    
    
    
   
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}



-(void)userNameTapAct
{
    MHMineUserInfoChangeNameViewController *vc = [[MHMineUserInfoChangeNameViewController alloc]init];
    vc.dic = self.dic;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
