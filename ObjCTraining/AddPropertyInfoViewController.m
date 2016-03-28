//
//  AddPropertyInfoViewController.m
//  ObjCTraining
//
//  Created by RWuser on 25/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "AddPropertyInfoViewController.h"
@interface AddPropertyInfoViewController()
@property UIView *activeField;
@end

@implementation AddPropertyInfoViewController
BOOL isFieldEmpty = NO;
typedef NS_ENUM( NSInteger, InputFieldsEnum) {
    Address1FieldTag = 1,
    Address2FieldTag,
    CityFieldTag,
    StateFieldTag,
    ZipFieldTag,
    CountryFieldTag
};

NSMutableDictionary *isFieldsEmpty;
NSMutableDictionary *isFieldsWrong;

- (void)viewWillAppear:(BOOL)animated {
    self.address1TextField.delegate = self;
    self.address2TextField.delegate = self;
    self.cityTextField.delegate = self;
    self.stateTextField.delegate = self;
    self.zipTextField.delegate = self;
    self.countryTextField.delegate = self;
    [self registerForKeyboardNotifications];
    [self.address1TextField becomeFirstResponder];
    
    isFieldsEmpty = [[NSMutableDictionary alloc] init];
    isFieldsEmpty[[NSNumber numberWithInt:Address1FieldTag]] = @NO;
    isFieldsEmpty[[NSNumber numberWithInt:Address2FieldTag]] = @NO;
    isFieldsEmpty[[NSNumber numberWithInt:CityFieldTag]] = @NO;
    isFieldsEmpty[[NSNumber numberWithInt:StateFieldTag]] = @NO;
    isFieldsEmpty[[NSNumber numberWithInt:ZipFieldTag]] = @NO;
    isFieldsEmpty[[NSNumber numberWithInt:CountryFieldTag]] = @NO;

    isFieldsWrong = [[NSMutableDictionary alloc] init];
    isFieldsWrong[[NSNumber numberWithInt:Address1FieldTag]] = @NO;
    isFieldsWrong[[NSNumber numberWithInt:Address2FieldTag]] = @NO;
    isFieldsWrong[[NSNumber numberWithInt:CityFieldTag]] = @NO;
    isFieldsWrong[[NSNumber numberWithInt:StateFieldTag]] = @NO;
    isFieldsWrong[[NSNumber numberWithInt:ZipFieldTag]] = @NO;
    isFieldsWrong[[NSNumber numberWithInt:CountryFieldTag]] = @NO;
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
    switch (sender.tag) {
        case Address1FieldTag:
            [self updateField: self.address1TextField textLabel: self.address1Title isCorrect: YES];
            break;
        case Address2FieldTag:
            [self updateField: self.address2TextField textLabel: self.address2Title isCorrect: YES];
            break;
        case CityFieldTag:
            [self updateField: self.cityTextField textLabel: self.cityTitle isCorrect: YES];
            break;
        case StateFieldTag:
            [self updateField: self.stateTextField textLabel: self.stateTitle isCorrect: YES];
            break;
        case ZipFieldTag:
            [self updateField: self.zipTextField textLabel: self.zipTitle isCorrect: YES];
            break;
        case CountryFieldTag:
            [self updateField: self.countryTextField textLabel: self.countryTitle isCorrect: YES];
            break;
    }
}

- (IBAction)testFieldDidEndEditing:(UITextField *)sender {
    BOOL isCorrect = NO;
    self.activeField = nil;
    
    switch (sender.tag) {
        case Address1FieldTag:
            isCorrect = [self checkAddress1: sender.text];
            [self updateField: self.address1TextField textLabel: self.address1Title isCorrect: isCorrect];
            break;
        case Address2FieldTag:
            isCorrect = [self checkAddress2: sender.text];
            [self updateField: self.address2TextField textLabel: self.address2Title isCorrect: isCorrect];
            break;
        case CityFieldTag:
            isCorrect = [self checkCity: sender.text];
            [self updateField: self.cityTextField textLabel: self.cityTitle isCorrect: isCorrect];
            break;
        case StateFieldTag:
            isCorrect = [self checkState: sender.text];
            [self updateField: self.stateTextField textLabel: self.stateTitle isCorrect: isCorrect];
            break;
        case ZipFieldTag:
            isCorrect = [self checkZip: sender.text];
            [self updateField: self.zipTextField textLabel: self.zipTitle isCorrect: isCorrect];
            break;
        case CountryFieldTag:
            isCorrect = [self checkCountry: sender.text];
            [self updateField: self.countryTextField textLabel: self.countryTitle isCorrect: isCorrect];
            break;
    }
}

