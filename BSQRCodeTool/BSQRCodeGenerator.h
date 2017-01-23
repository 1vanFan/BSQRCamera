//
//  BSQRCodeGenerator.h
//  BSQRCodeDemo
//
//  Created by 1vanFan on 17/1/20.
//  Copyright © 2017年 1vanFan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * 用于设置二维码容错率级别
 * 默认为 InputCorrectionLevel_M
 * QR码有容错能力，QR码图形如果有破损，仍然可以被机器读取内容，最高可以到7%~30%面积破损仍可被读取。容错率愈高，QR码图形面积愈大。所以一般折衷使用15%容错能力。
 * 容错能力 L 7%, M 15%, Q 25%, H 30%
 */
typedef NS_ENUM(NSInteger, InputCorrectionLevel) {
    InputCorrectionLevel_L,
    InputCorrectionLevel_M,
    InputCorrectionLevel_Q,
    InputCorrectionLevel_H
};

@interface BSQRCodeGenerator : NSObject

/**
 获取二维码中的信息
 */
- (NSArray *)getFeatureInQRImage:(UIImage *)qrImage;

/**
 二维码生成 默认容错率15%
 */
- (UIImage*)generateQRCodeMessage:(NSString *)message size:(CGSize)imageSize;

/**
 二维码生成
 @param level 容错率
 */
- (UIImage *)generateQRCodeMessage:(NSString *)message size:(CGSize)imageSize inputCorrectionLevel:(InputCorrectionLevel)level;
@end
