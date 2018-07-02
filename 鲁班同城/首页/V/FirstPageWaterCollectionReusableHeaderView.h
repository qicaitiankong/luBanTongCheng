//
//  FirstPageWaterCollectionReusableHeaderView.h
//  鲁班同城
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstPageSearchInputView.h"
#import "CXCarouselView.h"
#import "ZHQScrollMenu.h"
#import "TraingleCategoryButtonGroupView.h"

@interface FirstPageWaterCollectionReusableHeaderView : UICollectionReusableView<CXCarouseViewDelegate,categoryButtonClickDelegate>

@property (strong,nonatomic) FirstPageSearchInputView *searchView;

@property (strong,nonatomic) TraingleCategoryButtonGroupView *traingleButtonGroupView;

- (void)addConstraints;

@end
