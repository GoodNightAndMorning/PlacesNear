//
//  NHPhotosPickerCollectionViewCell.m
//  NearbyHot
//
//  Created by zsx on 2018/9/15.
//  Copyright © 2018年 Me. All rights reserved.
//

#import "NHPhotosPickerCollectionViewCell.h"
#import "NHPhotoPickerModel.h"
@interface NHPhotosPickerCollectionViewCell()
@property(nonatomic,strong)UIImageView *photoImageView;
@property(nonatomic,strong)UIButton *selectBtn;
@end

@implementation NHPhotosPickerCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.photoImageView];
        [self.contentView addSubview:self.selectBtn];
    }
    return self;
}
-(void)setPhotoModel:(NHPhotoPickerModel *)photoModel{
    _photoModel = photoModel;
    
    self.photoImageView.image = photoModel.image;
    self.selectBtn.selected = photoModel.isSelect;
    
    self.selectBtn.hidden = photoModel.isCamera;
}

-(UIImageView *)photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 16)/3, ([UIScreen mainScreen].bounds.size.width - 16)/3);
        _photoImageView.backgroundColor = [UIColor orangeColor];
    }
    return _photoImageView;
}
-(UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"selectIcon_red"] forState:UIControlStateSelected];
        [_selectBtn setImage:[UIImage imageNamed:@"nselectIcon_white"] forState:UIControlStateNormal];
        _selectBtn.frame = CGRectMake(CGRectGetMaxX(self.photoImageView.frame) - 20, 0, 20, 20);
    }
    return _selectBtn;
}
@end
