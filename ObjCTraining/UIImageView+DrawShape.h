//
//  UIImageView+DrawShape.h
//  ObjCTraining
//
//  Created by Sunny on 01/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DrawShape)
+ (void)drawCircleOnImageView:(UIImageView*)imageView withColor:(UIColor*)color lineWidth:(CGFloat)lineWidth;
@end
