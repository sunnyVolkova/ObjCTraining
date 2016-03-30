//
//  AddPropertyInfoViewController.m
//  ObjCTraining
//
//  Created by RWuser on 25/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "AddPropertyInfoViewController.h"
#import "NSString+CheckInput.h"

typedef NS_ENUM( NSInteger, InputFieldsEnum) {
    FirstAddressFieldTag = 1,
    SecondAddressFieldTag,
    CityFieldTag,
    StateFieldTag,
    ZipFieldTag,
    CountryFieldTag
};

typedef NS_ENUM( NSInteger, TextFieldStyleEnum) {
    correctFieldStyle = 1,
    wrongFieldStyle
};

@interface AddPropertyInfoViewController()
{
    NSMutableDictionary *fieldsEmptinessDictionary;
    NSMutableDictionary *fieldsCorrectnessDictionary;
}
@property UIView *activeField;
@end

static NSString * const emptyFieldErrorMessage = @"Please Enter Full Address";
static NSString * const wrongFieldErrorMessage = @"Please Enter Correct Address";

@implementation AddPropertyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstAddressTextField.delegate = self;
    self.secondAddressTextField.delegate = self;
    self.cityTextField.delegate = self;
    self.stateTextField.delegate = self;
    self.zipTextField.delegate = self;
    self.countryTextField.delegate = self;
    
    fieldsEmptinessDictionary = [[NSMutableDictionary alloc] init];
    fieldsEmptinessDictionary[[NSNumber numberWithInt:FirstAddressFieldTag]] = @YES;
    fieldsEmptinessDictionary[[NSNumber numberWithInt:SecondAddressFieldTag]] = @YES;
    fieldsEmptinessDictionary[[NSNumber numberWithInt:CityFieldTag]] = @YES;
    fieldsEmptinessDictionary[[NSNumber numberWithInt:StateFieldTag]] = @YES;
    fieldsEmptinessDictionary[[NSNumber numberWithInt:ZipFieldTag]] = @YES;
    fieldsEmptinessDictionary[[NSNumber numberWithInt:CountryFieldTag]] = @YES;
    
    fieldsCorrectnessDictionary = [[NSMutableDictionary alloc] init];
    fieldsCorrectnessDictionary[[NSNumber numberWithInt:FirstAddressFieldTag]] = @NO;
    fieldsCorrectnessDictionary[[NSNumber numberWithInt:SecondAddressFieldTag]] = @NO;
    fieldsCorrectnessDictionary[[NSNumber numberWithInt:CityFieldTag]] = @NO;
    fieldsCorrectnessDictionary[[NSNumber numberWithInt:StateFieldTag]] = @NO;
    fieldsCorrectnessDictionary[[NSNumber numberWithInt:ZipFieldTag]] = @NO;
    fieldsCorrectnessDictionary[[NSNumber numberWithInt:CountryFieldTag]] = @NO;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [self registerForKeyboardNotifications];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self deregisterForKeyboardNotifications];
}

#pragma mark - Keyboard interaction

- (void)dismissKeyboard {
    [self.activeField resignFirstResponder];
}

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


