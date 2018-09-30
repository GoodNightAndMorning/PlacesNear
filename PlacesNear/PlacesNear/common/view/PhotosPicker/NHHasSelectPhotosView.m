//
//  NHHasSelectPhotosView.m
//  NearbyHot
//
//  Created by zsx on 2018/9/15.
//  Copyright © 2018年 Me. All rights reserved.
//

#import "NHHasSelectPhotosView.h"
#import "NHHasSelectPhotoCollectionViewCell.h"
#import "NHPhotoPickerModel.h"
@interface NHHasSelectPhotosView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *mainCollectionView;

@property(nonatomic,strong)UIButton *finishBtn;
@end
static NSString * const NHHasSelectPhotoCollectionViewCellIdentifier = @"NHHasSelectPhotoCollectionViewCell";
@implementation NHHasSelectPhotosView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
    }
    return self;
}
-(void)layoutSubviews{
    [self addSubview:self.mainCollectionView];
    [self addSubview:self.finishBtn];
}
-(void)finishAction{
    if (self.finishSelectPhotoBlock) {
        self.finishSelectPhotoBlock();
    }
}
-(void)setPhotoArr:(NSMutableArray<NHPhotoPickerModel *> *)photoArr{
    _photoArr = photoArr;
    [self.finishBtn setTitle:[NSString stringWithFormat:@"完成 %lu/9",(unsigned long)photoArr.count + self.hasSelectedNum] forState:UIControlStateNormal];
    [self.mainCollectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NHHasSelectPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NHHasSelectPhotoCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.photoModel = self.photoArr[indexPath.item];
    cell.deletePhotoBlock = ^{
        if (self.deletePhotoBlock) {
            self.deletePhotoBlock((int)indexPath.item);
        }
    };
    return cell;
}
-(UICollectionView *)mainCollectionView{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((self.frame.size.width - 20) / 4, (self.frame.size.width - 20) / 4);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - (self.frame.size.width - 20) / 4, (self.frame.size.width - 20) / 4+10) collectionViewLayout:layout];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        [_mainCollectionView registerClass:[NHHasSelectPhotoCollectionViewCell class] forCellWithReuseIdentifier:NHHasSelectPhotoCollectionViewCellIdentifier];
    }
    return _mainCollectionView;
}
-(UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishBtn.backgroundColor = [UIColor blackColor];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_finishBtn addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
        _finishBtn.frame = CGRectMake(self.frame.size.width - (self.frame.size.width - 20) / 4, 0, (self.frame.size.width - 20) / 4, (self.frame.size.width - 20) / 4 + 10);
        [_finishBtn setTitle:[NSString stringWithFormat:@"完成 %d/9", self.hasSelectedNum] forState:UIControlStateNormal];
    }
    return _finishBtn;
}
@end
