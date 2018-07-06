//
//  LoginViewController.h
//  鲁班同城
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface LoginViewController : UIViewController

@property (copy,nonatomic) void (^wxOrQQBackBlock)(BOOL isWx);

@end
