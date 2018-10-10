//
//  NHHasSelectPhotoCollectionViewCell.m
//  NearbyHot
//
//  Created by zsx on 2018/9/15.
//  Copyright © 2018年 Me. All rights reserved.
//

#import "NHHasSelectPhotoCollectionViewCell.h"

#import "NHPhotoPickerModel.h"
@interface NHHasSelectPhotoCollectionViewCell()
@property(nonatomic,strong)UIImageView *photoImageView;
@property(nonatomic,strong)UIButton *selectBtn;
@end

@implementation NHHasSelectPhotoCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.photoImageView];
        [self.contentView addSubview:self.selectBtn];
    }
    return self;
}
-(void)deletePhotoActon{
    if (self.deletePhotoBlock) {
        self.deletePhotoBlock();
    }
}
-(void)setPhotoModel:(NHPhotoPickerModel *)photoModel{
    _photoModel = photoModel;
    
    self.photoImageView.image = photoModel.image;
}

-(UIImageView *)photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 20) / 4, ([UIScreen mainScreen].bounds.size.width - 20) / 4);
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.layer.masksToBounds = YES;
        _photoImageView.backgroundColor = [UIColor orangeColor];
    }
    return _photoImageView;
}
-(UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"删除1"] forState:UIControlStateNormal];
        _selectBtn.frame = CGRectMake(CGRectGetMaxX(self.photoImageView.frame) - 20, 0, 20, 20);
        [_selectBtn addTarget:self action:@selector(deletePhotoActon) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
@end

