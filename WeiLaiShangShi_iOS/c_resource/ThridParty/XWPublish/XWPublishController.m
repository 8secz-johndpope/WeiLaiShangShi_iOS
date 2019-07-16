//
//  XWPublishController.m
//  XWPublishDemo
//
//  Created by 邱学伟 on 16/4/15.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWPublishController.h"
#import "UITextView+JKPlaceHolder.h"
//#import "AliyunOSSDemo.h"
//#import "CTOtherManager.h"
#define kMaxTextCount 200

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height//获取设备高度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width//获取设备宽度

@interface XWPublishController ()<UITextViewDelegate,UIScrollViewDelegate>{
 
    //备注文本View高度
    float noteTextHeight;
    float pickerViewHeight;
    float allViewHeight;
}




/**
 *  主视图-
 */
@property (weak, nonatomic) IBOutlet UIScrollView *mianScrollView;

@end

@implementation XWPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //收起键盘
    self.view.backgroundColor  = [UIColor colorWithHexString:@"#F2F3F5"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    [_mianScrollView setDelegate:self];
    self.showInView = _mianScrollView;
    self.title = @"意见反馈";
    [self initPickerView];
    
    [self initViews];
}


/**
 *  取消输入
 */
- (void)viewTapped{
    [self.view endEditing:YES];
}
/**
 *  初始化视图
 */
- (void)initViews{
    _noteTextBackgroudView = [[UIView alloc]init];
    _noteTextBackgroudView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    
    UIView *phoneview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    phoneview.backgroundColor = [UIColor whiteColor];
    [_mianScrollView addSubview:phoneview];
    
    
    UITextView *phonetextView = [[UITextView alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth, 44)];
    phonetextView.keyboardType = UIKeyboardTypeDefault;
    //文字样式
    [phonetextView setFont:[UIFont fontWithName:kPingFangRegular size:12]];
    [phonetextView setTextColor:[UIColor blackColor]];
    phonetextView.delegate = self;
    phonetextView.font = [UIFont fontWithName:kPingFangRegular size:12];
    phonetextView.placeholder = @"建议留下您的qq/邮箱";
   [phoneview addSubview:phonetextView];
    
    UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, kScreenWidth , 1/kScreenScale)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    [phonetextView  addSubview:lineView];
    
    
    //文本输入框
    _noteTextView = [[UITextView alloc]init];
    _noteTextView.keyboardType = UIKeyboardTypeDefault;
    //文字样式
    [_noteTextView setFont:[UIFont fontWithName:kPingFangRegular size:12]];
//    _noteTextView.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    [_noteTextView setTextColor:[UIColor blackColor]];
    _noteTextView.delegate = self;
    _noteTextView.font = [UIFont fontWithName:kPingFangRegular size:12];
    _noteTextView.placeholder = @"详细的描述您的问题或者是建议";
//        [_noteTextView jk_addPlaceHolder:@"详细的描述您的问题或者是建议"];
    _textNumberLabel = [[UILabel alloc]init];
    _textNumberLabel.textAlignment = NSTextAlignmentRight;
    _textNumberLabel.font = [UIFont fontWithName:kPingFangRegular size:12];
    _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _textNumberLabel.backgroundColor = [UIColor whiteColor];
    _textNumberLabel.text = [NSString stringWithFormat:@"0/%d    ",kMaxTextCount];
    
    
    //发布按钮样式->可自定义!
    _submitBtn = [[UIButton alloc]init];
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn setBackgroundColor:[UIColor redColor]];
    
    //圆角
    //设置圆角
    [_submitBtn.layer setCornerRadius:4.0f];
    [_submitBtn.layer setMasksToBounds:YES];
    [_submitBtn.layer setShouldRasterize:YES];
    [_submitBtn.layer setRasterizationScale:[UIScreen mainScreen].scale];
    
    [_submitBtn addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [_mianScrollView addSubview:_noteTextBackgroudView];
    [_mianScrollView addSubview:_noteTextView];
    [_mianScrollView addSubview:_textNumberLabel];
    [_mianScrollView addSubview:_submitBtn];
    
    [self updateViewsFrame];
}
/**
 *  界面布局 frame
 */
