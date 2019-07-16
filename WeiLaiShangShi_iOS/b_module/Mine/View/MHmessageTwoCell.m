//
//  MHmessageTwoCell.m
//  mohu
//
//  Created by yuhao on 2018/10/23.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHmessageTwoCell.h"
#import "MHMessageModel.h"
@implementation MHmessageTwoCell
-(void)createAnnouceWithModel:(MHMessageModel *)messagemodel
{
    
    self.messagetime.text = messagemodel.startTime;
    self.messagetime.textColor = KColorFromRGB(0x999999);
    self.messagetime.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    
    self.messagecontent.text = messagemodel.subTitle;
    self.messagecontent.textColor = KColorFromRGB(0x666666);
   
    self.messagetitle.text = messagemodel.title;
     self.messagecontent.textColor = KColorFromRGB(0x222222);
    
    self.detallabel.textColor = KColorFromRGB(0x666666);
    
    self.messagetitle.hidden = YES;
    self.messagetime.hidden = YES;
    self.messageimage.hidden =YES;
    self.messagecontent.hidden = YES;
    self.lineview.hidden = YES;
    self.detallabel.hidden = YES;
    self.prizenumrightIcon.hidden =YES;
    
    
    if (!klStringisEmpty(messagemodel.imgList)) {
        if (!klStringisEmpty(messagemodel.startTime)) {
            CGRect rect = [messagemodel.title boundingRectWithSize:CGSizeMake(kRealValue(330), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
            self.bgview.frame = CGRectMake(kRealValue(21), kRealValue(30), kRealValue(334), kRealValue(230+rect.size.height));
            
            [self.messageimage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.top.equalTo(self.messagetitle.mas_bottom).offset(kRealValue(10));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(121));
            }];
            [self.messageimage sd_setImageWithURL:[NSURL URLWithString:messagemodel.imgList] placeholderImage:kGetImage(kfailImage)];
            [self.messagecontent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.top.equalTo(self.messageimage.mas_bottom).offset(kRealValue(10));
            }];
            [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.messagecontent.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(1));
            }];
            
            [self.detallabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(100));
                make.height.mas_equalTo(kRealValue(18));
            }];
            
            
            [self.prizenumrightIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.width.mas_equalTo(kRealValue(22));
                make.height.mas_equalTo(kRealValue(22));
            }];
            
            self.messagetitle.hidden = NO;
            self.messagetime.hidden = NO;
            self.messageimage.hidden =NO;
            self.messagecontent.hidden = NO;
            self.lineview.hidden = NO;
            self.detallabel.hidden = NO;
            self.prizenumrightIcon.hidden =NO;
            
            
            
        }else{
            CGRect rect = [messagemodel.title boundingRectWithSize:CGSizeMake(kRealValue(330), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
            self.bgview.frame = CGRectMake(kRealValue(21), kRealValue(30), kRealValue(334), kRealValue(200+rect.size.height));
            [self.messageimage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.top.equalTo(self.messagetitle.mas_bottom).offset(kRealValue(10));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(121));
            }];
            [self.messageimage sd_setImageWithURL:[NSURL URLWithString:messagemodel.imgList] placeholderImage:kGetImage(kfailImage)];
            [self.messagecontent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.top.equalTo(self.messageimage.mas_bottom).offset(kRealValue(10));
            }];
            [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.messagecontent.mas_bottom).offset(kRealValue(5));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(0));
            }];
            
            [self.detallabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(5));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(100));
                make.height.mas_equalTo(kRealValue(0));
            }];
            
            
            
            [self.prizenumrightIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(5));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.width.mas_equalTo(kRealValue(0));
                make.height.mas_equalTo(kRealValue(0));
            }];
            
            
            self.messagetitle.hidden = NO;
            self.messagetime.hidden = NO;
            self.messageimage.hidden =NO;
            self.messagecontent.hidden = NO;
            self.lineview.hidden = YES;
            self.detallabel.hidden = YES;
            self.prizenumrightIcon.hidden =YES;
        }
        
    }else{
        
        if (!klStringisEmpty(messagemodel.startTime)) {
            CGRect rect = [messagemodel.title boundingRectWithSize:CGSizeMake(kRealValue(330), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
            self.bgview.frame =  CGRectMake(kRealValue(21), kRealValue(30), kRealValue(334), kRealValue(95)+rect.size.height);
            [self.messageimage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.top.equalTo(self.messagetitle.mas_bottom).offset(kRealValue(0));
                make.width.mas_equalTo(kRealValue(0));
                make.height.mas_equalTo(kRealValue(0));
            }];
            [self.messagecontent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.top.equalTo(self.messageimage.mas_bottom).offset(kRealValue(10));
            }];
            [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.messagecontent.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(1));
            }];
            
            [self.detallabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(100));
                make.height.mas_equalTo(kRealValue(18));
            }];
            
            
            [self.prizenumrightIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.width.mas_equalTo(kRealValue(22));
                make.height.mas_equalTo(kRealValue(22));
            }];
            
            
            
            self.messagetitle.hidden = NO;
            self.messagetime.hidden = NO;
            self.messageimage.hidden =YES;
            self.messagecontent.hidden = NO;
            self.lineview.hidden = NO;
            self.detallabel.hidden = NO;
            self.prizenumrightIcon.hidden =NO;
            
        }else{
            CGRect rect = [messagemodel.title boundingRectWithSize:CGSizeMake(kRealValue(330), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
            self.bgview.frame =  CGRectMake(kRealValue(21), kRealValue(30), kRealValue(334), kRealValue(60)+rect.size.height);
            [self.messageimage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.top.equalTo(self.messagetitle.mas_bottom).offset(kRealValue(0));
                make.width.mas_equalTo(kRealValue(0));
                make.height.mas_equalTo(kRealValue(0));
            }];
            [self.messagecontent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.top.equalTo(self.messageimage.mas_bottom).offset(kRealValue(10));
            }];
            [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.messagecontent.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(0));
            }];
            
            [self.detallabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(0));
                make.height.mas_equalTo(kRealValue(0));
            }];
            
            
            
            [self.prizenumrightIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.width.mas_equalTo(kRealValue(0));
                make.height.mas_equalTo(kRealValue(0));
            }];
            
            
            
            self.messagetitle.hidden = NO;
            self.messagetime.hidden = NO;
            self.messageimage.hidden =YES;
            self.messagecontent.hidden = NO;
            self.lineview.hidden = YES;
            self.detallabel.hidden = YES;
            self.prizenumrightIcon.hidden =YES;
        }
        
        
        
    }
    
    
}

