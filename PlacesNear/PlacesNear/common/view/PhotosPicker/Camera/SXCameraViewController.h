//
//  SXCameraViewController.h
//  Cameral
//
//  Created by zsx on 2018/9/16.
//  Copyright © 2018年 zsx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHPhotoPickerModel;
@interface SXCameraViewController : UIViewController
@property(nonatomic,assign)int hasSelectedNum;
@property(nonatomic,copy)void(^takePhotosBlock)(NSMutableArray<NHPhotoPickerModel *> *arr);
@end
