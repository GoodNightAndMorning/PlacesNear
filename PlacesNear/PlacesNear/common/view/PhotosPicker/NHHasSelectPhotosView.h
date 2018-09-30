//
//  NHHasSelectPhotosView.h
//  NearbyHot
//
//  Created by zsx on 2018/9/15.
//  Copyright © 2018年 Me. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHPhotoPickerModel;
@interface NHHasSelectPhotosView : UIView
@property(nonatomic,strong)NSMutableArray<NHPhotoPickerModel *> *photoArr;
@property(nonatomic,strong)void(^deletePhotoBlock)(int index);
@property(nonatomic,copy)void(^finishSelectPhotoBlock)();
@property(nonatomic,assign)int hasSelectedNum;
@end
