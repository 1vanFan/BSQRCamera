//
//  BSQRCodeGenerator.m
//  BSQRCodeDemo
//
//  Created by 1vanFan on 17/1/20.
//  Copyright © 2017年 1vanFan. All rights reserved.
//

#import "BSQRCodeGenerator.h"

@implementation BSQRCodeGenerator

- (NSArray *)getFeatureInQRImage:(UIImage *)qrImage
{
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *image = [[CIImage alloc] initWithImage:qrImage];
    NSArray *features = [detector featuresInImage:image];
    
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:0];
    for (CIQRCodeFeature *feature in features) {
        [resultArr addObject: feature.messageString];
    }
    return [NSArray arrayWithArray:resultArr];
}

- (UIImage *)generateQRCodeMessage:(NSString *)message size:(CGSize)imageSize
{
   return [self generateQRCodeMessage:message size:imageSize inputCorrectionLevel:InputCorrectionLevel_M];
}

- (UIImage *)generateQRCodeMessage:(NSString *)message size:(CGSize)imageSize inputCorrectionLevel:(InputCorrectionLevel)level
{
    if ([self isBlankString:message]) {
        return nil;
    }
    
    //官方建议使用NSISOLatin1StringEncoding来编码，但对中文或表情无法生成
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    //生成二维码
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    NSArray *qualityArray = @[@"L",@"M",@"Q",@"H"];
    [filter setValue:qualityArray[level] forKey:@"inputCorrectionLevel"];
    CIImage *outputImage = filter.outputImage;
    //放大
    CGFloat aspect = imageSize.width / outputImage.extent.size.width;
    CGAffineTransform transform = CGAffineTransformMakeScale(aspect, aspect);
    CIImage *transformImage = [outputImage imageByApplyingTransform:transform];
    // 保存
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:transformImage fromRect:transformImage.extent];
    UIImage *qrImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return qrImage;
}

- (BOOL)isBlankString:(NSString *)str
{
    BOOL ret = NO;
    if ((str == nil)|| (str == NULL) || ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) || [str isKindOfClass:[NSNull class]])
        ret = YES;
    return ret;
}

@end


