//
//  wrongStringtoJsonString.m
//  BTC-Kline
//
//  Created by bf on 2017/2/28.
//  Copyright © 2017年 yate1996. All rights reserved.
//

#import "wrongStringtoJsonString.h"

@implementation wrongStringtoJsonString
+ (NSArray *)getJsonString:(NSString *)str{
    NSMutableString *strs = [NSMutableString stringWithString:str];
   strs = [strs stringByReplacingOccurrencesOfString:@"jsonret({'list':[{" withString:@""];
   strs =  [strs stringByReplacingOccurrencesOfString:@"}]})" withString:@""];
   strs =  [strs stringByReplacingOccurrencesOfString:@"\'" withString:@""];
    NSArray *array = [strs componentsSeparatedByString:@","];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i< array.count; i++) {
        NSMutableString *inString = array[i];
        inString = [inString stringByReplacingOccurrencesOfString:@" " withString:@""];
        [result  addObject:[inString componentsSeparatedByString:@":"].lastObject];
    }
    return result;
}
@end
