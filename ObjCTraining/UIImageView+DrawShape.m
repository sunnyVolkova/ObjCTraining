//
//  UIImageView+DrawShape.m
//  ObjCTraining
//
//  Created by Sunny on 01/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "UIImageView+DrawShape.h"

@implementation UIImageView (DrawShape)

+ (void)drawCircleOnImageView:(UIImageView*)imageView withColor:(UIColor*)color lineWidth:(CGFloat)lineWidth {
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    CGFloat width = [imageView bounds].size.width;
    CGFloat height = [imageView bounds].size.height;
    
    [circleLayer setBounds:CGRectMake(0.0f, 0.0f, width, height)];
    [circleLayer setPosition:CGPointMake(width/2.0f + lineWidth, height/2.0f + lineWidth)];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:
                          CGRectMake(0.0f, 0.0f, width - 2*lineWidth, height - 2*lineWidth)];
    [circleLayer setPath:[path CGPath]];
    [circleLayer setStrokeColor:[color CGColor]];
    [circleLayer setLineWidth:lineWidth];
    [circleLayer setFillColor:[[UIColor whiteColor] CGColor]];
    [[imageView layer] addSublayer:circleLayer];
}

@end
