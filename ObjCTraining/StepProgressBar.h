//
//  StepProgressBar.h
//  ObjCTraining
//
//  Created by Sunny on 31/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepProgressBar : UIView
@property (nonatomic, assign) NSInteger numberOfSteps;
@property (nonatomic, assign) NSInteger currentStep;

- (void)setCurrentStep:(NSInteger)currentStep of:(NSInteger)numberOfSteps;
@end
