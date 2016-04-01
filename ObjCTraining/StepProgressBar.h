//
//  StepProgressBar.h
//  ObjCTraining
//
//  Created by Sunny on 31/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface StepProgressBar : UIView
@property (nonatomic, assign) IBInspectable NSInteger numberOfSteps;
@property (nonatomic, assign) IBInspectable NSInteger currentStep;
@property (nonatomic, assign) IBInspectable UIColor *activeColor;
@property (nonatomic, assign) IBInspectable UIColor *inactiveColor;
@end
