//
//  StepProgressBar.h
//  ObjCTraining
//
//  Created by Sunny on 31/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepProgressBar : UIView
@property int numberOfSteps;
@property int currentStep;

- (int) numberOfSteps;
- (void)setNumberOfSteps:(int)numberOfSteps;
- (int) currentStep;
- (void)setCurrentStep:(int)currentStep;
- (void)setCurrentStep:(int)currentStep of:(int)numberOfSteps;
@end
