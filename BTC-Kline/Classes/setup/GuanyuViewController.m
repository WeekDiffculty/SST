//
//  GuanyuViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/18.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "GuanyuViewController.h"
#import "XieyiViewController.h"
@interface GuanyuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *worning;

@end

@implementation GuanyuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.worning.numberOfLines = 8;
    self.worning.adjustsFontSizeToFitWidth = YES;
    self.worning.textColor = [UIColor blackColor];
    self.worning.text = @"风险警告(Risk warning)：\nSTATE STREET(道富集团)获得英国金融市场行为监管局（FCA）授权及监管，注册牌照号：186237 和新西兰金融市场管理局（FMA）监管的FSP注册，注册牌照号：507834 从事外汇和差价合约等金融产品的杠杆交易具有高风险，损失有可能超过本金，请量力而行，入市前需充分了解潜在的风险。交易杠杆化产品并不适合所有投资者。在交易前请考虑您的经验水平 、投资目标，如有必要请寻求独立财务建议。您有责任确保您所在的国家/地区允许您使用STATE STREET提供的服务。请阅读STATE STREET道富风险披露全文。";
}
- (IBAction)xieyi:(UIButton *)sender {
    XieyiViewController *xieyiVC = [[XieyiViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:xieyiVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
