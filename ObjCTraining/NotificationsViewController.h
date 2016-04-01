//
//  NotificationsViewController.h
//  ObjCTraining
//
//  Created by Sunny on 31/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepProgressBar.h"

@interface NotificationsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIStepper *stepperNumberOfSteps;
@property (weak, nonatomic) IBOutlet UIStepper *stepperCurrentStep;
@property (weak, nonatomic) IBOutlet UILabel *labelNumberOfSteps;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentStep;
@property (weak, nonatomic) IBOutlet StepProgressBar *progressBar;
@end