- (IBAction)buttonContinueTapped:(UIButton *)sender {
    if ([self checkInputData]){
        NSLog(@"GO NEXT");
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return NO;
}

#pragma mark - Validation
- (BOOL) checkInputData {
    BOOL isFieldEmpty = NO;
    for (id key in isFieldsEmpty){
        if([[isFieldsEmpty objectForKey:key]  isEqual: @YES]){
            isFieldEmpty = YES;
            break;
        }
    }
    
    BOOL isFieldWrong = NO;
    for (id key in isFieldsWrong){
        if([[isFieldsWrong objectForKey:key]  isEqual: @YES]){
            isFieldWrong = YES;
            break;
        }
    }
    
    if(isFieldEmpty || isFieldWrong) {
        self.errorMessage.hidden = false;
        self.errorMessage.text = [self creatErrorMessage];
        self.ErrorMessageHeightConstraint.constant = 21;
        return NO;
    } else {
        self.errorMessage.hidden = true;
        self.ErrorMessageHeightConstraint.constant = 0;
        return YES;
    }
}
- (void) updateField: (UITextField *)textField textLabel: (UILabel *)textLabel isCorrect: (BOOL) isCorrect {
    if (isCorrect) {
        textLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:129.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
        textField.layer.borderColor=[[UIColor clearColor]CGColor];
    } else {
        textLabel.textColor = [UIColor redColor];
        textField.layer.cornerRadius=5.0f;
        textField.layer.masksToBounds=YES;
        textField.layer.borderColor=[[UIColor redColor]CGColor];
        textField.layer.borderWidth= 1.0f;
    }
}

- (NSString *) creatErrorMessage {
    BOOL isFieldEmpty = NO;
    for (id key in isFieldsEmpty){
        if([isFieldsEmpty objectForKey:key]){
            isFieldEmpty = YES;
            break;
        }
    }
    
    BOOL isFieldWrong = NO;
    for (id key in isFieldsWrong){
        if([isFieldsWrong objectForKey:key]){
            isFieldWrong = YES;
            break;
        }
    }
    
    if (isFieldEmpty) {
        return @"Please Enter Full Address";
    } else if (isFieldWrong) {
        return @"Please Enter Correct Address";
    }
    return @"";
}

- (BOOL) checkAddress1:(NSString *)address1
{
    BOOL retValue = YES;
    if (address1.length == 0)
    {
        retValue = NO;
    }
    [isFieldsEmpty setObject: [NSNumber numberWithBool:!retValue] forKey:[NSNumber numberWithInt:Address1FieldTag]];
    return retValue;
   
}

- (BOOL) checkAddress2:(NSString *)address2
{
    BOOL retValue = YES;
    if(address2.length == 0){
        retValue = NO;
    }
    [isFieldsEmpty setObject: [NSNumber numberWithBool:!retValue] forKey:[NSNumber numberWithInt:Address2FieldTag]];
    return retValue;
}

- (BOOL) checkCity:(NSString *)city
{
    BOOL retValue = YES;
    if(city.length == 0){
        retValue = NO;
    }
    [isFieldsEmpty setObject: [NSNumber numberWithBool:!retValue] forKey:[NSNumber numberWithInt:CityFieldTag]];
    return retValue;
}

- (BOOL) checkState:(NSString *)state
{
    BOOL retValue = YES;
    if(state.length == 0){
        retValue = NO;
    }
    [isFieldsEmpty setObject: [NSNumber numberWithBool:!retValue] forKey:[NSNumber numberWithInt:StateFieldTag]];
    return retValue;
}

- (BOOL) checkZip:(NSString *)zip
{
    BOOL retValue = YES;
    if(zip.length == 0){
        retValue = NO;
    }
    [isFieldsEmpty setObject: [NSNumber numberWithBool:!retValue] forKey:[NSNumber numberWithInt:ZipFieldTag]];
    return retValue;
}

- (BOOL) checkCountry:(NSString *)country
{
    BOOL retValue = YES;
    if(country.length == 0){
        retValue = NO;
    }
    [isFieldsEmpty setObject: [NSNumber numberWithBool:!retValue] forKey:[NSNumber numberWithInt:CountryFieldTag]];
    return retValue;
}

@end
