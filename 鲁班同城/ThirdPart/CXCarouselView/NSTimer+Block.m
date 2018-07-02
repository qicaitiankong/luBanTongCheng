//
//  NSTimer+Block.m
//  CXCarouselView
//
//  Created by wcxdell on 16/9/5.
//  Copyright © 2016年 王长旭. All rights reserved.
//

#import "NSTimer+Block.h"

@implementation NSTimer (Block)
+ (NSTimer*) cx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)(void))block
                            repeats:(BOOL)repeats{
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+(void)blockInvoke:(NSTimer*)timer {
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}
@end
