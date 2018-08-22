//
//  ChangeNamePopView.h
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OwnTextView.h"

@interface ChangeNamePopView : UIView

@property (strong,nonatomic) CustomeStyleCornerButt *cancelButt;

@property (strong,nonatomic) CustomeStyleCornerButt *commitButt;

@property (strong,nonatomic) OwnTextView *commentTextView;



@end
