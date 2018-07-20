//
//  UISearchBar+CustomeStyle.m
//  鲁班同城
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UISearchBar+CustomeStyle.h"

@implementation UISearchBar (CustomeStyle)

+ (UISearchBar*)getFirstPageStyleSearchBar{
    UISearchBar *bar = [[UISearchBar alloc] init];
    bar.barTintColor = [UIColor whiteColor];
    bar.backgroundColor = [UIColor whiteColor];
    if([lzhGetAccountInfo getAccount].identityFlag){
        bar.placeholder = @"找零工上鲁班同城";

    }else{
        bar.placeholder = @"找工作上鲁班同城";
    }
    bar.searchBarStyle = UISearchBarStyleDefault;
    
    //去掉上下黑线
    bar.backgroundImage = [[UIImage alloc] init];
    //
    UITextField*searchField = [bar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor colorWithHexString:@"#7D7D7D"] forKeyPath:@"_placeholderLabel.textColor"];
     [searchField setValue:[UIFont getPingFangSCMedium:15] forKeyPath:@"_placeholderLabel.font"];
    return bar;
}


@end