- (void)updateViewsFrame{
    
    if (!allViewHeight) {
        allViewHeight = 0;
    }
    if (!noteTextHeight) {
        noteTextHeight = 100;
    }
    
    _noteTextBackgroudView.frame = CGRectMake(0, 44, SCREENWIDTH, noteTextHeight);
    
    //文本编辑框
    _noteTextView.frame = CGRectMake(15, 44, SCREENWIDTH - 30, noteTextHeight);
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15, SCREENWIDTH-10 , 15);
    
    
    //photoPicker
    [self updatePickerViewFrameY:_textNumberLabel.frame.origin.y + _textNumberLabel.frame.size.height];
    
    
    //说明文字
    _explainLabel.frame = CGRectMake(0, [self getPickerViewFrame].origin.y+[self getPickerViewFrame].size.height+10, SCREENWIDTH, 20);
    
    
    //发布按钮
    _submitBtn.bounds = CGRectMake(20, [self getPickerViewFrame].origin.y+[self getPickerViewFrame].size.height+10, SCREENWIDTH -40, 45);
    _submitBtn .frame = CGRectMake(20, [self getPickerViewFrame].origin.y+[self getPickerViewFrame].size.height+40, SCREENWIDTH -40, 45);
    
    [_submitBtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(SCREENWIDTH -40, 45)] forState:UIControlStateNormal];
    
    
    allViewHeight = noteTextHeight + [self getPickerViewFrame].size.height + 30 + 100;
    
    _mianScrollView.contentSize = self.mianScrollView.contentSize = CGSizeMake(0,allViewHeight);
}

/**
 *  恢复原始界面布局
 */
-(void)resumeOriginalFrame{
    _noteTextBackgroudView.frame = CGRectMake(0, 44, SCREENWIDTH, noteTextHeight);
    //文本编辑框
    _noteTextView.frame = CGRectMake(15, 44, SCREENWIDTH - 30, noteTextHeight);
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15, SCREENWIDTH-10, 15);
}

- (void)pickerViewFrameChanged{
    [self updateViewsFrame];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
//     CTLog(@"当前输入框文字个数:%ld",_noteTextView.text.length);
    //当前输入字数
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)_noteTextView.text.length,kMaxTextCount];
    if (_noteTextView.text.length > kMaxTextCount) {
        _textNumberLabel.textColor = [UIColor redColor];
    }else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    
    [self textChanged];
    return YES;
}

//文本框每次输入文字都会调用  -> 更改文字个数提示框
- (void)textViewDidChangeSelection:(UITextView *)textView{

//    CTLog(@"当前输入框文字个数:%ld",_noteTextView.text.length);
    //
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)_noteTextView.text.length,kMaxTextCount];
    if (_noteTextView.text.length > kMaxTextCount) {
        _textNumberLabel.textColor = [UIColor redColor];
    }
    else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
        [self textChanged];
}

/**
 *  文本高度自适应
 */
-(void)textChanged{
    
    CGRect orgRect = self.noteTextView.frame;//获取原始UITextView的frame
    
    //获取尺寸
    CGSize size = [self.noteTextView sizeThatFits:CGSizeMake(self.noteTextView.frame.size.width, MAXFLOAT)];
    
    orgRect.size.height=size.height+10;//获取自适应文本内容高度
    
    
    //如果文本框没字了恢复初始尺寸
    if (orgRect.size.height > 100) {
        noteTextHeight = orgRect.size.height;
    }else{
        noteTextHeight = 100;
    }
    
    [self updateViewsFrame];
}

/**
 *  发布按钮点击事件
 */
- (void)submitBtnClicked{
    //检查输入
    if (![self checkInput]) {
        return;
    }
    //输入正确将数据上传服务器->
    [self submitToServer];
}

#pragma maek - 检查输入
- (BOOL)checkInput{
    //文本框没字
    if (_noteTextView.text.length == 0) {
        NSLog(@"文本框没字");
        //MBhudText(self.view, @"请添加记录备注", 1);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入文字" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCacel];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    //文本框字数超过300
    if (_noteTextView.text.length > kMaxTextCount) {
        NSLog(@"文本框字数超过400");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"超出文字限制" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCacel];
        [self presentViewController:alertController animated:YES completion:nil];
        return NO;
    }
    return YES;
}

- (void)submitToServer{
    
    if ([[self getBigImageArray] count]) {
        
//        [[AliyunOSSDemo sharedInstance]uploadImages:[self getBigImageArray] isAsync:YES complete:^(NSArray<NSString *> *names) {
//
//            [[CTOtherManager sharedInstance]getFeedbackWithContent:_noteTextView.text withPic_url:names CompletionBlock:^(NSDictionary *responseDictionary, NSError *error) {
//
//            }];
//
//        }];
        
    }else{
        
        
//        [[CTOtherManager sharedInstance]getFeedbackWithContent:_noteTextView.text withPic_url:nil CompletionBlock:^(NSDictionary *responseDictionary, NSError *error) {
//
//        }];
    }

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"提交成功!\n如果有问题咨询，请您联系在线客服哦" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:actionCacel];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"内存警告...");
}
- (IBAction)cancelClick:(UIButton *)sender {
    NSLog(@"取消");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *actionGiveUpPublish = [UIAlertAction actionWithTitle:@"放弃上传" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:actionCacel];
    [alertController addAction:actionGiveUpPublish];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
//用户向上偏移到顶端取消输入,增强用户体验
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    NSLog(@"偏移量 scrollView.contentOffset.y:%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < 0) {
        [self.view endEditing:YES];
    }
    //NSLog(@"scrollViewDidScroll");
}
@end
