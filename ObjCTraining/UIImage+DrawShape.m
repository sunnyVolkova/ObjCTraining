//
//  UIImage+DrawShape.m
//  ObjCTraining
//
//  Created by WeezLabs on 18/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "UIImage+DrawShape.h"

@implementation UIImage (DrawShape)
+ (UIImage*)imageByDrawingCircleOfRadius:(CGFloat)radius color:(UIColor*)color lineWidth:(CGFloat)lineWidth {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(radius, radius), false, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    CGRect circleRect = CGRectMake(lineWidth, lineWidth, radius - 2 * lineWidth, radius - 2 * lineWidth);
    CGContextStrokeEllipseInRect(context, circleRect);
    CGContextRestoreGState(context);
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return retImage;
}
@end
