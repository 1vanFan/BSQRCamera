//
//  NSString+BSBlank.m
//  BSQRCodeTool
//
//  Created by 范宝珅 on 2017/8/3.
//  Copyright © 2017年 1vanFan. All rights reserved.
//

#import "NSString+BSBlank.h"

@implementation NSString (BSBlank)
- (BOOL)isNotBlank
{
    BOOL ret = YES;
    if ((self == nil)|| (self == NULL) || ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) || [self isKindOfClass:[NSNull class]]) ret = NO;
    return ret;
}
@end
