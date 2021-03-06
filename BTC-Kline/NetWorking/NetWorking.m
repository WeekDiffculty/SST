//
//  NetWorking.m
//  btc123
//
//  Created by jarze on 16/1/18.
//  Copyright © 2016年 btc123. All rights reserved.
//

#import "NetWorking.h"
#import "AFNetworking.h"
#import "HangQing.h"
#import "Tool.h"
#import "userInfo.h"
#import "JsonstrTodic.h"
#import "jioayiModel.h"
#import "MJExtension.h"
#import "Glob.h"
#import "GoodsDetail.h"
#import "wrongStringtoJsonString.h"
@implementation NetWorking

+(void)requestWithApi:(NSString *)url param:(NSMutableDictionary *)param thenSuccess:(void (^)(NSDictionary *responseObject))success fail:(void (^)(void))fail
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       [manager GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !success ? : success(responseObject);
        });

    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            !fail ? : fail();
        });
    }];
    
}
//*行情接口/
+ (void)requestHQWithApi:(NSString *)url param:(NSDictionary *)param success:(void (^)(HangQing *responseObject))success fail:(void (^)(NSError *error))fail{
        NSURL *urls = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:urls];
        NSURLSession * session=[NSURLSession sharedSession];
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
            if(error){
              //  NSLog(@"error %@",error);
            }
            //判断状态响应码
            NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
            if(httpresponse.statusCode==200){
                //请求成功,解析数据
                NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSArray *rightAraay = [NSArray array];
                rightAraay = [wrongStringtoJsonString getJsonString:str];
                //NSLog(@"%@",str);
                //NSArray *array = [str componentsSeparatedByString:@"|"];
                success([HangQing hangqingModelWith:rightAraay]);
                //NSLog(@"%@",array);
                dispatch_async(dispatch_get_main_queue(), ^{
                  [task suspend];
                });
            }
        }];
        //4.启动请求
        [task resume];
    
}

//商品详情
+ (void)goodsDetailWithApi:(NSString *)url success:(void (^)(GoodsDetail *model))success{
    NSURL *urls = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
            //  NSLog(@"error %@",error);
        }
        //判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            //请求成功,解析数据
            NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (![str isEqualToString:@""]&&str) {
                NSDictionary *dict = [JsonstrTodic dictionaryWithJsonString:[str substringFromIndex:1]][@"data"];
                GoodsDetail *model = [GoodsDetail mj_objectWithKeyValues:dict];
                success(model);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];
}

//*checkAccout/password/
+ (void)checkAccountWithApi:(NSString *)url account:(NSString *)account password:(NSString *)passWord success:(void (^)(BOOL responseObject))success fail:(void (^)(NSError *error))fail{
    NSString *str = [NSString stringWithFormat:@"%@?type=check&account=%@&password=%@",url,account,passWord];
    NSURL *urls = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
            !error?:fail(error);
        }
        //判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            //请求成功,解析数据
            NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ([str isEqualToString:@"0"]) {
                success(YES);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];
    
}

//*User query/
+ (void)userQueryWithApi:(NSString *)url account:(NSString *)account password:(NSString *)passWord success:(void (^)(userInfo *responseObject))success fail:(void (^)(NSError *error))fail{
   // NSString *str = [NSString stringWithFormat:@"%@?type=userinfo&login=%@&password=%@",url,account,passWord];
    NSURL *urls = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
            !error?:fail(error);
        }
        //判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            //请求成功,解析数据
            NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           NSDictionary *dict = [JsonstrTodic dictionaryWithJsonString:str];
            NSArray *array = dict[@"userlist"];
            NSDictionary *dicts = array[0];
           // userInfo *model = [userInfo userInfoWith:dict[@"data"]];
            userInfo *model = [userInfo userInfoWith:dicts];
                success(model);
            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];
}

//*查持仓/
+ (void)checkThepositionWithApi:(NSString *)url account:(NSString *)account password:(NSString *)passWord success:(void (^)(NSArray
 *responseObject))success fail:(void (^)(NSError *error))fail{
    NSString *str = [NSString stringWithFormat:@"%@?type=orderlist&login=%@&password=%@",url,account,passWord];
    NSURL *urls = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
            !error?:fail(error);
        }
        //判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            //请求成功,解析数据
            NSString *str1=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           NSDictionary *dict = [JsonstrTodic dictionaryWithJsonString:str1];