- (void)deregisterForKeyboardNotifications {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


#pragma mark - Actions

- (IBAction)textFieldDidBeginEditing:(UITextField *)sender {
    self.activeField = sender;
    [self clearErroMessage];
    switch (sender.tag) {
        case FirstAddressFieldTag:
            [self updateTextField: self.firstAddressTextField andLabel: self.firstAddressTitle withStyle: correctFieldStyle];
            break;
        case SecondAddressFieldTag:
            [self updateTextField: self.secondAddressTextField andLabel: self.secondAddressTitle withStyle: correctFieldStyle];
            break;
        case CityFieldTag:
            [self updateTextField: self.cityTextField andLabel: self.cityTitle withStyle: correctFieldStyle];
            break;
        case StateFieldTag:
            [self updateTextField: self.stateTextField andLabel: self.stateTitle withStyle: correctFieldStyle];
            break;
        case ZipFieldTag:
            [self updateTextField: self.zipTextField andLabel: self.zipTitle withStyle: correctFieldStyle];
            break;
        case CountryFieldTag:
            [self updateTextField: self.countryTextField andLabel: self.countryTitle withStyle: correctFieldStyle];
            break;
    }
}

- (IBAction)testFieldDidEndEditing:(UITextField *)sender {
    BOOL isCorrect = NO;
    self.activeField = nil;
    
    switch (sender.tag) {
        case FirstAddressFieldTag:
            isCorrect = [self checkFirstAddress: sender.text];
            break;
        case SecondAddressFieldTag:
            isCorrect = [self checkSecondAddress: sender.text];
            break;
        case CityFieldTag:
            isCorrect = [self checkCity: sender.text];
            break;
        case StateFieldTag:
            isCorrect = [self checkState: sender.text];
            break;
        case ZipFieldTag:
            isCorrect = [self checkZip: sender.text];
            break;
        case CountryFieldTag:
            isCorrect = [self checkCountry: sender.text];
            break;
    }
    [self invalidateFieldForTag: sender.tag isValid: isCorrect];
}

- (IBAction)buttonContinueTapped:(UIButton *)sender {
    if ([self checkInputData]){
        NSLog(@"GO NEXT");
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
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

- (BOOL)findIfAnyFieldEmpty {
    BOOL isAnyfieldEmpty = NO;
    for (NSNumber *key in fieldsEmptinessDictionary){
        //Address2Field could be empty
        if([[fieldsEmptinessDictionary objectForKey:key] boolValue] && [key integerValue] != SecondAddressFieldTag){
            [self invalidateFieldForTag:[key integerValue] isValid:NO];
            isAnyfieldEmpty = YES;
        }
    }
    return isAnyfieldEmpty;
}

- (BOOL)findIfAnyFieldWrong {
    for (NSNumber *key in fieldsCorrectnessDictionary){
        if([[fieldsCorrectnessDictionary objectForKey:key] boolValue]){
            return YES;
        }
    }
    return NO;
}

- (void)invalidateFieldForTag: (NSInteger) tag isValid: (BOOL) isValid {
    switch (tag) {
        case FirstAddressFieldTag:
            [self updateTextField: self.firstAddressTextField andLabel: self.firstAddressTitle withStyle: isValid ? correctFieldStyle : wrongFieldStyle];
            break;
        case SecondAddressFieldTag:
            [self updateTextField: self.secondAddressTextField andLabel: self.secondAddressTitle withStyle: isValid ? correctFieldStyle : wrongFieldStyle];
            break;
        case CityFieldTag:
            [self updateTextField: self.cityTextField andLabel: self.cityTitle withStyle: isValid ? correctFieldStyle : wrongFieldStyle];
            break;
        case StateFieldTag:
            [self updateTextField: self.stateTextField andLabel: self.stateTitle withStyle: isValid ? correctFieldStyle : wrongFieldStyle];
            break;
        case ZipFieldTag:
            [self updateTextField: self.zipTextField andLabel: self.zipTitle withStyle: isValid ? correctFieldStyle : wrongFieldStyle];
            break;
        case CountryFieldTag:
            [self updateTextField: self.countryTextField andLabel: self.countryTitle withStyle: isValid ? correctFieldStyle : wrongFieldStyle];
            break;
    }
}

- (BOOL)checkInputData {
    BOOL isFieldEmpty = [self findIfAnyFieldEmpty];
    BOOL isFieldWrong = [self findIfAnyFieldWrong];
    if(isFieldEmpty || isFieldWrong) {
        [self showErroMessage: [self creatErrorMessage: isFieldEmpty isAnyFieldWrong: isFieldWrong]];
        return NO;
    } else {
        [self clearErroMessage];
        return YES;
    }
}

- (void)clearErroMessage {
    self.errorMessage.hidden = true;
    self.ErrorMessageHeightConstraint.constant = 0;
}

- (void)showErroMessage: (NSString *) errorMessage {
    self.errorMessage.hidden = false;
    self.errorMessage.text = errorMessage;
    self.ErrorMessageHeightConstraint.constant = 21;
}

- (void)updateTextField: (UITextField *)textField andLabel: (UILabel *)textLabel withStyle: (TextFieldStyleEnum) style {
    switch (style) {
        case correctFieldStyle:
            textLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:129.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
            textField.layer.borderColor = [[UIColor clearColor]CGColor];
            break;
        case wrongFieldStyle:
            textLabel.textColor = [UIColor redColor];
            textField.layer.cornerRadius = 5.0f;
            textField.layer.masksToBounds = YES;
            textField.layer.borderColor = [[UIColor redColor]CGColor];
            textField.layer.borderWidth = 1.0f;
            break;
    }
}

- (NSString *)creatErrorMessage:(BOOL) isAnyFieldEmpty isAnyFieldWrong: (BOOL) isAnyFieldWrong {
    if (isAnyFieldEmpty) {
        return emptyFieldErrorMessage;
    } else if (isAnyFieldWrong) {
        return wrongFieldErrorMessage;
    }
    return @"";
}

- (BOOL)checkFirstAddress:(NSString *)address1 {
    BOOL isEmpty = (address1 == nil || address1.length == 0);
    [fieldsEmptinessDictionary setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:FirstAddressFieldTag]];
    BOOL isValid = [NSString isAddressValid:address1];
    [fieldsCorrectnessDictionary setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:FirstAddressFieldTag]];
    return !isEmpty && isValid;
}

- (BOOL)checkSecondAddress:(NSString *)address2 {
    BOOL isEmpty = (address2 == nil || address2.length == 0);
    [fieldsEmptinessDictionary setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:SecondAddressFieldTag]];
    if (!isEmpty) {
        BOOL isValid = [NSString isAddressValid:address2];
        [fieldsCorrectnessDictionary setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:SecondAddressFieldTag]];
    } else {
        [fieldsCorrectnessDictionary setObject: @NO forKey:[NSNumber numberWithInt:SecondAddressFieldTag]];
    }
    return YES; //address 2 field could be empty
}

