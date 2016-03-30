//
//  ContactUsViewController.m
//  ObjCTraining
//
//  Created by Sunny on 30/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import "ContactUsViewController.h"
#import "NSString+CheckInput.h"

typedef NS_ENUM(NSInteger, InputFieldsEnum) {
    NameFieldTag = 1,
    EmailFieldTag,
    SubjectFieldTag,
    MessageFieldTag,
    FirstField = NameFieldTag,
    LastField = MessageFieldTag
};

typedef NS_ENUM(NSInteger, TextFieldStyleEnum) {
    SelectedFieldStyle = 1,
    UnselectedFieldStyle,
    WrongFieldStyle
};

@interface ContactUsViewController ()
@property UIView *activeField;
@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.delegate = self;
    self.emailField.delegate = self;
    self.subjectField.delegate = self;
    self.messageField.delegate = self;

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

- (void)registerForKeyboardNotifications {
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

- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect windowRect = [self getScreenFrameForCurrentOrientation];
    CGFloat windowHeight = windowRect.size.height;
    CGFloat insetChange = self.scrollView.contentSize.height - windowHeight + kbSize.height + self.titleLabel.frame.size.height;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, insetChange, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    aRect.size.height += self.navigationController.navigationBar.frame.size.height;
    
    if (self.activeField != nil && !CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - actions

- (IBAction)submitButtonPressed:(UIButton *)sender {
    if([self checkInputFields]) {
        NSLog(@"Submit");
    }
}

- (IBAction)textFieldEditingDidBegin:(UITextField *)sender {
    self.activeField = sender;
    [self updateTextField:sender withStyle:SelectedFieldStyle];
    switch (sender.tag) {
        case NameFieldTag:
            self.nameLabel.hidden = true;
            break;
        case SubjectFieldTag:
            self.subjectLabel.hidden = true;
            break;
        case EmailFieldTag:
            self.emailLabel.hidden = true;
            break;
        case MessageFieldTag:
            self.messageLabel.hidden = true;
            break;
    }
}

- (IBAction)textFieldEditingDidEnd:(UITextField *)sender {
    self.activeField = nil;
    [self updateTextField:sender withStyle:UnselectedFieldStyle];
    if (sender.text == nil || sender.text.length == 0) {
        switch (sender.tag) {
            case NameFieldTag:
                self.nameLabel.hidden = false;
                break;
            case SubjectFieldTag:
                self.subjectLabel.hidden = false;
                break;
            case EmailFieldTag:
                self.emailLabel.hidden = false;
                break;
            case MessageFieldTag:
                self.emailLabel.hidden = false;
                break;
        }
    }
}

#pragma mark - screen frame info

- (CGRect)getScreenFrameForCurrentOrientation {
    return [self getScreenFrameForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (CGRect)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation {
    CGRect fullScreenRect = [[UIScreen mainScreen] bounds];
    
    // implicitly in Portrait orientation.
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        CGRect temp = CGRectZero;
        temp.size.width = fullScreenRect.size.height;
        temp.size.height = fullScreenRect.size.width;
        fullScreenRect = temp;
    }
    
    CGFloat statusBarHeight = 20;
    fullScreenRect.size.height -= statusBarHeight;
    return fullScreenRect;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    }
    
    if(textField.tag == MessageFieldTag) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - TextField Style

- (void)updateTextField:(UITextField *)textField withStyle:(TextFieldStyleEnum)style {
    switch (style) {
        case SelectedFieldStyle:
            textField.layer.cornerRadius = 5.0f;
            textField.layer.masksToBounds = YES;
            textField.layer.borderColor = [[UIColor greenColor]CGColor];
            textField.layer.borderWidth = 1.0f;
            break;
        case UnselectedFieldStyle:
            textField.layer.borderColor = [[UIColor clearColor]CGColor];
            break;
        case WrongFieldStyle:
            textField.layer.cornerRadius = 5.0f;
            textField.layer.masksToBounds = YES;
            textField.layer.borderColor = [[UIColor redColor]CGColor];
            textField.layer.borderWidth = 1.0f;
            break;
    }
}

#pragma mark - Validation

- (BOOL)checkInputFields {
    BOOL isAllFieldsCorrect = YES;
    for (int tag = FirstField; tag <= LastField; ++tag) {
        BOOL isCorrect = [self checkFieldWithTag:tag];
        [self invalidateFieldForTag: tag isValid: isCorrect];
        isAllFieldsCorrect = isAllFieldsCorrect && [self checkFieldWithTag:tag];
    }
    return isAllFieldsCorrect;
}

- (BOOL)checkFieldWithTag:(NSInteger)tag {
    BOOL isCorrect = NO;
    switch (tag) {
        case NameFieldTag:
            isCorrect = [self checkName: self.nameField.text];
            break;
        case SubjectFieldTag:
            isCorrect = [self checkSubject: self.subjectField.text];
            break;
        case EmailFieldTag:
            isCorrect = [self checkEMail: self.emailField.text];
            break;
        case MessageFieldTag:
            isCorrect = [self checkMessage: self.messageField.text];
            break;
    }
    return isCorrect;
}

- (void)invalidateFieldForTag:(NSInteger)tag isValid:(BOOL)isValid {
    UITextField *textField = [self.scrollView viewWithTag:tag];
    [self updateTextField: textField withStyle: isValid ? UnselectedFieldStyle : WrongFieldStyle];
}

- (BOOL)checkName:(NSString *)name {
    BOOL isEmpty = (name == nil || name.length == 0);
    return !isEmpty;
}

- (BOOL)checkEMail:(NSString *)email {
    BOOL isEmpty = (email == nil || email.length == 0);
    BOOL isValid = [NSString isEmailValid:email];
    return !isEmpty && isValid;
}

- (BOOL)checkSubject:(NSString *)subject {
    BOOL isEmpty = (subject == nil || subject.length == 0);
    return !isEmpty;
}

- (BOOL)checkMessage:(NSString *)message {
    BOOL isEmpty = (message == nil || message.length == 0);
    return !isEmpty;
}
@end
