//
//  CommentModel.m
//  鲁班同城
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+ (CommentModel*)setModelFromDict:(NSDictionary*)dict{
    CommentModel *localModel = [[CommentModel alloc]init];
    if (localModel){
        localModel.userImageUrlStr = @"";
        localModel.nameStr = @"手机用户1234";
        localModel.praiseStr = @"123";
        localModel.commentContentStr = @"评论内容就在这里评论内容就在这里评论内容就在这里评论内容就在这里评论内容就在这里";
        localModel.timeStr = @"07-02 16:30";
        localModel.answerNumStr = @"23回复";
    }
    return localModel;
}



@end
