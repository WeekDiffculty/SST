//
//  jioayiModel.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/23.
//  Copyright © 2016年 yate1996. All rights reserved.
//

/**
 "CLOSE_PRICE" = "1.00898";
 "CLOSE_TIME" = "2017-3-6 11:07:59";
 CMD = 1;
 DIGITS = 5;//
 NUMBER = 1889788679;
 "OPEN_PRICE" = "1.00848";
 "OPEN_TIME" = "2017-3-6 11:03:21";
 PROFIT = "-49.55";
 SL = 0;
 SYMBOL = USDCHF;
 TP = 0;
 VOLUME = 100;

 */
#import "jioayiModel.h"

@implementation jioayiModel

+ (instancetype)returnJiaoyiModelWithDictionary:(NSDictionary *)dict{
    jioayiModel *model = [[jioayiModel alloc]init];
    model.order = dict[@"NUMBER"];
    model.symbol = dict[@"SYMBOL"];
    model.cmd = dict[@"CMD"];
    model.volume = dict[@"VOLUME"];
    model.sl = dict[@"SL"];
    model.tp = dict[@"TP"];
    model.open_price = dict[@"OPEN_PRICE"];
    model.open_time = dict[@"OPEN_TIME"];
    model.close_time = dict[@"CLOSE_TIME"];
    model.close_price = dict[@"CLOSE_PRICE"];
    model.profit = dict[@"PROFIT"];
    model.DIGITS = dict[@"DIGITS"];
    model.value_date = dict[@"value_date"];
    model.expiration = dict[@"expiration"];
    model.commisson = dict[@"commisson"];
    model.swap = dict[@"swap"];
    return model ;
}

@end
