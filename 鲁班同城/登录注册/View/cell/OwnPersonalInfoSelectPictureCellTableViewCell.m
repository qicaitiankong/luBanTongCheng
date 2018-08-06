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
        for (int k = 0; k < 6; k ++){
            PersonalInfoAddPhotoFlagView *singleView = [[PersonalInfoAddPhotoFlagView alloc]initWithFrame:CGRectMake(0, 0, imageViewWidth, imageViewWidth)];
            singleView.selectedAddPhotoBlock = ^(UIImageView *imageView) {
                if (weakSelf.addPictureBlock){
                    weakSelf.addPictureBlock(weakSelf.path);
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
        //如果有选中了照片
                if (model.selectedImageArr.count){
                    int i = 0;
                    
                    for (PersonalInfoAddPhotoFlagView *singleView in self.imageViewArr){
                        if (i < model.selectedImageArr.count + 1){
                            singleView.hidden = NO;
                            if (model.selectedImageArr.count > i){
                                [singleView.imageView setImage:model.selectedImageArr[i]];
                                }
                               singleView.sd_resetLayout
                                .leftSpaceToView(self.contentView, imageLeftBeginSpace + (imageViewWidth + imageCenterSpace)* (i % 3))
                                .topSpaceToView(self.contentView, 15 + (imageViewWidth + imageCenterSpace) * (i / 3))
                                .widthIs(imageViewWidth)
                                .heightEqualToWidth();
                            [singleView adjustConstraintsWhenNeed];
                                botView = singleView;
                            }else{
                                singleView.hidden = YES;
                            }
                            i ++;
                        
                    }
                    //添加完图片不再支持点击
                    for (int m = 0; m < self.imageViewArr.count; m ++){
                        PersonalInfoAddPhotoFlagView *localView = self.imageViewArr[m];
                        if (m == model.selectedImageArr.count){
                            localView.userInteractionEnabled = YES;
                        }else{
                            localView.userInteractionEnabled = NO;;
                        }
                    }
                }else{//刚开始没有选择图片应该显示一个
                        int k = 0;
                        for (PersonalInfoAddPhotoFlagView *singleView in self.imageViewArr){
                            if (k < 1){
                                singleView.hidden = NO;
                                singleView.userInteractionEnabled = YES; singleView.sd_resetLayout
                                .leftSpaceToView(self.contentView, imageLeftBeginSpace + (imageViewWidth + imageCenterSpace)* (k % 3))
                                .topSpaceToView(self.contentView, 15 + (imageViewWidth + imageCenterSpace) * (k / 3))
                                .widthIs(imageViewWidth)
                                .heightEqualToWidth();
                                [singleView adjustConstraintsWhenNeed];
                                botView = singleView;
                            }else{
                                singleView.hidden = YES;
                            }
                            k ++;
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
