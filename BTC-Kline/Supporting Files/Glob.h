//
//  Glob.h
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
// 8888666   abc123456 测试账号
#ifndef Glob_h
#define Glob_h
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

#define WeakObj(obj) __weak typeof(obj) weak##obj = obj
//#define StrongObj(obj) __strong typeof(obj) strong##obj = obj
#import "Reachability.h"
#import "NetWorking.h"
#import "Masonry.h"
#import "GoodsPath.h"
#import "JSViewController.h"
#import "Account.h"
#import "JsonstrTodic.h"
#import "MJExtension.h"
//*行情*/
#define  HQJK @"http://119.23.130.36:777/?query=price&type=jsonret&symbol="
//商品详情
#define GOODSDETAIl @"http://47.89.53.7:8788/api/?type=symbolinfo&symbol="
//账号密码校验3
#define ACCOUNT_PASSWORD @"http://47.89.53.7:8788/api/"
//用户查询
#define USER_SEARCH @"http://47.89.53.7:877/?type=getuser&login=2123479292"
//查持仓
#define CHICANG @"http://47.89.53.7:8788/api/"
//历史K线
#define K_LINE @"http://47.89.53.7:8788/api/"
//开仓
#define OPEN_POSITION @"http://47.89.53.7:8788/api/"
//平仓
#define CLOSE_POSITION @"http://47.89.53.7:8788/api/"
#endif /* Glob_h */
//获取token
#define TOKEN @"http://api.cn.ronghub.com/user/getToken.json"
//头像
#define PORTRAITURLI @"http://img5.duitang.com/uploads/item/201601/06/20160106061634_ALNQs.jpeg"

/** 自定义 Log  */
#ifdef DEBUG  // 调试的时候
#define YRLog(...) NSLog(@" %s 第%d行 \n %@", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else   //发布的时候
#define YRLog(...)
#endif
