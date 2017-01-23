//
//  MaskView.m
//  BSQRCodeDemo
//
//  Created by 1vanFan on 17/1/23.
//  Copyright © 2017年 1vanFan. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, rect);
    CGContextSetRGBStrokeColor(context, 23.0/255, 135.0/255, 253.0/255, 1.0);
    CGContextFillPath(context);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
