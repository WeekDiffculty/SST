//
//  GoodsDetail.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 07/12/2016.
//  Copyright © 2016 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetail : NSObject
//合约数量*/
@property (nonatomic, copy) NSString *contract_size;
//保证金*/
@property (nonatomic, copy) NSString *margin_initial;
//小数位*/
@property (nonatomic, copy) NSString *digits;
//保证金模式*/
@property (nonatomic, copy) NSString *margin_mode;
//盈利模式*/
@property (nonatomic, copy) NSString *profit_mode;
//止损水平*/
@property (nonatomic, copy) NSString *stops_level;
//商品品种*/
@property (nonatomic, copy) NSString *symbol;
//刻度大小*/
@property (nonatomic, copy) NSString *tick_size;
//刻度值*/
@property (nonatomic, copy) NSString *tick_value;

@end
