//
//  SXTakePhotoView.h
//  Cameral
//
//  Created by zsx on 2018/9/16.
//  Copyright © 2018年 zsx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHPhotoPickerModel;
@interface SXTakePhotoView : UIView
@property(nonatomic,strong)NSMutableArray<NHPhotoPickerModel *> *photoArr;
@property(nonatomic,strong)void(^deletePhotoBlock)();
@end