- (BOOL)checkCity:(NSString *)city {
    BOOL isEmpty = (city == nil || city.length == 0);
    [fieldsEmptinessDictionary setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:CityFieldTag]];
    BOOL isValid = [NSString isCityValid:city];
    [fieldsCorrectnessDictionary setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:CityFieldTag]];
    return !isEmpty && isValid;
}

- (BOOL)checkState:(NSString *)state {
    BOOL isEmpty = (state == nil || state.length == 0);
    [fieldsEmptinessDictionary setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:StateFieldTag]];
    BOOL isValid = [NSString isStateValid:state];
    [fieldsCorrectnessDictionary setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:StateFieldTag]];
    return !isEmpty && isValid;
}

- (BOOL)checkZip:(NSString *)zip {
    BOOL isEmpty = (zip == nil || zip.length == 0);
    [fieldsEmptinessDictionary setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:ZipFieldTag]];
    BOOL isValid = [NSString isZipValid:zip];
    [fieldsCorrectnessDictionary setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:ZipFieldTag]];
    return !isEmpty && isValid;
}

- (BOOL)checkCountry:(NSString *)country {
    BOOL isEmpty = (country == nil || country.length == 0);
    [fieldsEmptinessDictionary setObject: [NSNumber numberWithBool:isEmpty] forKey:[NSNumber numberWithInt:CountryFieldTag]];
    BOOL isValid = [NSString isCountryValid:country];
    [fieldsCorrectnessDictionary setObject: [NSNumber numberWithBool:!isValid] forKey:[NSNumber numberWithInt:CountryFieldTag]];
    return !isEmpty && isValid;
}

@end
