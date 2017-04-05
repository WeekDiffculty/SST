//
//  userInfo.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/22.
//  Copyright © 2016年 yate1996. All rights reserved.
//
/*
 LOGIN 用户ID
 GROUP 组
 NAME 姓名
 BALANCE 账户余额
 MARGIN 已用保证金
 MARGIN_FREE 可用保证金
 */
#import "userInfo.h"
#import <UIKit/UIKit.h>
@implementation userInfo
+ (instancetype)userInfoWith:(NSDictionary *)dict{
    if(dict==nil)return nil;
    userInfo *userinfo = [[userInfo alloc]init];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    userinfo.login = dict[@"LOGIN"];
    userinfo.agent_account = [formatter stringFromNumber: dict[@"agent_account"]];
    userinfo.balance =  dict[@"BALANCE"];
    userinfo.group = dict[@"GROUP"];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    userinfo.profit = [formatter stringFromNumber: dict[@"profit"]];
    formatter.numberStyle = kCFNumberFormatterNoStyle;
    userinfo.credit = dict[@"credit"];
    userinfo.enable = dict[@"enable"];
    userinfo.enable_change_password = dict[@"enable_change_password"];
    userinfo.enable_read_only = dict[@"enable_read_only"];
    userinfo.equity = dict[@"equity"];
    userinfo.flags = dict[@"flags"];
    userinfo.freemagrin = dict[@"MARGIN_FREE"];
    userinfo.ip = dict[@"ip"];
    userinfo.leverage = dict[@"leverage"];
    userinfo.magrin = dict[@"MARGIN"];
    userinfo.name = dict[@"NAME"];
    userinfo.password = dict[@"password"];
    userinfo.prevbalance = dict[@"prevbalance"];
    CGFloat margins = [dict[@"MARGIN"] floatValue];
    CGFloat freemargins = [dict[@"MARGIN_FREE"] floatValue];
    NSString *rate = [NSString stringWithFormat:@"%0.2f%@",(freemargins/margins*100),@"%"];
    userinfo.ratemargin = rate;
    return  userinfo;
}
@end
