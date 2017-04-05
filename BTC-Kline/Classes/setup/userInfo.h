//
//  userInfo.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/22.
//  Copyright © 2016年 yate1996. All rights reserved.
//
/*


 = 1;
"" = 1;
"" = 0;
 = "1051.31";
 = "<null>";
 = "1051.31";

 = "";
 = 100;

 = 0;
 = "";
 = "";
 = "1051.38";

*/
#import <Foundation/Foundation.h>
/*
 LOGIN 用户ID
 GROUP 组
 NAME 姓名
 BALANCE 账户余额
 MARGIN 已用保证金
 MARGIN_FREE 可用保证金
 */
@interface userInfo : NSObject
/**LOGIN 用户ID */
@property (nonatomic, copy) NSString *login;

@property (nonatomic, copy) NSString *agent_account;
/**BALANCE 账户余额*/
@property (nonatomic, copy) NSString *balance;
/** GROUP 组
 */
@property (nonatomic, copy) NSString *group;
@property (nonatomic, copy) NSString *profit;

@property (nonatomic, copy) NSString *credit;
@property (nonatomic, copy) NSString *enable;
@property (nonatomic, copy) NSString *enable_change_password;
@property (nonatomic, copy) NSString *enable_read_only;
@property (nonatomic, copy) NSString *equity;
@property (nonatomic, copy) NSString *flags;
/**MARGIN_FREE 可用保证金*/
@property (nonatomic, copy) NSString *freemagrin;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSString *leverage;
/**MARGIN 已用保证金*/
@property (nonatomic, copy) NSString *magrin;
/**NAME*/
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *prevbalance;
/**保证金比率*/
@property (nonatomic, copy) NSString *ratemargin;
+ (instancetype) userInfoWith:(NSDictionary *)dict;
@end
