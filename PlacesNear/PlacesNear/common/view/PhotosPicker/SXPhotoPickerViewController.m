//
//  SXPhotoPickerViewController.m
//  NearbyHot
//
//  Created by zsx on 2018/9/15.
//  Copyright © 2018年 Me. All rights reserved.
//

#import "SXPhotoPickerViewController.h"
#import <Photos/Photos.h>
#import "NHPhotosPickerCollectionViewCell.h"
#import "NHPhotoPickerModel.h"
#import "NHAlbumsView.h"
#import "NHHasSelectPhotosView.h"
#import "SXCameraViewController.h"
@interface SXPhotoPickerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *mainCollectionView;

@property(nonatomic,strong)NSMutableArray<PHAssetCollection *> *collectionArr;

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UIImageView *topIcon;

@property(nonatomic,strong)NHAlbumsView *albumsView;
@property(nonatomic,strong)NHHasSelectPhotosView *selectPhotoView;

@property(nonatomic,strong)PHAssetCollection *currentCollection;

@property(nonatomic,strong)NSMutableArray<NSMutableArray<NHPhotoPickerModel *> *>* allDataArr;

@property(nonatomic,strong)NSMutableArray<NHPhotoPickerModel *> *dataArr;

@property(nonatomic,strong)NSMutableArray<NHPhotoPickerModel *> *selectPhotoArr;

@property(nonatomic,assign)int hasSelectedNum;
@end

static NSString * const NHPhotosPickerCollectionViewCellIdentifier = @"NHPhotosPickerCollectionViewCell";

@implementation SXPhotoPickerViewController
-(instancetype)initWithNum:(int)num{
    if (self = [super init]) {
        self.hasSelectedNum = num;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavi];
    
    [self.view addSubview:self.mainCollectionView];
    
    [self.view addSubview:self.selectPhotoView];
    
    __weak typeof(self)weakSelf = self;
    self.albumsView.selectAlbumBlock = ^(int index) {
        weakSelf.currentCollection = weakSelf.collectionArr[index];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if (self.allDataArr[index].count == 0) {
//                [weakSelf getAllAlbums];
                weakSelf.dataArr = [weakSelf getPhotosFromAlbum];
                weakSelf.allDataArr[index] = weakSelf.dataArr;
            }else{
                weakSelf.dataArr = weakSelf.allDataArr[index];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTopViewData];
                [weakSelf.mainCollectionView reloadData];
                [weakSelf openAlbumsListAction];
            });
        });
    };
    self.selectPhotoView.deletePhotoBlock = ^(int index) {
        weakSelf.selectPhotoArr[index].isSelect = NO;
        [weakSelf.selectPhotoArr removeObjectAtIndex:index];
        [weakSelf.mainCollectionView reloadData];
        weakSelf.selectPhotoView.photoArr = weakSelf.selectPhotoArr;
    };
    self.selectPhotoView.finishSelectPhotoBlock = ^{
        if (weakSelf.finishSelectPhotoBlock) {
            
            NSMutableArray<UIImage *> *arr = [[NSMutableArray<UIImage *> alloc] init];
            for (int i = 0; i < weakSelf.selectPhotoArr.count; i++) {
                [arr addObject:weakSelf.selectPhotoArr[i].image];
            }
            
            weakSelf.finishSelectPhotoBlock(arr);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getAllAlbums];
        self.dataArr = [self getPhotosFromAlbum];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.allDataArr = [[NSMutableArray<NSMutableArray<NHPhotoPickerModel *> *> alloc] init];
            
            for (int i = 0; i < self.collectionArr.count; i++) {
                NSMutableArray<NHPhotoPickerModel *> *arr = [[NSMutableArray<NHPhotoPickerModel *> alloc] init];
                [self.allDataArr addObject:arr];
            }
            
            self.allDataArr[0] = self.dataArr;
            
            self.navigationItem.titleView = self.topView;
            [self setTopViewData];
            [self.mainCollectionView reloadData];
            self.albumsView.collectionArr = self.collectionArr;
        });
    });
}
//-(void)setHasSelectedNum:(int)hasSelectedNum{
//    _hasSelectedNum = hasSelectedNum;
//    self.selectPhotoView.hasSelectedNum = self.hasSelectedNum;
//}
-(void)openAlbumsListAction{
    if (self.albumsView.frame.origin.y < 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.albumsView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
        self.topIcon.image = [UIImage imageNamed:@"上啦拉-箭头-拷贝"];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.albumsView.frame = CGRectMake(0, - self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
        self.topIcon.image = [UIImage imageNamed:@"下拉-箭头"];
    }
}
-(void)setTopViewData{
    if (self.currentCollection) {
        self.titleLb.text = self.currentCollection.localizedTitle;
    }else{
        self.titleLb.text = @"相册";
    }
    
    CGFloat w = [self.titleLb.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLb.font} context:nil].size.width;
    
    self.titleLb.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 100 - w - self.topIcon.frame.size.width - 5) / 2, 0, w, 44);
    self.topIcon.frame = CGRectMake(CGRectGetMaxX(self.titleLb.frame)+5, (44 - 7)/2, 10, 7);
}
- (void)getAllAlbums{
    // 所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        PHCollection *collection = smartAlbums[i];
        //遍历获取相册
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        
            if (assetCollection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                
            }
            if (fetchResult.count != 0) {
                [self.collectionArr addObject:assetCollection];
            }
        }
    }
    if (self.collectionArr.count > 0) {
        self.currentCollection = self.collectionArr.firstObject;
    }
}
-(NSMutableArray *)getPhotosFromAlbum{
    NSMutableArray *arr = [NSMutableArray array];
    
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:self.currentCollection options:nil];
    PHAsset *asset = nil;
    if (fetchResult.count != 0) {
        for (NSInteger j = 0; j < fetchResult.count; j++) {
            //从相册中取出照片
            asset = fetchResult[j];
            PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
            opt.synchronous = YES;
            PHImageManager *imageManager = [[PHImageManager alloc] init];
            [imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                if (result) {
                    NHPhotoPickerModel *model = [[NHPhotoPickerModel alloc] init];
                    model.image = result;
                    model.isSelect = NO;
                    [arr addObject:model];
                }
            }];
        }
    }
    
    if (arr.count < 3) {
        NHPhotoPickerModel *model = [[NHPhotoPickerModel alloc] init];
        model.image = [UIImage imageNamed:@"相机2"];
        model.isSelect = NO;
        model.isCamera = YES;
        [arr addObject:model];
    }else{
        NHPhotoPickerModel *model = [[NHPhotoPickerModel alloc] init];
        model.image = [UIImage imageNamed:@"相机2"];
        model.isSelect = NO;
        model.isCamera = YES;
        [arr insertObject:model atIndex:2];
    }
    
    //返回所有照片
    return arr;
}

