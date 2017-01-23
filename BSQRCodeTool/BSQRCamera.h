//
//  BSQRCamera.h
//  BSQRCodeDemo
//
//  Created by 1vanFan on 17/1/23.
//  Copyright © 2017年 1vanFan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BSQRCamera : UIView <AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, retain) AVCaptureSession *captureSession;
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, retain) AVCaptureMetadataOutput *output;
@property (nonatomic, copy) void(^CallBackBlock)(NSString *message);

/**
 创建扫描区域
 */
- (void)createScaningArea:(CGRect)rect;

- (void)startCamera;
- (void)stopCamera;
@end
