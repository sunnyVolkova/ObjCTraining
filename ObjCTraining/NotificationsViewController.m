//
//  NotificationsViewController.m
//  ObjCTraining
//
//  Created by Sunny on 31/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "NotificationsViewController.h"

static const int initialCurrentStep = 2;
static const int initialNumberofSteps = 4;

@implementation NotificationsViewController
//controller to test StepProgressbar and SteppedSlider
- (void)viewDidLoad {
    [super viewDidLoad];
    self.stepperCurrentStep.value = initialCurrentStep;
    self.stepperNumberOfSteps.value = initialNumberofSteps;
    NSString *text = [NSString stringWithFormat:@"%.0f", self.stepperNumberOfSteps.value];
    self.labelNumberOfSteps.text = text;
    NSString *text1 = [NSString stringWithFormat:@"%.0f", self.stepperCurrentStep.value];
    self.labelCurrentStep.text = text1;
    self.progressBar.numberOfSteps = initialNumberofSteps;
    self.progressBar.currentStep = initialCurrentStep;
    
    NSNumberFormatter *currentValueFormatter = [[NSNumberFormatter alloc] init];
    [currentValueFormatter setPositiveFormat:@"$##,###"];
    self.steppedSlider.currentValueFormatter = currentValueFormatter;
    
    NSNumberFormatter *scaleFormatter = [[NSNumberFormatter alloc] init];
    [scaleFormatter setMultiplier:[NSNumber numberWithDouble:0.001]];
    [scaleFormatter setPositiveFormat:@"#,###0"];
    self.steppedSlider.scaleFormatter = scaleFormatter;
}

- (IBAction)numberOfStepsValueChanged:(UIStepper *)sender {
    NSString *text = [NSString stringWithFormat:@"%.0f", sender.value];
    self.labelNumberOfSteps.text = text;
    self.progressBar.numberOfSteps = sender.value;
}

- (IBAction)currentStepValueChanged:(UIStepper *)sender {
    NSString *text = [NSString stringWithFormat:@"%.0f", sender.value];
    self.labelCurrentStep.text = text;
    self.progressBar.currentStep = sender.value;
}
@end
