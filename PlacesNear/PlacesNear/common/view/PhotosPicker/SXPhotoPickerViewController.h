//
//  SXPhotoPickerViewController.h
//  NearbyHot
//
//  Created by zsx on 2018/9/15.
//  Copyright © 2018年 Me. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHPhotoPickerModel;
@interface SXPhotoPickerViewController : UIViewController
@property(nonatomic,copy)void(^finishSelectPhotoBlock)(NSMutableArray<UIImage *> *arr);

-(instancetype)initWithNum:(int)num;
@end
