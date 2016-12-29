//
//  DetailCell.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  jioayiModel;
@class DetailCell;
#import "NomalCell.h"
//@protocol jiaoyiDelegete <NSObject>
//
//- (void)NomalCell:(DetailCell *)cell withjiaoyiModel:(jioayiModel *)model;
//
//@end
@interface DetailCell : UITableViewCell
@property (nonatomic, strong) jioayiModel *model;
@property (nonatomic, weak) id <jiaoyiDelegete> delegate ;
+ (instancetype) cellWith:(UITableView *)tableview;
@end
