//
//  GuanwangViewController.m
//  BTC-Kline
//
//  Created by BF on 2016/12/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//https://www.china-statestreet.com/single.php?bsort=490&sort=501
//https://kefu.qycn.com/vclient/chat/?m=m&websiteid=79979&visitorid=853796491&opctwdTime=1482981674&sessionid=visitor-1482981668&originPageTitle=美国道富集团外汇黄金白银交易平台%7C道富黄金外汇平台...&originPageLocationUrl=https%3A%2F%2Fwww.china-statestreet.com%2F&addCloseBtn=1

#import "GuanwangViewController.h"
#define urls @"https://kefu.qycn.com/vclient/chat/?m=m&websiteid=79979&visitorid=853796491&opctwdTime=1482981674&sessionid=visitor-1482981668&originPageLocationUrl=https%3A%2F%2Fwww.china-statestreet.com%2F&addCloseBtn=1"
#import "Glob.h"
@interface GuanwangViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation GuanwangViewController

- (void)viewDidLoad {
    self.webView = [[UIWebView alloc]init];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.webView];
    self.title = @"道富集团";
    [self addrightitem];
    self.webView.frame = CGRectMake(0, -38, Width, Height+38);
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:urls];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.delegate = self;
}

- (void)addrightitem{
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"phone"] style:0 target:self action:@selector(call)];
    self.navigationItem.rightBarButtonItems = @[rightitem];
}
- (void)call{
    // 提示拨打方法1：
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", @"4001830877"];
//    UIWebView * callWebview = [[UIWebView alloc] init];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    [self.view addSubview:callWebview];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"拨打客服电话" message:@"400 183 0877" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *acton = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4001830877"]]];
    }];
    UIAlertAction *actonCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:acton];
    [alertVC addAction:actonCancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertController *alertVC = [UIAlertController  alertControllerWithTitle:@"" message: @"连接在线客服失败"preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertVC animated:YES completion:^{
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
