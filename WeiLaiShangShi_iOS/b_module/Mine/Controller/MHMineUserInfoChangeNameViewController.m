//
//  MHMineUserInfoChangeNameViewController.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineUserInfoChangeNameViewController.h"
#import "UITextView+MHTextView.h"
@interface MHMineUserInfoChangeNameViewController ()<UITextViewDelegate>
@property (nonatomic, retain)   UITextView *textView;
@property(nonatomic, strong)UITextField *nameField;
@end

@implementation MHMineUserInfoChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorFromRGB(0xf1f2f5);
    self.title = @"编辑昵称";
    [self createview];
    // Do any additional setup after loading the view.
}
-(void)createview
{
    UIView *bfview = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(10), kScreenWidth, kRealValue(44))];
    bfview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bfview];
    
    UIView *linetop = [[UIView alloc] init];
    linetop.frame = CGRectMake(0,0,kScreenWidth,1/kScreenScale);
    linetop.layer.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1].CGColor;
    [bfview addSubview:linetop];
    
    UIView *lineBottom = [[UIView alloc] init];
    lineBottom.frame = CGRectMake(0,kRealValue(44)-1/kScreenScale,kScreenWidth,1/kScreenScale);
    lineBottom.layer.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1].CGColor;
    [bfview addSubview:lineBottom];
   

    self.textView = [[UITextView alloc] init];
    self.textView.frame =CGRectMake( kRealValue(15), kRealValue(10), kScreenWidth-kRealValue(30), kRealValue(40));
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:kFontValue(14)];
    //    self.textView.keyboardType=UIKeyboardTypeDefault;
    self.textView.returnKeyType = UIReturnKeyDone;
    //    textView.center = self.view.center;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.scrollEnabled = NO;
    //    textView.text = @"请写在自定义属性前面，如果长度大于limitLength设置长度会被自动截断。";
    self.textView.placeholder = [self.dic valueForKey:@"nickname"];
    self.textView.limitLength = @12;
//    self.textView.autoHeight = @1;
    [bfview addSubview: self.textView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endtapAct)];
    [self.view addGestureRecognizer:tap];
    
    UIButton *savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [savebtn setTitle:@"保存" forState:UIControlStateNormal];
    [savebtn setTitleColor:KColorFromRGB(0xffffff) forState:UIControlStateNormal];
    savebtn.layer.cornerRadius = 5;
    savebtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    savebtn.backgroundColor = KColorFromRGB(kThemecolor);
    savebtn.frame = CGRectMake( kRealValue(108), kRealValue(84), kRealValue(160), kRealValue(30));
    [savebtn addTarget:self action:@selector(savebtAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savebtn];
    
}
-(void)savebtAct
{
   
    if (self.textView.text.length <1) {
        KLToast(@"请输入您要修改昵称");
        return;
    }
    
    [[MHUserService sharedInstance]initWithChangeUserInfoupdateType:@"UPDATE_USER_NICKNAME"  userNickname:self.textView.text userImage:@"" openId:@"" unionId:@"" originUserPhone:@"" originUserPhoneCode:@"" newUserPhone:@"" newUserPhoneCode:@"" newPayPassword:@"" newConfirmPassword:@"" newPayPasswordCode:@"" isOldPhone:YES CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            KLToast(@"修改成功");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            KLToast([response valueForKey:@"message"]);
        }
    }];
    
}
-(void)endtapAct
{
    [self.view endEditing:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{

    return YES;
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
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
