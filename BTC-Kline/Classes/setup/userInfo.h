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

@interface userInfo : NSObject
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *agent_account;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *group;
@property (nonatomic, copy) NSString *profit;

@property (nonatomic, copy) NSString *credit;
@property (nonatomic, copy) NSString *enable;
@property (nonatomic, copy) NSString *enable_change_password;
@property (nonatomic, copy) NSString *enable_read_only;
@property (nonatomic, copy) NSString *equity;
@property (nonatomic, copy) NSString *flags;
@property (nonatomic, copy) NSString *freemagrin;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSString *leverage;
@property (nonatomic, copy) NSString *magrin;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *prevbalance;
+ (instancetype) userInfoWith:(NSDictionary *)dict;
@end
