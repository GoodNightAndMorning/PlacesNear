//
//  NHAlbumsTableViewCell.m
//  NearbyHot
//
//  Created by zsx on 2018/9/15.
//  Copyright © 2018年 Me. All rights reserved.
//

#import "NHAlbumsTableViewCell.h"

@interface NHAlbumsTableViewCell()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UIImageView *allow;
@end

@implementation NHAlbumsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.allow];
    }
    return self;
}
-(void)setCollection:(PHAssetCollection *)collection{
    _collection = collection;
    
    self.titleLb.text = [NSString stringWithFormat:@"%@",collection.localizedTitle];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        PHAsset *asset = fetchResult.firstObject;
        PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
        opt.synchronous = YES;
        PHImageManager *imageManager = [[PHImageManager alloc] init];
        [imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.icon.image = result;
                    
                    self.titleLb.text = [NSString stringWithFormat:@"%@(%lu)",collection.localizedTitle,(unsigned long)fetchResult.count];
                });
            }
        }];
    });
    
}
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.frame = CGRectMake(10, 10, 80, 80);
    }
    return _icon;
}
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 100)];
        _titleLb.font = [UIFont systemFontOfSize:16];
        _titleLb.textColor = [UIColor blackColor];
    }
    return _titleLb;
}
-(UIImageView *)allow{
    if (!_allow) {
        _allow = [[UIImageView alloc] init];
        _allow.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 20, 41, 10, 18);
        _allow.image = [UIImage imageNamed:@"Person_Access.png" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    }
    return _allow;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
