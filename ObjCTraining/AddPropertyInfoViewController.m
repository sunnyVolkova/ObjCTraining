//
//  AddPropertyInfoViewController.m
//  ObjCTraining
//
//  Created by RWuser on 25/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "AddPropertyInfoViewController.h"
#import "ValidationManager.h"

typedef NS_ENUM( NSInteger, InputFieldsEnum) {
    Address1FieldTag = 1,
    Address2FieldTag,
    CityFieldTag,
    StateFieldTag,
    ZipFieldTag,
    CountryFieldTag
};

@interface AddPropertyInfoViewController()
@property UIView *activeField;
@end

@implementation AddPropertyInfoViewController
BOOL isFieldEmpty = NO;
NSString * emptyFieldErrorMessage = @"Please Enter Full Address";
NSString * wrongFieldErrorMessage = @"Please Enter Correct Address";

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
    isFieldsEmpty[[NSNumber numberWithInt:Address1FieldTag]] = @YES;
    isFieldsEmpty[[NSNumber numberWithInt:Address2FieldTag]] = @YES;
    isFieldsEmpty[[NSNumber numberWithInt:CityFieldTag]] = @YES;
    isFieldsEmpty[[NSNumber numberWithInt:StateFieldTag]] = @YES;
    isFieldsEmpty[[NSNumber numberWithInt:ZipFieldTag]] = @YES;
    isFieldsEmpty[[NSNumber numberWithInt:CountryFieldTag]] = @YES;

    isFieldsWrong = [[NSMutableDictionary alloc] init];
    isFieldsWrong[[NSNumber numberWithInt:Address1FieldTag]] = @NO;
    isFieldsWrong[[NSNumber numberWithInt:Address2FieldTag]] = @NO;
    isFieldsWrong[[NSNumber numberWithInt:CityFieldTag]] = @NO;
    isFieldsWrong[[NSNumber numberWithInt:StateFieldTag]] = @NO;
    isFieldsWrong[[NSNumber numberWithInt:ZipFieldTag]] = @NO;
    isFieldsWrong[[NSNumber numberWithInt:CountryFieldTag]] = @NO;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
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
            isCorrect = [self isAddress1Correct: sender.text];
            [self updateField: self.address1TextField textLabel: self.address1Title isCorrect: isCorrect];
            break;
        case Address2FieldTag:
            isCorrect = [self isAddress2Correct: sender.text];
            [self updateField: self.address2TextField textLabel: self.address2Title isCorrect: isCorrect];
            break;
        case CityFieldTag:
            isCorrect = [self isCityCorrect: sender.text];
            [self updateField: self.cityTextField textLabel: self.cityTitle isCorrect: isCorrect];
            break;
        case StateFieldTag:
            isCorrect = [self isStateCorrect: sender.text];
            [self updateField: self.stateTextField textLabel: self.stateTitle isCorrect: isCorrect];
            break;
        case ZipFieldTag:
            isCorrect = [self isZipCorrect: sender.text];
            [self updateField: self.zipTextField textLabel: self.zipTitle isCorrect: isCorrect];
            break;
        case CountryFieldTag:
            isCorrect = [self isCountryCorrect: sender.text];
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
- (BOOL) isAnyFieldEmpty {
    for (id key in isFieldsEmpty){
        //Address2Field could be empty
        if([[isFieldsEmpty objectForKey:key] boolValue] && [key integerValue] != Address2FieldTag){
            return YES;
        }
    }
    return NO;
}

- (BOOL) isAnyFieldWrong {
    for (id key in isFieldsWrong){
        if([[isFieldsWrong objectForKey:key] boolValue]){
            return YES;
        }
    }
    return NO;
}

- (BOOL) checkInputData {
    BOOL isFieldEmpty = [self isAnyFieldEmpty];
    BOOL isFieldWrong = [self isAnyFieldWrong];
    
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
    BOOL isFieldEmpty = [self isAnyFieldEmpty];
    BOOL isFieldWrong = [self isAnyFieldWrong];
    
    if (isFieldEmpty) {
        return emptyFieldErrorMessage;
    } else if (isFieldWrong) {
        return wrongFieldErrorMessage;
    }
    return @"";
}

- (BOOL) isAddress1Correct:(NSString *)address1
{
    BOOL isEmpty = (address1 == nil || address1.length == 0);
    [isFieldsEmpty setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:Address1FieldTag]];
    BOOL isValid = [ValidationManager isAddressValid:address1];
    [isFieldsWrong setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:Address1FieldTag]];
    return !isEmpty && isValid;
}

- (BOOL) isAddress2Correct:(NSString *)address2
{
    BOOL isEmpty = (address2 == nil || address2.length == 0);
    [isFieldsEmpty setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:Address2FieldTag]];
    if (!isEmpty) {
        BOOL isValid = [ValidationManager isAddressValid:address2];
        [isFieldsWrong setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:Address2FieldTag]];
    } else {
        [isFieldsWrong setObject: @NO forKey:[NSNumber numberWithInt:Address2FieldTag]];
    }
    return YES; //address 2 field could be empty
}

- (BOOL) isCityCorrect:(NSString *)city
{
    BOOL isEmpty = (city == nil || city.length == 0);
    [isFieldsEmpty setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:CityFieldTag]];
    BOOL isValid = [ValidationManager isCityValid:city];
    [isFieldsWrong setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:CityFieldTag]];
    return !isEmpty && isValid;
}

- (BOOL) isStateCorrect:(NSString *)state
{
    BOOL isEmpty = (state == nil || state.length == 0);
    [isFieldsEmpty setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:StateFieldTag]];
    BOOL isValid = [ValidationManager isStateValid:state];
    [isFieldsWrong setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:StateFieldTag]];
    return !isEmpty && isValid;
}

- (BOOL) isZipCorrect:(NSString *)zip
{
    BOOL isEmpty = (zip == nil || zip.length == 0);
    [isFieldsEmpty setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:ZipFieldTag]];
    BOOL isValid = [ValidationManager isZipValid:zip];
    [isFieldsWrong setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:ZipFieldTag]];
    return !isEmpty && isValid;
}

- (BOOL) isCountryCorrect:(NSString *)country
{
    BOOL isEmpty = (country == nil || country.length == 0);
    [isFieldsEmpty setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:CountryFieldTag]];
    BOOL isValid = [ValidationManager isCountryValid:country];
    [isFieldsWrong setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:CountryFieldTag]];
    return !isEmpty && isValid;
}

@end
