

//
//  MHTaskSubmitViewController.m
//  wgts
//
//  Created by yuhao on 2018/11/9.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import "MHTaskSubmitViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AliyunOSSDemo.h"
@interface MHTaskSubmitViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate>
@property (strong, nonatomic)UIScrollView *activityScroll;
@property (strong, nonatomic)UIButton *rightbtn;
@property (nonatomic, strong)NSString *taskurl;
@property (nonatomic, strong)NSData *data;
@end

@implementation MHTaskSubmitViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorFromRGB(0xf2f2f2);
    self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightbtn.frame = CGRectMake(0, kRealValue(10), kRealValue(60), kRealValue(30));
    self.rightbtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
    [self.rightbtn setTitle:@"重新上传" forState:UIControlStateNormal];
    [self.rightbtn setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
    [self.rightbtn addTarget:self action:@selector(uploadAgin) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightbtn];
    [self.navigationItem setRightBarButtonItem:rightItem];
    self.rightbtn.hidden = YES;
    self.title = self.pagetitle;
    self.taskurl = @"";
    [self createview];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)uploadAgin
{
    [self changepicact];
}
-(void)createview
{

    
    self.activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-kTopHeight )];
    self.activityScroll.backgroundColor = [UIColor whiteColor];
    self.activityScroll.showsHorizontalScrollIndicator = NO;
    self.activityScroll.showsVerticalScrollIndicator = NO;
    self.activityScroll.backgroundColor = KColorFromRGB(0xEEF3F5);
    self.activityScroll.delegate =self;

//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(10), kRealValue(10), kScreenWidth - kRealValue(20), kRealValue(60))];
//    label.text = @"tips:请按照要求上传完整的朋友圈截图，如上传伪造、虚假、以及不正当言论的截图，一经发现，立即封号，永不解冻!";
//    label.numberOfLines = 0;
//    label.backgroundColor = KColorFromRGB(0xEEF3F5);
//    label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
//    label.textColor = KColorFromRGB(0xE83642);
//    [self.activityScroll addSubview:label];

    self.wxShareImage = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(0), kRealValue(0), kScreenWidth, kScreenHeight)];
//    self.wxShareImage.backgroundColor = kRandomColor;
    self.wxShareImage.backgroundColor = KColorFromRGB(0xf2f2f2);
