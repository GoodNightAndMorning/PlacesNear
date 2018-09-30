//
//  SXCameraViewController.m
//  Cameral
//
//  Created by zsx on 2018/9/16.
//  Copyright © 2018年 zsx. All rights reserved.
//

#import "SXCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SXTakePhotoView.h"
#import "NHPhotoPickerModel.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SXCameraViewController ()

//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property (nonatomic, strong) AVCaptureDevice *device;

//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic, strong) AVCaptureDeviceInput *input;

//输出图片
@property (nonatomic ,strong) AVCaptureStillImageOutput *imageOutput;

//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *session;

//图像预览层，实时显示捕获的图像
@property (nonatomic ,strong) AVCaptureVideoPreviewLayer *previewLayer;

@property(nonatomic, strong)SXTakePhotoView *photoView;

@property(nonatomic, strong)NSMutableArray<NHPhotoPickerModel *> *photoArr;


@property(nonatomic,strong)UIButton *takeBtn;

@end

@implementation SXCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self cameraDistrict];
    
    [self initUi];
}
- (void)cameraDistrict
{
    
    //    AVCaptureDevicePositionBack  后置摄像头
    //    AVCaptureDevicePositionFront 前置摄像头
    self.device = [self cameraWithPosition:AVCaptureDevicePositionBack];
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    
    self.session = [[AVCaptureSession alloc] init];
    //     拿到的图像的大小可以自行设定
    //    AVCaptureSessionPreset320x240
    //    AVCaptureSessionPreset352x288
    //    AVCaptureSessionPreset640x480
    //    AVCaptureSessionPreset960x540
    //    AVCaptureSessionPreset1280x720
    //    AVCaptureSessionPreset1920x1080
    //    AVCaptureSessionPreset3840x2160
    self.session.sessionPreset = AVCaptureSessionPreset640x480;
    //输入输出设备结合
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.imageOutput]) {
        [self.session addOutput:self.imageOutput];
    }
    //预览层的生成
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 3 / 2);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    //设备取景开始
    [self.session startRunning];
    if ([_device lockForConfiguration:nil]) {
        //自动闪光灯，
        if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [_device setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡,但是好像一直都进不去
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [_device unlockForConfiguration];
    }
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}
- (void)photoBtnDidClick
{
    AVCaptureConnection *conntion = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!conntion) {
        NSLog(@"拍照失败!");
        return;
    }
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:imageData];
//        [self.session stopRunning];
        
        NHPhotoPickerModel *photoModel = [[NHPhotoPickerModel alloc] init];
        photoModel.image = image;
        
        [self.photoArr addObject:photoModel];
        
        self.photoView.hidden = (self.photoArr.count == 0);
        
        self.photoView.photoArr = self.photoArr;
        
        [self.takeBtn setTitle:[NSString stringWithFormat:@"%d",self.hasSelectedNum + (int)self.photoArr.count] forState:UIControlStateNormal];
        
        [self saveImageToPhotoAlbum:image];
        
    }];
}
#pragma - 保存至相册
- (void)saveImageToPhotoAlbum:(UIImage*)savedImage
{
    
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}
// 指定回调方法

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
//    NSString *msg = nil ;
//    if(error != NULL){
//        msg = @"保存图片失败" ;
//    }else{
//        msg = @"保存图片成功" ;
//    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
//                                                    message:msg
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
}
- (void)changeCamera{
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        //给摄像头的切换添加翻转动画
        CATransition *animation = [CATransition animation];
        animation.duration = .5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"oglFlip";
        
        AVCaptureDevice *newCamera = nil;
        AVCaptureDeviceInput *newInput = nil;
        //拿到另外一个摄像头位置
        AVCaptureDevicePosition position = [[_input device] position];
        if (position == AVCaptureDevicePositionFront){
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            animation.subtype = kCATransitionFromLeft;//动画翻转方向
        }
        else {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            animation.subtype = kCATransitionFromRight;//动画翻转方向
        }
        //生成新的输入
        newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
        [self.previewLayer addAnimation:animation forKey:nil];
        if (newInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.input];
            if ([self.session canAddInput:newInput]) {
                [self.session addInput:newInput];
                self.input = newInput;
                
            } else {
                [self.session addInput:self.input];
            }
            [self.session commitConfiguration];
            
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}
-(void)closeAction{
    if (self.takePhotosBlock) {
        self.takePhotosBlock(self.photoArr);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)exchangeCameraAction{
    [self changeCamera];
}
-(void)takePhotoAction{
    if (self.photoArr.count + self.hasSelectedNum >= 9) {
        return;
    }
    [self photoBtnDidClick];
}
-(void)setHasSelectedNum:(int)hasSelectedNum{
    _hasSelectedNum = hasSelectedNum;
    
    [self.takeBtn setTitle:[NSString stringWithFormat:@"%d",hasSelectedNum] forState:UIControlStateNormal];
}
-(void)initUi{
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"deleteIcon_white.png" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(10, 30, 44, 44);
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    UIButton *exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exchangeBtn setImage:[UIImage imageNamed:@"exchangeCameraIcon.png" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    exchangeBtn.frame = CGRectMake(SCREEN_WIDTH - 44 - 10, 30, 44, 44);
    [exchangeBtn addTarget:self action:@selector(exchangeCameraAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exchangeBtn];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    bottomView.frame = CGRectMake(0, SCREEN_WIDTH * 3 / 2, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_WIDTH * 3 / 2);
    [self.view addSubview:bottomView];
    
    self.takeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.takeBtn setTitle:[NSString stringWithFormat:@"%d",self.hasSelectedNum] forState:UIControlStateNormal];
    self.takeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.takeBtn setBackgroundImage:[UIImage imageNamed:@"cameraBtnIcon.png" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
//    [takeBtn setImage:[UIImage imageNamed:@"cameraBtnIcon.png" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    self.takeBtn.frame = CGRectMake((SCREEN_WIDTH - 80)/2, (bottomView.frame.size.height - 80)/2, 80, 80);
    [self.takeBtn addTarget:self action:@selector(takePhotoAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.takeBtn];
}

-(SXTakePhotoView *)photoView{
    if (!_photoView) {
        _photoView = [[SXTakePhotoView alloc] init];
        _photoView.frame = CGRectMake(0, SCREEN_WIDTH * 3 / 2 - ((SCREEN_WIDTH - 25) / 4 + 10), SCREEN_WIDTH, ((SCREEN_WIDTH - 25) / 4+10));
        [self.view addSubview:_photoView];
        _photoView.hidden = YES;
        __weak typeof(self)weakSelf = self;
        _photoView.deletePhotoBlock = ^{
            [weakSelf.takeBtn setTitle:[NSString stringWithFormat:@"%d",weakSelf.hasSelectedNum + (int)weakSelf.photoArr.count] forState:UIControlStateNormal];
            weakSelf.photoView.hidden = YES;
        };
        
    }
    return _photoView;
}
-(NSMutableArray<NHPhotoPickerModel *> *)photoArr{
    if (!_photoArr) {
        _photoArr = [[NSMutableArray<NHPhotoPickerModel *> alloc] init];
    }
    return _photoArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
