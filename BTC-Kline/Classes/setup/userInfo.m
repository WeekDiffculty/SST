//
//  userInfo.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/22.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "userInfo.h"

@implementation userInfo
+ (instancetype)userInfoWith:(NSDictionary *)dict{
    if(dict==nil)return nil;
    userInfo *userinfo = [[userInfo alloc]init];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    userinfo.login = [formatter stringFromNumber: dict[@"login"]];
    userinfo.agent_account = [formatter stringFromNumber: dict[@"agent_account"]];
    userinfo.balance = [formatter stringFromNumber: dict[@"balance"]];
    userinfo.group = dict[@"group"];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    userinfo.profit = [formatter stringFromNumber: dict[@"profit"]];
    formatter.numberStyle = kCFNumberFormatterNoStyle;
    userinfo.credit = dict[@"credit"];
   userinfo.enable = dict[@"enable"];
   userinfo.enable_change_password = dict[@"enable_change_password"];
   userinfo.enable_read_only = dict[@"enable_read_only"];
   userinfo.equity = dict[@"equity"];
   userinfo.flags = dict[@"flags"];
   userinfo.freemagrin = dict[@"freemagrin"];
   userinfo.ip = dict[@"ip"];
   userinfo.leverage = dict[@"leverage"];
   userinfo.magrin = dict[@"magrin"];
   userinfo.name = dict[@"name"];
   userinfo.password = dict[@"password"];
   userinfo.prevbalance = dict[@"prevbalance"];

    return  userinfo;
}
@end
