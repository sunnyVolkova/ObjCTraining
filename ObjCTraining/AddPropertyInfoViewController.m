//
//  AddPropertyInfoViewController.m
//  ObjCTraining
//
//  Created by RWuser on 25/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "AddPropertyInfoViewController.h"
@interface AddPropertyInfoViewController()
@property UIView *activeField;
@end

@implementation AddPropertyInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    self.address1TextField.delegate = self;
    self.address2TextField.delegate = self;
    self.cityTextField.delegate = self;
    self.stateTextField.delegate = self;
    self.zipTextField.delegate = self;
    self.countryTextField.delegate = self;
    [self registerForKeyboardNotifications];
    [self.address1TextField becomeFirstResponder];
}


#pragma mark - Keyboard interaction
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect windowRect = self.view.window.frame;
    CGFloat windowHeight = windowRect.size.height;
    CGFloat insetChange = self.scrollView.contentSize.height - windowHeight + kbSize.height;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, insetChange, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    aRect.size.height += self.navigationController.navigationBar.frame.size.height;

    if (self.activeField != nil && !CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


#pragma mark - Actions
- (IBAction)textFieldDidBeginEditing:(UITextField *)sender {
    self.activeField = sender;
}

- (IBAction)testFieldDidEndEditing:(UITextField *)sender {
    self.activeField = nil;
}

#pragma mark - UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}
@end
