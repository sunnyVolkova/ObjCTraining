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
//controller to test StepProgressbar
- (void)viewDidLoad {
    [super viewDidLoad];
    self.stepperCurrentStep.value = initialCurrentStep;
    self.stepperNumberOfSteps.value = initialNumberofSteps;
    NSString *text = [NSString stringWithFormat:@"%.0f", self.stepperNumberOfSteps.value];
    self.labelNumberOfSteps.text = text;
    NSString *text1 = [NSString stringWithFormat:@"%.0f", self.stepperCurrentStep.value];
    self.labelCurrentStep.text = text1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.progressBar setCurrentStep:initialCurrentStep of:initialNumberofSteps];
}
- (IBAction)numberOfStepsValueChanged:(UIStepper *)sender {
    NSString *text = [NSString stringWithFormat:@"%.0f", sender.value];
    self.labelNumberOfSteps.text = text;
    [self.progressBar setNumberOfSteps:sender.value];
}

- (IBAction)currentStepValueChanged:(UIStepper *)sender {
    NSString *text = [NSString stringWithFormat:@"%.0f", sender.value];
    self.labelCurrentStep.text = text;
    [self.progressBar setCurrentStep:sender.value];
}
@end