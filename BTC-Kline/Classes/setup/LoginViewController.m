//
//  LoginViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "LoginViewController.h"
#import "Glob.h"
#import "ViewController.h"
#import "AddAccountViewController.h"
//#import <RongIMKit/RongIMKit.h>
#import "more.h"
@interface LoginViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreAccount;
@property (weak, nonatomic) IBOutlet UIButton *connectType;
@property (nonatomic, strong) more *more;
@property (nonatomic, strong) UITableView *tableView ;
@property (nonatomic, copy) NSArray *accounts;
@property (nonatomic) BOOL shouldSavepass;
@end

@implementation LoginViewController
- (UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSArray *)accounts{
    if (!_accounts) {
        _accounts = [NSArray array];
        _accounts = [[NSUserDefaults standardUserDefaults]objectForKey:@"accounts"];
    }
    return _accounts;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.accounts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strID = @"dddd";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:strID];
    }
    NSDictionary *dict = self.accounts[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated{
    //如果有登陆过的用户 打开界面 自动填充账号
    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"accounts"];
    if (array.count!=0&&array) {
        NSDictionary *dict = array.lastObject;
        self.account.text = dict[@"name"];
        self.password.text = dict[@"pass"];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.accounts[indexPath.row];
    self.account.text = dict[@"name"];
    self.password.text = dict[@"pass"];
    [self.tableView removeFromSuperview];
}
- (more *)more{
    if (!_more) {
        _more = [[more alloc]init];
        _more.layer.masksToBounds = YES;
        _more.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:67 green:62 blue:88 alpha:1.0]);
        _more.backgroundColor = [UIColor colorWithRed:67 green:62 blue:88 alpha:0];
        _more.userInteractionEnabled = NO;
    }
    return _more;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.password.delegate = self;
    [self loadDefaultsetting];
}
- (void)loadDefaultsetting{
    self.more.frame = CGRectMake(10, 10, 20, 20);
   // [self.moreAccount addSubview:self.more];
    [self.moreAccount addSubview:self.more];
    [self.moreAccount addTarget:self action:@selector(moreAccount:) forControlEvents:UIControlEventTouchUpInside];
    more *view = [self.more copy];
    view.frame = CGRectMake(self.connectType.frame.size.width - 33, 8, 20, 20);
    [view.layer setNeedsDisplay
     ];
    view.backgroundColor = self.more.backgroundColor;
    view.layer.masksToBounds  = YES;
    view.userInteractionEnabled = NO;
    [self.connectType addSubview:view];
    [self.connectType addTarget:self action:@selector(changeConnetType) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)moreAccount:(UIButton *)btn{
    UIView *view = self.account.superview;
    [view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.account.mas_bottom);
        make.leading.equalTo(self.account);
        make.trailing.equalTo(self.more.mas_leading);
        make.height.equalTo(@60);
    }];
    WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 6*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [weakself.tableView removeFromSuperview];
    });
    
}
- (void)changeConnetType{
    self.connectType.selected = !self.connectType.selected;
    [self.connectType setTitle:@"Real" forState:UIControlStateSelected];
    [self.connectType setTitle:@"Demo" forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self login:nil];
    return YES;
}
- (IBAction)login:(id)sender {
    [self.account resignFirstResponder];
    [self.password resignFirstResponder];
    if (![self.account.text isEqualToString:@""]&&![self.password.text isEqualToString:@""]) {
        [NetWorking checkAccountWithApi:ACCOUNT_PASSWORD account:self.account.text password:self.password.text success:^(BOOL responseObject) {
            if(responseObject){
                [self loginSucessBack:nil];
            }
        } fail:^(NSError *error) {
            [self tip:@"登陆失败，检查网络或联系交易服务商"];
        }];
    }else{
        [self tip:@"用户名密码不能为空"];
    }
}


-(void)loginWithceshi:(void(^)(BOOL success))success{
    [NetWorking checkAccountWithApi:ACCOUNT_PASSWORD account:@"999666" password:@"sst123456" success:^(BOOL responseObject) {
        if(responseObject){
            [self loginSucessBack:^(BOOL ceshi) {
                success(ceshi);
            }];
        }
    } fail:^(NSError *error) {
        success(NO);
    }];
}

- (void)loginSucessBack:(void (^)(BOOL ceshi))ceshi{
    Account *count =  [Account shareAccount];
    if (self.account&&self.password) {
        count.account = self.account.text;
        count.password = self.password.text;
    }else{
        count.account = @"999666";
        count.password = @"sst123456";
        
    }
    [self saveAccounts];
    BOOL ret = [NSKeyedArchiver archiveRootObject:count toFile:[GoodsPath sharePath].account];
    NSLog(@"%@",ret?@2:@0);
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"token"] isEqualToString:@""]||![[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
        [NetWorking getTokenWithApi:TOKEN withUserId:count.account name:count.account portraitUri:nil success:^(NSString *token) {
            [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]synchronize];
//            [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
//                NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
//            } error:^(RCConnectErrorCode status) {
//                NSLog(@"登陆的错误码为:%ld", status);
//            } tokenIncorrect:^{
//                //token过期或者不正确。
//                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
//                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
//                NSLog(@"token错误");
//            }];

        }];
    }
       WeakObj(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakself.account && weakself.password) {
            [weakself dismissViewControllerAnimated:NO completion:nil];
            //登录成功的回掉
            weakself.block(YES);
//            [weakself.navigationController popToRootViewControllerAnimated:YES];
        }else{
            ceshi(YES);
        }
    });
}
- (void)saveAccounts{
   
    if (self.account==nil) {
        return;
    }
    NSInteger count = self.accounts.count;
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    if (count!=0) {
        arrayM = [self.accounts mutableCopy];
    }
    NSInteger k=0;
    if (count==0) {
        if (self.shouldSavepass) {
            NSDictionary *dict = @{@"name":self.account.text,@"pass":self.password.text};
            [arrayM addObject:dict];
        }else{
            NSDictionary *dict = @{@"name":self.account.text,@"pass":@""};
            [arrayM addObject:dict];
        }
    }
    for (NSInteger index = 0; index < count; index ++) {
        NSDictionary *dict = arrayM[index];
        NSString *str = dict[@"name"];
        if (![str isEqualToString:str]) {
            k+=1;
        }else{
            [arrayM removeObjectAtIndex:index];
            if (self.shouldSavepass) {
                NSDictionary *dict = @{@"name":self.account.text,@"pass":self.password.text};
                [arrayM addObject:dict];
            }else{
                NSDictionary *dict = @{@"name":self.account.text,@"pass":@""};
                [arrayM addObject:dict];
            }

        }
        if (k==count) {
            
            if (self.shouldSavepass) {
                NSDictionary *dict = @{@"name":self.account.text,@"pass":self.password.text};
                [arrayM addObject:dict];
            }else{
                NSDictionary *dict = @{@"name":self.account.text,@"pass":@""};
                [arrayM addObject:dict];
            }
        }
    }
    [[NSUserDefaults standardUserDefaults]setObject:arrayM forKey:@"accounts"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)tip:(NSString *)str{

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"知道了" style:0 handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [alertVC addAction:yes];
        [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.account resignFirstResponder];
    [self.password resignFirstResponder];
}
- (IBAction)saveOrno:(id)sender {
    self.shouldSavepass = !self.shouldSavepass;
    if (self.shouldSavepass) {
        self.saveBtn.selected  = YES;
    }else{
        self.saveBtn.selected = NO;
    }
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
