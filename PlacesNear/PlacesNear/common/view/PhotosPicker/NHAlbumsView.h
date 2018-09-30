//
//  NHAlbumsView.h
//  NearbyHot
//
//  Created by zsx on 2018/9/15.
//  Copyright © 2018年 Me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface NHAlbumsView : UIView

@property(nonatomic,strong)NSArray<PHAssetCollection *>* collectionArr;
@property(nonatomic,copy)void(^selectAlbumBlock)(int index);
@end
