//
//  NHPhotoPickerModel.h
//  NearbyHot
//
//  Created by zsx on 2018/9/15.
//  Copyright © 2018年 Me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHPhotoPickerModel : NSObject
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,assign)bool isSelect;
@property(nonatomic,assign)bool isCamera;
@end