-(void)setMessagemodel:(MHMessageModel *)messagemodel
{
    
    self.messagetime.text = messagemodel.messageTime;
    self.messagecontent.text = messagemodel.title;
    self.messagetitle.text = messagemodel.messageType;
    
    self.messagetitle.hidden = YES;
    self.messagetime.hidden = YES;
    self.messageimage.hidden =YES;
    self.messagecontent.hidden = YES;
    self.lineview.hidden = YES;
    self.detallabel.hidden = YES;
    self.prizenumrightIcon.hidden =YES;
    
    if (!klStringisEmpty(messagemodel.coverPlan)) {
        if (!klStringisEmpty(messagemodel.content)) {
            CGRect rect = [messagemodel.title boundingRectWithSize:CGSizeMake(kRealValue(330), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
            self.bgview.frame = CGRectMake(kRealValue(21), kRealValue(30), kRealValue(334), kRealValue(280+rect.size.height));
            
            [self.messageimage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.top.equalTo(self.messagetitle.mas_bottom).offset(kRealValue(10));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(171));
            }];
            [self.messageimage sd_setImageWithURL:[NSURL URLWithString:messagemodel.coverPlan] placeholderImage:kGetImage(kfailImage)];
            [self.messagecontent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.top.equalTo(self.messageimage.mas_bottom).offset(kRealValue(10));
            }];
            [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.messagecontent.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(1));
            }];
            
            [self.detallabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(100));
                make.height.mas_equalTo(kRealValue(18));
            }];
         
            
            [self.prizenumrightIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.width.mas_equalTo(kRealValue(22));
                make.height.mas_equalTo(kRealValue(22));
            }];
            
            self.messagetitle.hidden = NO;
            self.messagetime.hidden = NO;
            self.messageimage.hidden =NO;
            self.messagecontent.hidden = NO;
            self.lineview.hidden = NO;
            self.detallabel.hidden = NO;
            self.prizenumrightIcon.hidden =NO;
            
            
            
        }else{
             CGRect rect = [messagemodel.title boundingRectWithSize:CGSizeMake(kRealValue(330), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
             self.bgview.frame = CGRectMake(kRealValue(21), kRealValue(30), kRealValue(334), kRealValue(250+rect.size.height));
            [self.messageimage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.top.equalTo(self.messagetitle.mas_bottom).offset(kRealValue(10));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(171));
            }];
            [self.messageimage sd_setImageWithURL:[NSURL URLWithString:messagemodel.coverPlan] placeholderImage:kGetImage(kfailImage)];
            [self.messagecontent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.top.equalTo(self.messageimage.mas_bottom).offset(kRealValue(10));
            }];
            [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.messagecontent.mas_bottom).offset(kRealValue(5));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(0));
            }];
           
            [self.detallabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(5));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(100));
                make.height.mas_equalTo(kRealValue(0));
            }];
            
         
            
            [self.prizenumrightIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(5));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.width.mas_equalTo(kRealValue(0));
                make.height.mas_equalTo(kRealValue(0));
            }];
          
            
            self.messagetitle.hidden = NO;
            self.messagetime.hidden = NO;
            self.messageimage.hidden =NO;
            self.messagecontent.hidden = NO;
            self.lineview.hidden = YES;
            self.detallabel.hidden = YES;
            self.prizenumrightIcon.hidden =YES;
        }
        
    }else{
        
        if (!klStringisEmpty(messagemodel.content)) {
            CGRect rect = [messagemodel.title boundingRectWithSize:CGSizeMake(kRealValue(330), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
            self.bgview.frame =  CGRectMake(kRealValue(21), kRealValue(30), kRealValue(334), kRealValue(95)+rect.size.height);
            [self.messageimage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.top.equalTo(self.messagetitle.mas_bottom).offset(kRealValue(0));
                make.width.mas_equalTo(kRealValue(0));
                make.height.mas_equalTo(kRealValue(0));
            }];
            [self.messagecontent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.top.equalTo(self.messageimage.mas_bottom).offset(kRealValue(10));
            }];
            [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.messagecontent.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(1));
            }];
            
            [self.detallabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(100));
                make.height.mas_equalTo(kRealValue(18));
            }];
            
            
            [self.prizenumrightIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.width.mas_equalTo(kRealValue(22));
                make.height.mas_equalTo(kRealValue(22));
            }];
            
            
            
            self.messagetitle.hidden = NO;
            self.messagetime.hidden = NO;
            self.messageimage.hidden =YES;
            self.messagecontent.hidden = NO;
            self.lineview.hidden = NO;
            self.detallabel.hidden = NO;
            self.prizenumrightIcon.hidden =NO;
        
        }else{
             CGRect rect = [messagemodel.title boundingRectWithSize:CGSizeMake(kRealValue(330), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]} context:nil];
            self.bgview.frame =  CGRectMake(kRealValue(21), kRealValue(30), kRealValue(334), kRealValue(60)+rect.size.height);
            [self.messageimage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.top.equalTo(self.messagetitle.mas_bottom).offset(kRealValue(0));
                make.width.mas_equalTo(kRealValue(0));
                make.height.mas_equalTo(kRealValue(0));
            }];
            [self.messagecontent mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                     make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.top.equalTo(self.messageimage.mas_bottom).offset(kRealValue(10));
            }];
            [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.top.equalTo(self.messagecontent.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(304));
                make.height.mas_equalTo(kRealValue(0));
            }];
            
            [self.detallabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(0));
                make.height.mas_equalTo(kRealValue(0));
            }];
            
       
     
            [self.prizenumrightIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineview.mas_bottom).offset(kRealValue(10));
                make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
                make.width.mas_equalTo(kRealValue(0));
                make.height.mas_equalTo(kRealValue(0));
            }];
         
            
            
            self.messagetitle.hidden = NO;
            self.messagetime.hidden = NO;
            self.messageimage.hidden =YES;
            self.messagecontent.hidden = NO;
            self.lineview.hidden = YES;
            self.detallabel.hidden = YES;
            self.prizenumrightIcon.hidden =YES;
        }
       
            
      
    }
   
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= KColorFromRGB(0xF1F3F4);
        [self createview];
    }
    return self;
}
-(void)createview
{
    
    [self addSubview:self.messagetime];
    [self.messagetime mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self.mas_top).offset(kRealValue(10));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    
    
    self.bgview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(21), kRealValue(30), kRealValue(334), kRealValue(301))];
    self.bgview.backgroundColor = [UIColor whiteColor];
    self.bgview.layer.cornerRadius = kRealValue(6);
    self.bgview.userInteractionEnabled = YES;
    [self addSubview:self.bgview];
    
    [self.bgview addSubview:self.messagetitle];
  
    [self.bgview addSubview:self.messageimage];
    [self.bgview addSubview:self.messagecontent];
    
    [self.messagetitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
        make.top.equalTo(self.bgview.mas_top).offset(kRealValue(15));
        
    }];
   
    [self.messageimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
        make.top.equalTo(self.messagetitle.mas_bottom).offset(kRealValue(10));
        make.width.mas_equalTo(kRealValue(304));
        make.height.mas_equalTo(kRealValue(171));
    }];
    [self.messagecontent mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
        make.right.equalTo(self.bgview.mas_right).offset(-kRealValue(15));
        make.top.equalTo(self.messageimage.mas_bottom).offset(kRealValue(10));
        
    }];
    
    self.lineview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(15), kRealValue(256), kRealValue(304), 1/kScreenScale)];
    self.lineview.backgroundColor = KColorFromRGB(0xf1f1f2);
    [self.bgview addSubview:self.lineview];

    
    self.detallabel  = [[UILabel alloc]init];
    self.detallabel.text = @"点击查看详情";
    self.detallabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
    self.detallabel.textAlignment = NSTextAlignmentLeft;
    self.detallabel.textColor = KColorFromRGB(0x333333);
    self.detallabel.frame = CGRectMake(kRealValue(15), kRealValue(275), kRealValue(100  ), kRealValue(18));
    [self.bgview addSubview:self.detallabel];
    
    self.prizenumrightIcon = [[UIImageView alloc]init];
    self.prizenumrightIcon.image= kGetImage(@"ic_public_more");
    self.prizenumrightIcon.frame = CGRectMake(kRealValue(297), kRealValue(271), kRealValue(22), kRealValue(22));
    [self.bgview addSubview:self.prizenumrightIcon];
    
    
}
-(UILabel *)messagetitle
{
    if (!_messagetitle) {
        _messagetitle = [[UILabel alloc]init];
        _messagetitle.text = @"到账提醒";
        _messagetitle.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
        _messagetitle.textAlignment = NSTextAlignmentLeft;
        _messagetitle.textColor = KColorFromRGB(0x000000);
        
    }
    return _messagetitle;
}
-(UILabel *)messagetime
{
    if (!_messagetime) {
        _messagetime = [[UILabel alloc]init];
        _messagetime.text = @"04/03 16:29";
        _messagetime.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        _messagetime.textAlignment = NSTextAlignmentLeft;
        _messagetime.textColor = KColorFromRGB(0x666666);
        _messagetime.userInteractionEnabled = YES;
    }
    return _messagetime;
}
-(UILabel *)messagecontent
{
    if (!_messagecontent) {
        _messagecontent = [[UILabel alloc]init];
//        _messagecontent.text = @"恭喜成为陌狐店主，您已获得800奖励，邀请6人开店即可激活提现。";
        _messagecontent.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _messagecontent.numberOfLines = 0;
        _messagecontent.textAlignment = NSTextAlignmentLeft;
        _messagecontent.textColor = KColorFromRGB(0x000000);
        _messagecontent.userInteractionEnabled = YES;
    }
    return _messagecontent;
}
-(UIImageView *)messageimage
{
    if (!_messageimage) {
        
        _messageimage = [[UIImageView alloc]init];
//        _messageimage.backgroundColor = kRandomColor;
        _messageimage.userInteractionEnabled = YES;
    }
    return _messageimage;
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
