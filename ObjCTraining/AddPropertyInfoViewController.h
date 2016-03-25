//
//  AddPropertyInfoViewController.h
//  ObjCTraining
//
//  Created by RWuser on 25/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPropertyInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ErrorMessageHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *address1Title;
@property (weak, nonatomic) IBOutlet UIView *address1TextField;
@property (weak, nonatomic) IBOutlet UIView *address2Title;
@property (weak, nonatomic) IBOutlet UIView *address2TextField;
@property (weak, nonatomic) IBOutlet UIView *cityTitle;
@property (weak, nonatomic) IBOutlet UIView *cityTextField;
@property (weak, nonatomic) IBOutlet UIView *stateTitle;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UIView *zipTitle;
@property (weak, nonatomic) IBOutlet UITextField *zipTextField;
@property (weak, nonatomic) IBOutlet UIView *countryTitle;
@property (weak, nonatomic) IBOutlet UIView *countryTextField;


@end