-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)initNavi{
    UIImage *leftImage = [UIImage imageNamed:@"backIcon_black"];
    leftImage = [leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NHPhotosPickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NHPhotosPickerCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.photoModel = self.dataArr[indexPath.item];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr[indexPath.item].isCamera) {
        //打开相机
        SXCameraViewController *vc = [[SXCameraViewController alloc] init];
        vc.hasSelectedNum = (int)self.selectPhotoArr.count + self.hasSelectedNum;
        vc.takePhotosBlock = ^(NSMutableArray<NHPhotoPickerModel *> *arr) {
            [self.selectPhotoArr addObjectsFromArray:arr];
            self.selectPhotoView.photoArr = self.selectPhotoArr;
        };
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        //控制最大为9张照片
        if (self.selectPhotoArr.count >= 9 - self.hasSelectedNum && !self.dataArr[indexPath.item].isSelect) {
            return;
        }
        
        self.dataArr[indexPath.item].isSelect = !self.dataArr[indexPath.item].isSelect;
        
        if (self.dataArr[indexPath.item].isSelect) {
            [self.selectPhotoArr addObject:self.dataArr[indexPath.item]];
        }else{
            [self.selectPhotoArr removeObject:self.dataArr[indexPath.item]];
        }
        self.selectPhotoView.photoArr = self.selectPhotoArr;
        [self.mainCollectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UICollectionView *)mainCollectionView{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((self.view.frame.size.width - 16) / 3, (self.view.frame.size.width - 16) / 3);
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 8;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - (self.view.frame.size.width - 20) / 4-10) collectionViewLayout:layout];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        [_mainCollectionView registerClass:[NHPhotosPickerCollectionViewCell class] forCellWithReuseIdentifier:NHPhotosPickerCollectionViewCellIdentifier];
    }
    return _mainCollectionView;
}
-(NSMutableArray<NHPhotoPickerModel *> *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray<NHPhotoPickerModel *> alloc] init];
    }
    return _dataArr;
}
-(NSMutableArray<PHAssetCollection *> *)collectionArr{
    if (!_collectionArr) {
        _collectionArr = [[NSMutableArray<PHAssetCollection *> alloc] init];
    }
    return _collectionArr;
}

-(UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, self.view.frame.size.width - (self.view.frame.size.width - 20) / 4, 44)];
    }
    [_topView addSubview:self.titleLb];
    [_topView addSubview:self.topIcon];
    _topView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openAlbumsListAction)];
    [_topView addGestureRecognizer:tap];
    return _topView;
}
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        _titleLb.font = [UIFont systemFontOfSize:18];
        _titleLb.textColor = [UIColor whiteColor];
    }
    return _titleLb;
}
-(UIImageView *)topIcon{
    if (!_topIcon) {
        _topIcon = [[UIImageView alloc] init];
        _topIcon.image = [UIImage imageNamed:@"下拉-箭头"];
        _topIcon.frame = CGRectMake(0, 0, 10, 7);
    }
    return _topIcon;
}
-(NHAlbumsView *)albumsView{
    if (!_albumsView) {
        _albumsView = [[NHAlbumsView alloc] initWithFrame:CGRectMake(0, -self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        [self.view addSubview:_albumsView];
    }
    return _albumsView;
}
-(NHHasSelectPhotosView *)selectPhotoView{
    if (!_selectPhotoView) {
        _selectPhotoView = [[NHHasSelectPhotosView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - (self.view.frame.size.width - 20) / 4 - 10, self.view.frame.size.width, (self.view.frame.size.width - 20) / 4+10)];
        _selectPhotoView.hasSelectedNum = self.hasSelectedNum;
    }
    return _selectPhotoView;
}
-(NSMutableArray<NHPhotoPickerModel *>*)selectPhotoArr{
    if (!_selectPhotoArr) {
        _selectPhotoArr = [[NSMutableArray<NHPhotoPickerModel *> alloc] init];
    }
    return _selectPhotoArr;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
