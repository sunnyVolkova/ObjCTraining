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
    [self registerForKeyboardNotifications];
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
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}

- (id)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.view.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
    }
    return nil;
}

#pragma mark - Actions
- (IBAction)address1DidBeginEditing:(UITextField *)sender {
    _activeField = sender;
}

- (IBAction)address1DidEndEditing:(UITextField *)sender {
    _activeField = nil;
}

- (IBAction)address2DidBeginEditing:(UITextField *)sender {
    _activeField = sender;
    
}

- (IBAction)address2DidEndEditing:(UITextField *)sender {
    _activeField = nil;
}

- (IBAction)cityDidBeginEditing:(UITextField *)sender {
    _activeField = sender;
}

- (IBAction)cityDidEndEditing:(UITextField *)sender {
    _activeField = nil;
}

- (IBAction)stateDidBeginEditing:(UITextField *)sender {
    _activeField = sender;
}

- (IBAction)stateDidEndEditing:(UITextField *)sender {
    _activeField = nil;
}
- (IBAction)zipDidBeginEditing:(UITextField *)sender {
    _activeField = sender;
}

- (IBAction)zipDidEndEditing:(UITextField *)sender {
    _activeField = nil;
}

- (IBAction)countryDidBeginEditing:(UITextField *)sender {
    _activeField = sender;
}

- (IBAction)countryDidEndEditing:(UITextField *)sender {
    _activeField = nil;
}

@end
