//
//  UIImage+DrawShape.h
//  ObjCTraining
//
//  Created by WeezLabs on 18/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DrawShape)
+ (UIImage*)imageByDrawingCircleOfRadius:(CGFloat)radius color:(UIColor*)color lineWidth:(CGFloat)lineWidth;
@end