//            NSDictionary *dict = dff[@"data"];
            NSArray *array = dict[@"orderlist"];
              //NSArray *arrays = dict[@"rows"];
            success(array);
            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];
}

//*历史K线History K line 参数:商品名称，K线周期，时间戳/
+ (void)historyKlineQueryWithApi:(NSDictionary *)parma  success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail{
    
    NSString *str = [NSString stringWithFormat:@"%@?type=%@&symbol=%@&period=%@&starttime=%@&endtime=%@&timesign=%@",K_LINE,@"chart",parma[@"symbol"],@30,parma[@"starttime"],parma[@"endtime"],@300];
    NSURL *urls = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
            !error?:fail(error);
        }
        //判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            //请求成功,解析数据
            NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (str) {
                NSDictionary *dict = [JsonstrTodic dictionaryWithJsonString:str];
                success (dict);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];
}

//开仓 open Position 参数:帐号login,密码pwd，商品symbol，数量volume，方向cmd /
+ (void) openPositionWithApi:(NSString *)url param:(NSDictionary *)param success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail{
    NSURL *urls = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
            !error?:fail(error);
        }
        //判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            //请求成功,解析数据
            NSMutableString *str=[[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *strLast = [str substringFromIndex:(str.length -1)];
            NSString *str1;
            if ([strLast isEqualToString:@"}"]) {
                str1 = str;
            }else{
                str1 = [str substringToIndex:(str.length -1)];
            }
            NSDictionary *dict = [JsonstrTodic dictionaryWithJsonString:str1];
            success(dict);
            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];
}

//*平仓 UNWIND 参数:帐号login,密码pwd，单号order,平仓数量volume，品种symbol，价格price/
+ (void) unwindWithApi:(NSString *)url param:(jioayiModel *)param success:(void (^)(NSDictionary  *responseObject))success fail:(void (^)(NSError *error))fail{
    Account *ccount = [NSKeyedUnarchiver unarchiveObjectWithFile:[GoodsPath sharePath].account];
#pragma ..lkjfkdslfadsj;fsd
    NSString *urlss = [NSString stringWithFormat:@"%@?type=closeorder&order=%@&volume=%@&symbol=%@&login=%@&password=%@",url,param.order,param.volume,param.symbol,@"10080",@"abc123"];
    NSURL *urls = [NSURL URLWithString:urlss];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
            !error?:fail(error);
        }
        //判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            //请求成功,解析数据
            NSMutableString *str=[[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *strLast = [str substringFromIndex:(str.length -1)];
            NSString *str1;
            if ([strLast isEqualToString:@"}"]) {
                str1 = str;
            }else{
                str1 = [str substringToIndex:(str.length -1)];
            }
            NSDictionary *dict = [JsonstrTodic dictionaryWithJsonString:str1];
            success(dict);

            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];
}

+ (void)getTokenWithApi:(NSString *)url withUserId:(NSString *)userID name:(NSString *)name portraitUri:(NSString *)portraitUri success:(void (^)(NSString *))cuccess {
    NSDictionary *param = @{@"userId":userID,@"name":name,@"portraitUri":PORTRAITURLI};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString * timestamp = [[NSString alloc] initWithFormat:@"%ld",(NSInteger)[NSDate timeIntervalSinceReferenceDate]];
    NSString * nonce = [NSString stringWithFormat:@"%d",arc4random()];
    NSString * appkey = @"qd46yzrfqukaf";
    NSString * Signature = [NSString stringWithFormat:@"%@%@%@",appkey,nonce,timestamp ];//用sha1对签名进行加密,随你用什么方法,MD5...
    //以下拼接请求内容
    [manager.requestSerializer setValue:appkey forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [manager.requestSerializer setValue:Signature forHTTPHeaderField:@"Signature"];
    [manager.requestSerializer setValue:@"ISoSXrgSrf7Yol" forHTTPHeaderField:@"appSecret"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //开始请求
[manager POST:TOKEN parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSDictionary *dict = (NSDictionary *)responseObject;
    NSString *token = dict[@"token"];
    cuccess(token);
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
}];
    
}

+ (void)netStatus:(NSString *)url success:(void (^)(BOOL))netStatus fial:(void (^)(BOOL))fail{
    NSURL *urls = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
            fail(YES);
        }
//        判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            netStatus(YES);
            //NSLog(@"%@",array);
            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];
}

@end
