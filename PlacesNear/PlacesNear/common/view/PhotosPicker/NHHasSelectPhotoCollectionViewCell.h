//
//  NHHasSelectPhotoCollectionViewCell.h
//  NearbyHot
//
//  Created by zsx on 2018/9/15.
//  Copyright © 2018年 Me. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHPhotoPickerModel;
@interface NHHasSelectPhotoCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)NHPhotoPickerModel* photoModel;
@property(nonatomic,copy)void(^deletePhotoBlock)();
@end
