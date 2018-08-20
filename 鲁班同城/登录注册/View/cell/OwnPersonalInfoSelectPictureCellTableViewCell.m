//
//  OwnPersonalInfoSelectPictureCellTableViewCell.m
//  鲁班同城
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "OwnPersonalInfoSelectPictureCellTableViewCell.h"
#import "PersonalInfoAddPhotoFlagView.h"

@interface OwnPersonalInfoSelectPictureCellTableViewCell (){
    CGFloat imageViewWidth;
    CGFloat imageLeftBeginSpace;
    CGFloat imageCenterSpace;

}

@property (strong,nonatomic) NSMutableArray *imageViewArr;

@end


@implementation OwnPersonalInfoSelectPictureCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        imageLeftBeginSpace = 15;
        imageCenterSpace = 5;
        imageViewWidth = (SCREEN_WIDTH - imageLeftBeginSpace * 2 - imageCenterSpace * 2) / 3;
        WS(weakSelf);
        //在此改变循环大小可以改变可选张数
        for (int k = 0; k < 6; k ++){
            PersonalInfoAddPhotoFlagView *singleView = [[PersonalInfoAddPhotoFlagView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
            singleView.selectedAddPhotoBlock = ^(UIImageView *imageView) {
                if (weakSelf.addPictureBlock){
                    weakSelf.addPictureBlock(self.path, k);
                }
            };
            singleView.hidden = YES;
            [self.contentView addSubview:singleView];
            [self.imageViewArr addObject:singleView];
        }
    }
    return self;
}

//
- (void)setModel:(OwnPersonalInfoChoosePictureModel*)model{
    _model = model;
    if (model){
        UIView *botView = nil;
        //将全部影藏
         for (PersonalInfoAddPhotoFlagView *singleView in self.imageViewArr){
             singleView.hidden = YES;
             singleView.addImageView.hidden = YES;
             [singleView.imageView setImage:[UIImage imageNamed:@"nullWhite"]];
         }
        if (model.selectedImageArr.count == 0){
                    int i = 0;
                    for (PersonalInfoAddPhotoFlagView *singleView in self.imageViewArr){
                        if (i > 0){
                            singleView.hidden = YES;
                        }else{
                            singleView.hidden = NO;
                            singleView.addImageView.hidden = NO;
                             botView = singleView;
                        }
                        singleView.sd_resetLayout
                        .leftSpaceToView(self.contentView, imageLeftBeginSpace + (imageViewWidth + imageCenterSpace)* (i % 3))
                        .topSpaceToView(self.contentView, 15 + (imageViewWidth + imageCenterSpace) * (i / 3))
                        .widthIs(imageViewWidth)
                            .heightEqualToWidth();
                        [singleView adjustConstraintsWhenNeed];
                        i ++;
                       
                    }
        }else{
                    if (model.selectedImageArr.count < self.imageViewArr.count){
                        for (int k = 0; k < model.selectedImageArr.count; k ++){
                           PersonalInfoAddPhotoFlagView *singleView = self.imageViewArr[k];
                            singleView.hidden = NO;
                        singleView.addImageView.hidden = YES;
                            [singleView.imageView setImage:model.selectedImageArr[k]];
                            singleView.sd_resetLayout
                            .leftSpaceToView(self.contentView, imageLeftBeginSpace + (imageViewWidth + imageCenterSpace)* (k % 3))
                            .topSpaceToView(self.contentView, 15 + (imageViewWidth + imageCenterSpace) * (k / 3))
                            .widthIs(imageViewWidth)
                            .heightEqualToWidth();
                            [singleView adjustConstraintsWhenNeed];
                           
                        }
                        PersonalInfoAddPhotoFlagView *singleView = self.imageViewArr[model.selectedImageArr.count];
                        singleView.hidden = NO;                        singleView.addImageView.hidden = NO;
                        singleView.addImageView.hidden = NO;
                        botView = singleView;
                    }else{//当选择的图片为imageview arr count个时
                        int m = 0;
                        for (PersonalInfoAddPhotoFlagView *singleView in self.imageViewArr){
                            singleView.hidden = NO;
                            singleView.addImageView.hidden = YES;
                            [singleView.imageView setImage:model.selectedImageArr[m]];
                            //
                            singleView.sd_resetLayout
                            .leftSpaceToView(self.contentView, imageLeftBeginSpace + (imageViewWidth + imageCenterSpace)* (m % 3))
                            .topSpaceToView(self.contentView, 15 + (imageViewWidth + imageCenterSpace) * (m / 3))
                            .widthIs(imageViewWidth)
                            .heightEqualToWidth();
                            
                            m ++;
                            botView = singleView;
                        }
                    }
        }
        
        [self setupAutoHeightWithBottomView:botView bottomMargin:10];
    }
}



//lazy load
- (NSMutableArray*)imageViewArr{
    if (_imageViewArr == nil){
        _imageViewArr = [NSMutableArray array];
    }
    return _imageViewArr;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
