//
//  SDWeiXinPhotoContainerView.m
//  SDAutoLayout 测试 Demo
//
//  Created by gsd on 15/12/23.
//  Copyright © 2015年 gsd. All rights reserved.
//


/*
 
 *********************************************************************************
 *
 * GSD_WeiXin
 *
 * QQ交流群: 459274049
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios/GSD_WeiXin
 * 新浪微博:GSD_iOS
 *
 * 此“高仿微信”用到了很高效方便的自动布局库SDAutoLayout（一行代码搞定自动布局）
 * SDAutoLayout地址：https://github.com/gsdios/SDAutoLayout
 * SDAutoLayout视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * SDAutoLayout用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 *
 *********************************************************************************
 
 */

#import "SDWeiXinPhotoContainerView.h"

#import "UIView+SDAutoLayout.h"

#import "SDPhotoBrowser.h"

@interface SDWeiXinPhotoContainerView () <SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation SDWeiXinPhotoContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}


- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{
    _picPathStringsArray = picPathStringsArray;
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.height_sd = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
    CGFloat itemH = 0;
//    if (_picPathStringsArray.count == 1) {
//        UIImage *image = [UIImage imageNamed:_picPathStringsArray.firstObject];
//        if (image.size.width) {
//            itemH = image.size.height / image.size.width * itemW;
//        }
//    } else {
        itemH = itemW;
    //}
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
    CGFloat margin = 5;
    for(int idx = 0; idx < _picPathStringsArray.count; idx ++){
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.backgroundColor = IMAGEVIEW_DEFAULT_COLOR;
        imageView.hidden = NO;
        NSURL *imageUrl = _picPathStringsArray[idx];
        //[imageView setImage:[UIImage imageNamed:@"test02"]];
        [imageView sd_setImageWithURL:imageUrl];
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width_sd = w;
    self.height_sd = h;
    
    self.fixedHeight = @(h);
    self.fixedWidth = @(w);
}
#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    NSLog(@"点击图片%ld",imageView.tag);
    if (self.isVideoUse){
        if (self.clickVideoBlock){
            self.clickVideoBlock(imageView.tag);
        }
    }else{
        SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
        browser.currentImageIndex = imageView.tag;
        browser.sourceImagesContainerView = self;
        browser.imageCount = self.picPathStringsArray.count;
        browser.delegate = self;
        [browser show];
    }
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    return  IMAGE_VIEW_HEIGHT;
//    if (array.count == 1) {
        //return 70;
//    } else {
//        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
//        return w;
//    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
//    if (array.count < 3) {
//        return array.count;
//    } else if (array.count <= 4) {
//        return 2;
//    } else {
        return 3;
    //}
}


#pragma mark - SDPhotoBrowserDelegate

//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
////    NSString *imageName = self.picPathStringsArray[index];
//    //NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
//    NSURL *url = self.picPathStringsArray[index];
//    return url;
//}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}
//lzh
- (void)displayCommentPictureWhenInVisual{
    for(NSInteger i = 0; i < _picPathStringsArray.count; i ++){
        UIImageView *singleImageView = self.imageViewsArray[i];
        [singleImageView setImage:[UIImage imageNamed:@"test02"]];
       // [singleImageView sd_setImageWithURL:[NSURL URLWithString:_picPathStringsArray[i]]];
    }
}
- (void)removeCommentPictureWhenOutVisuabel{
    for(NSInteger i = 0; i < _picPathStringsArray.count; i ++){
        UIImageView *singleImageView = self.imageViewsArray[i];
        [singleImageView setImage:nil];
    }
}
//
@end
