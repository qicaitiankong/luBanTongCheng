//
//  BaseCustomeTableViewController.h
//  鲁班同城
//
//  Created by apple on 2018/7/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCustomeTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;

- (void)addTableView:(CGRect)size style:(UITableViewStyle)styles;


@end
