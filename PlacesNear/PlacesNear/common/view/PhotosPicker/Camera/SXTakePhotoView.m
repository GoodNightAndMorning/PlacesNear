//
//  SXTakePhotoView.m
//  Cameral
//
//  Created by zsx on 2018/9/16.
//  Copyright © 2018年 zsx. All rights reserved.
//

#import "SXTakePhotoView.h"

#import "NHHasSelectPhotoCollectionViewCell.h"
#import "NHPhotoPickerModel.h"
@interface SXTakePhotoView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *mainCollectionView;
@end
static NSString * const NHHasSelectPhotoCollectionViewCellIdentifier = @"NHHasSelectPhotoCollectionViewCell";
@implementation SXTakePhotoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
    }
    return self;
}
-(void)layoutSubviews{
    [self addSubview:self.mainCollectionView];
}
-(void)setPhotoArr:(NSMutableArray<NHPhotoPickerModel *> *)photoArr{
    _photoArr = photoArr;
    [self.mainCollectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NHHasSelectPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NHHasSelectPhotoCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.photoModel = self.photoArr[indexPath.item];
    cell.deletePhotoBlock = ^{
        [self.photoArr removeObjectAtIndex:indexPath.item];
        [self.mainCollectionView reloadData];
        if (self.deletePhotoBlock) {
            self.deletePhotoBlock();
        }
    };
    return cell;
}
-(UICollectionView *)mainCollectionView{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((self.frame.size.width - 25) / 4, (self.frame.size.width - 25) / 4);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.frame.size.width - 25) / 4+10) collectionViewLayout:layout];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        [_mainCollectionView registerClass:[NHHasSelectPhotoCollectionViewCell class] forCellWithReuseIdentifier:NHHasSelectPhotoCollectionViewCellIdentifier];
    }
    return _mainCollectionView;
}

@end

