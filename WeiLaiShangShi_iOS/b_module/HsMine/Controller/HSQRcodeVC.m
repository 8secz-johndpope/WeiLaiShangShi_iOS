//
//  HSQRcodeVC.m
//  HSKD
//
//  Created by AllenQin on 2019/3/12.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSQRcodeVC.h"
#import "HMScannerController.h"
#import "UIControl+BlocksKit.h"
#import "UIImage+Common.h"
#import "RichStyleLabel.h"

@interface HSQRcodeVC ()

@property(strong,nonatomic)NSDictionary *responseDict;
@property(copy,nonatomic)NSString *urlStr;

@end

@implementation HSQRcodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推广二维码";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f8e5c7"];
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, kRealValue(485))];
    backgroundView.image = kGetImage(@"cqcode_bg");
    [self.view addSubview:backgroundView];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kRealValue(308), kRealValue(104), kRealValue(104))];
    ViewRadius(bgView, kRealValue(5));
    bgView.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:bgView];
    bgView.centerX = self.view.centerX;
    
    

    
    UIImageView *qrcode = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(1), kRealValue(1), kRealValue(102), kRealValue(102))];
    [bgView addSubview:qrcode];
    
    UILabel *descLabel2 =  [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(422), kRealValue(285), kRealValue(20))];
    descLabel2.textAlignment = NSTextAlignmentCenter;
    descLabel2.textColor = [UIColor whiteColor];
    descLabel2.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
    [backgroundView addSubview:descLabel2];
    descLabel2.text = @"扫描下载未来商市APP";
    descLabel2.centerX = self.view.centerX;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(45), kRealValue(550), kRealValue(134), kRealValue(40))];
    leftBtn.backgroundColor = [UIColor colorWithHexString:@"f22b55"];
    leftBtn.layer.cornerRadius = kRealValue(20);
    [leftBtn bk_addEventHandler:^(id sender) {
        UIImage *image =  [UIImage imageFromView:self.view];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
        
    } forControlEvents:UIControlEventTouchUpInside];
    leftBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(18)];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setTitle:@"保存图片" forState:UIControlStateNormal];
    leftBtn.layer.masksToBounds = YES;
    [self.view addSubview:leftBtn];
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth -kRealValue(45) -kRealValue(134), kRealValue(550), kRealValue(134), kRealValue(40))];
    rightBtn.backgroundColor = [UIColor clearColor];
    rightBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(17)];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"f22b55"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"复制链接" forState:UIControlStateNormal];
    ViewBorderRadius(rightBtn, kRealValue(20), 1, [UIColor colorWithHexString:@"f22b55"]);
    [rightBtn bk_addEventHandler:^(id sender) {

        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.urlStr;
        KLToast(@"复制成功");
    } forControlEvents:UIControlEventTouchUpInside];
    rightBtn.layer.masksToBounds = YES;
    [self.view addSubview:rightBtn];
    
    
    
    [[MHUserService sharedInstance]initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.responseDict = response[@"data"];
            if (ValidStr(response[@"data"][@"inviteCode"])) {
                NSString *newStr = [NSString stringWithFormat:@"我的邀请码：%@",response[@"data"][@"inviteCode"]];
                RichStyleLabel *textLabel = [[RichStyleLabel alloc] initWithFrame:CGRectMake(0, kRealValue(485), kRealValue(230), kRealValue(35))];
                textLabel.backgroundColor = [UIColor colorWithHexString:@"fbeed9"];
                textLabel.textAlignment = NSTextAlignmentCenter;
                textLabel.textColor = [UIColor colorWithHexString:@"#c48e2d"];
                textLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
                [self.view addSubview:textLabel];
                textLabel.centerX  = self.view.centerX;
    
                [textLabel setAttributedText:newStr withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#f22b55"],NSFontAttributeName : [UIFont fontWithName:kPingFangSemibold size:kFontValue(21)]}];
                
                
                
            }

            [[MHUserService sharedInstance]initWithFirstPageComponent:@"3" parentTypeId:@"-1" completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    NSArray *bannerArr = response[@"data"];
                    [bannerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj[@"type"] isEqualToString:@"TWO_DIMENSION_CODE"]) {
                            NSArray *picArr = obj[@"result"];
                            [picArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                if ([obj[@"actionUrl"] rangeOfString:@"?"].location !=NSNotFound) {
                                    //&
                                    NSData *data = [self.responseDict[@"inviteCode"] dataUsingEncoding:NSUTF8StringEncoding];
                                    NSString *strbase =  [data base64EncodedStringWithOptions:0];
                                    self.urlStr =  [NSString stringWithFormat:@"%@&userCode=%@",obj[@"actionUrl"],strbase];
                                    
                                }else{
                                    NSData *data = [self.responseDict[@"inviteCode"] dataUsingEncoding:NSUTF8StringEncoding];
                                    NSString *strbase =  [data base64EncodedStringWithOptions:0];
                                     self.urlStr =  [NSString stringWithFormat:@"%@?userCode=%@",obj[@"actionUrl"],strbase];
                                }
                                [HMScannerController cardImageWithCardName:self.urlStr avatar:kGetImage(@"logo1") scale:0.2 completion:^(UIImage *image) {
                                    qrcode.image = image;
                                }];
                            }];
                        }
                    }];
                }
            }];
            
            
            
            

        }
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    KLToast(@"保存成功");
    MHLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}


@end
