//
//  BaseDisplayNaviViewController.m
//  鲁班同城
//
//  Created by apple on 2018/7/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "BaseDisplayNaviViewController.h"

@interface BaseDisplayNaviViewController ()

@end

@implementation BaseDisplayNaviViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self displayNavigation];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)displayNavigation{
    if (self.navigationController.navigationBarHidden){
        [self.navigationController setNavigationBarHidden:NO];
    }
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