//    self.wxShareImage.image = kGetImage(@"img_bitmap_img");
//    self.wxShareImage.contentMode = UIViewContentModeScaleAspectFill;
    self.wxShareImage.userInteractionEnabled = YES;
    [self.activityScroll addSubview:self.wxShareImage];
    self.plachImage = [[UIImageView alloc]init];
    self.plachImage.image = kGetImage(@"up_img_icon");
    [self.wxShareImage addSubview:self.plachImage];
    [self.plachImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wxShareImage.mas_top).offset(kRealValue(175));
        make.width.mas_equalTo(kRealValue(79));
        make.height.mas_equalTo(kRealValue(79));
        make.centerX.equalTo(self.wxShareImage.mas_centerX).offset(kRealValue(0));
      
    }];
    
    self.plachlabel = [[UILabel alloc]init];
    self.plachlabel.text =@"暂未上传任务截图，点击上传";
    self.plachlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.plachlabel.textColor = KColorFromRGB(0xA8A9A8);
    self.plachlabel.textAlignment=NSTextAlignmentCenter;
    [self.plachImage addSubview:self.plachlabel];
    [self.plachlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.plachImage.mas_bottom).offset(kRealValue(25));
        make.left.equalTo(self.wxShareImage.mas_left).offset(0);
        make.right.equalTo(self.wxShareImage.mas_right).offset(0);
        make.height.mas_equalTo(kRealValue(20));
        
    }];
    
    
    self.activityScroll.contentSize = CGSizeMake(kScreenWidth,kScreenHeight+kRealValue(80));
    [self.view addSubview:self.activityScroll];
    UITapGestureRecognizer *changepic = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changepicact)];
    [self.wxShareImage addGestureRecognizer:changepic];
    
    
    
    
    
    
    
    UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(0), kScreenHeight - kRealValue(54)-kTopHeight - kBottomHeight, kScreenWidth, kRealValue(54)+kBottomHeight)];
    bottom.backgroundColor = KColorFromRGB(0xfffffff);
    [self.view addSubview:bottom];
    
    UIButton *subcommitTask = [UIButton buttonWithType:UIButtonTypeCustom];
    [subcommitTask setTitle:@"提交任务" forState:UIControlStateNormal];
    subcommitTask.backgroundColor = KColorFromRGB(kThemecolor);
    subcommitTask.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    subcommitTask.frame = CGRectMake(kRealValue(60), kRealValue(12) + kBottomHeight/2, kRealValue(260), kRealValue(32));
    subcommitTask.layer.cornerRadius= kRealValue(16);
    [subcommitTask addTarget:self action:@selector(subcomitAct) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:subcommitTask];
    
    
}
-(void)subcomitAct
{
    
    
    
    
    if (self.haveChoosePic == NO) {
        KLToast(@"请先选择图片")
        return;
    }
  
    if (self.iscompelete ) {
        
        
        [MBProgressHUD showActivityMessageInWindow:@"正在上传"];
        [[AliyunOSSDemo sharedInstance] uploadObjectAsync:self.data destinName:@"head" withComplete:^(NSString *urlStr, NSError *error) {
            if (urlStr) {
                self.taskurl = urlStr;
                [[MHUserService sharedInstance]initwithWGTaskCompleteWithuserTaskId:[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"userTaskId"]] completeUrl:self.taskurl taskId:@"" completionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                            [MBProgressHUD hideHUD];
                        KLToast([response valueForKey:@"message"]);
                       [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshTask object:nil userInfo:response[@"data"]];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                         [MBProgressHUD hideHUD];
                        KLToast([response valueForKey:@"message"]);
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                    if (error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // UI更新代码
                            [MBProgressHUD showActivityMessageInWindow:@"上传失败"];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [MBProgressHUD hideHUD];
                            });
                        });
                    }
                }];

            }
            if (error) {
                MHLog(@"%@",error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    [MBProgressHUD showActivityMessageInWindow:@"上传失败"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUD];
                    });
                });
            }
        }];

    }else{
      
        
        [MBProgressHUD showActivityMessageInWindow:@"正在上传"];
        [[AliyunOSSDemo sharedInstance] uploadObjectAsync:self.data destinName:@"task" withComplete:^(NSString *urlStr, NSError *error) {
            if (urlStr) {
                self.taskurl = urlStr;
                [[MHUserService sharedInstance]initwithWGTaskDetailWithTaskID:[self.dic valueForKey:@"id"] taskCode:[self.dic valueForKey:@"taskCode"] taskUrl:self.taskurl completionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        [MBProgressHUD hideHUD];
                        KLToast([response valueForKey:@"message"]);
                         [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshTask object:nil userInfo:response[@"data"]];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        [MBProgressHUD hideHUD];
                        KLToast([response valueForKey:@"message"]);
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    if (error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // UI更新代码
                            [MBProgressHUD showActivityMessageInWindow:@"上传失败"];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [MBProgressHUD hideHUD];
                            });

                        });
                    }
                    
                }];
                
            }
            if (error) {
                MHLog(@"%@",error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    [MBProgressHUD showActivityMessageInWindow:@"上传失败"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUD];
                    });
                });
            }
        }];
        
        
        
        
    }
    
    
    
}
-(void)changepicact
{
    // 判断系统是否支持相机
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.allowsEditing = NO;
    //自代理
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
#pragma mark -实现图片选择器代理-（上传图片的网络请求也是在这个方法里面进行，这里我不再介绍具体怎么上传图片）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]) {
        UIImage *theimage = nil;
        if ([picker allowsEditing]) {
            theimage = [info objectForKey:UIImagePickerControllerEditedImage];
//           UIImage *theimage1 =[info objectForKey:UIImagePickerControllerOriginalImage];
//           UIImageWriteToSavedPhotosAlbum(theimage, self, nil, nil);
        }else{
            theimage =[info objectForKey:UIImagePickerControllerOriginalImage];
        }
        self.data = UIImageJPEGRepresentation(theimage, 0.5);
        
        self.haveChoosePic = YES;
        if (self.haveChoosePic == YES) {
            self.rightbtn.hidden = NO;
            self.plachImage.hidden = YES;
            self.plachlabel.hidden = YES;
             self.activityScroll.showsVerticalScrollIndicator = YES;
        }
        self.wxShareImage.image = theimage;
//         UIImageWriteToSavedPhotosAlbum(theimage, self, nil, nil);
    
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        KLToast(@"不支持视频");
        
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
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
