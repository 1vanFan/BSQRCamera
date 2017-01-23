//
//  BSQRCamera.m
//  BSQRCodeDemo
//
//  Created by 1vanFan on 17/1/23.
//  Copyright © 2017年 1vanFan. All rights reserved.
//

#import "BSQRCamera.h"

@implementation BSQRCamera

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self sessionInit];
    }
    return self;
}

- (void)sessionInit
{
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession setSessionPreset:AVCaptureSessionPreset1280x720];
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if ([_captureSession canAddInput:input]) {
        [_captureSession addInput:input];
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    //    dispatch_queue_t outputQueue;
    //    outputQueue = dispatch_queue_create("outputQueue", DISPATCH_QUEUE_SERIAL);
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if ([_captureSession canAddOutput:_output]) {
        [_captureSession addOutput:_output];
        [_output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    }
    
    _previewLayer   = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_previewLayer setFrame:self.bounds];
    [self.layer insertSublayer:_previewLayer atIndex:0];
}

- (void)createScaningArea:(CGRect)rect
{
    [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock: ^(NSNotification *_Nonnull note) {
        _output.rectOfInterest = [_previewLayer metadataOutputRectOfInterestForRect:rect];
    }];
//
//    CGSize size = self.bounds.size;
//    CGRect cropRect = rect;
//    CGFloat p1 = size.height/size.width;
//#warning 此处根据所需的session分辨率自己调整
//    CGFloat p2 = 1280/720;
//    if (p1 < p2) {
//        CGFloat fixHeight = self.bounds.size.width * p2;
//        CGFloat fixPadding = (fixHeight - size.height)/2;
//        _output.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
//                                            cropRect.origin.x/size.width,
//                                            cropRect.size.height/fixHeight,
//                                            cropRect.size.width/size.width);
//    } else {
//        CGFloat fixWidth = self.bounds.size.height / p2;
//        CGFloat fixPadding = (fixWidth - size.width)/2;
//        _output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
//                                            (cropRect.origin.x + fixPadding)/fixWidth,
//                                            cropRect.size.height/size.height,
//                                            cropRect.size.width/fixWidth);
//    }
}

#pragma mark - metadata delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects !=nil && metadataObjects.count) {
        AVMetadataMachineReadableCodeObject *objc = [metadataObjects firstObject];
        
        if ([objc.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self stopCamera];
            if (self.CallBackBlock) {
                self.CallBackBlock(objc.stringValue);
            }
        }
    }
}

#pragma mark - action

- (void)startCamera
{
    if (self.captureSession) {
        [self.captureSession startRunning];
    }
}

- (void)stopCamera
{
    if (self.captureSession) {
        [self.captureSession stopRunning];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
