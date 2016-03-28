//
//  AddPropertyInfoViewController.h
//  ObjCTraining
//
//  Created by RWuser on 25/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AddPropertyInfoViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ErrorMessageHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *address1Title;
@property (weak, nonatomic) IBOutlet UITextField *address1TextField;
@property (weak, nonatomic) IBOutlet UILabel *address2Title;
@property (weak, nonatomic) IBOutlet UITextField *address2TextField;
@property (weak, nonatomic) IBOutlet UILabel *cityTitle;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UILabel *stateTitle;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UILabel *zipTitle;
@property (weak, nonatomic) IBOutlet UITextField *zipTextField;
@property (weak, nonatomic) IBOutlet UILabel *countryTitle;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *errorMessage;
@property (weak, nonatomic) IBOutlet UIButton *buttonContinue;

@end
