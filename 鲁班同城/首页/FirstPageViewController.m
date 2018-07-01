//
//  FirstPageViewController.m
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "FirstPageViewController.h"

@interface FirstPageViewController ()

@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *navImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navLogo"]];
    self.navigationItem.titleView = navImageView;
    
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
