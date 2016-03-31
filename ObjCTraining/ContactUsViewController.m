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

@interface ContactUsViewController() {
    //variables for text detection
    NSLayoutManager *layoutManager;
    NSTextContainer *textContainer;
    NSTextStorage *textStorage;
}
@property UIView *activeField;
@end

static NSString * const linkToUsLabelText = @"Visit us on the web at streamloan.io";
static NSRange const linkRange = {23, 13};

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.delegate = self;
    self.emailField.delegate = self;
    self.subjectField.delegate = self;
    self.messageTextView.delegate = self;

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self initLabelWithLink];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    [self updateTextView:self.messageTextView withStyle:UnselectedFieldStyle];
}


- (void)viewWillDisappear:(BOOL)animated {
    [self deregisterForKeyboardNotifications];
    [super viewWillDisappear:animated];
}

#pragma mark - Keyboard interaction

- (void)dismissKeyboard {
    [self.view endEditing:YES];
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
    if (!self.isViewLoaded || !self.view.window) {
        return;
    }
    
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect keyboardFrameInWindow;
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrameInWindow];
    CGRect keyboardFrameInView = [self.view convertRect:keyboardFrameInWindow fromView:nil];
    CGRect scrollViewKeyboardIntersection = CGRectIntersection(self.scrollView.frame, keyboardFrameInView);
    UIEdgeInsets newContentInsets = UIEdgeInsetsMake(0, 0, scrollViewKeyboardIntersection.size.height, 0);

    self.scrollView.contentInset = newContentInsets;
    self.scrollView.scrollIndicatorInsets = newContentInsets;
    if (self.activeField) {
        CGRect controlFrameInScrollView = [self.scrollView convertRect:self.activeField.bounds fromView:self.activeField];
        controlFrameInScrollView = CGRectInset(controlFrameInScrollView, 0, -10);
        CGFloat controlVisualOffsetToTopOfScrollview = controlFrameInScrollView.origin.y - self.scrollView.contentOffset.y;
        CGFloat controlVisualBottom = controlVisualOffsetToTopOfScrollview + controlFrameInScrollView.size.height;
        CGFloat scrollViewVisibleHeight = self.scrollView.frame.size.height - scrollViewKeyboardIntersection.size.height;
        
        if (controlVisualBottom > scrollViewVisibleHeight) {
            CGPoint newContentOffset = self.scrollView.contentOffset;
            newContentOffset.y += (controlVisualBottom - scrollViewVisibleHeight);
            newContentOffset.y = MIN(newContentOffset.y, self.scrollView.contentSize.height - scrollViewVisibleHeight);
            [self.scrollView setContentOffset:newContentOffset animated:YES];
        } else if (controlFrameInScrollView.origin.y < self.scrollView.contentOffset.y) {
            CGPoint newContentOffset = self.scrollView.contentOffset;
            newContentOffset.y = controlFrameInScrollView.origin.y;
            [self.scrollView setContentOffset:newContentOffset animated:YES];
        }
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
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected Field tag"];
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
                break;
            default:
                [NSException raise:NSGenericException format:@"Unexpected Field tag"];
        }
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *) textView {
    self.activeField = textView;
    [self updateTextView:textView withStyle:SelectedFieldStyle];
    self.messageLabel.hidden = true;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.activeField = nil;
    [self updateTextView:textView withStyle:UnselectedFieldStyle];
    if (textView.text == nil || textView.text.length == 0) {
        self.messageLabel.hidden = false;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    }
    return NO;
}

#pragma mark - Input Fields Style

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
        default:
            [NSException raise:NSGenericException format:@"Unexpected style"];
    }
}

- (void)updateTextView:(UITextView *)textView withStyle:(TextFieldStyleEnum)style {
    switch (style) {
        case SelectedFieldStyle:
            textView.layer.cornerRadius = 5.0f;
            textView.layer.masksToBounds = YES;
            textView.layer.borderColor = [[UIColor greenColor]CGColor];
            textView.layer.borderWidth = 1.0f;
            break;
        case UnselectedFieldStyle:
            textView.layer.cornerRadius = 5.0f;
            textView.layer.masksToBounds = YES;
            textView.layer.borderColor = [[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:0.5f]CGColor];
            textView.layer.borderWidth = 0.5f;
            break;
        case WrongFieldStyle:
            textView.layer.cornerRadius = 5.0f;
            textView.layer.masksToBounds = YES;
            textView.layer.borderColor = [[UIColor redColor]CGColor];
            textView.layer.borderWidth = 1.0f;
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected style"];
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
            isCorrect = [self checkMessage: self.messageTextView.text];
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected Field Tag"];
    }
    return isCorrect;
}

- (void)invalidateFieldForTag:(NSInteger)tag isValid:(BOOL)isValid {
    __kindof UIView *field = [self.scrollView viewWithTag:tag];
    if ([field isKindOfClass:[UITextField class]]) {
        [self updateTextField: field withStyle: isValid ? UnselectedFieldStyle : WrongFieldStyle];
    } else if ([field isKindOfClass:[UITextView class]]) {
        [self updateTextView: field withStyle: isValid ? UnselectedFieldStyle : WrongFieldStyle];
    }
    
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

#pragma mark - Label With Link Setup

- (void)initLabelWithLink {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:linkToUsLabelText attributes:nil];
    NSDictionary *linkAttributes = @{ NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle) };
    [attributedString setAttributes:linkAttributes range:linkRange];

    self.linkToUsLabel.attributedText = attributedString;
    self.linkToUsLabel.userInteractionEnabled = YES;
    [self.linkToUsLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)]];

    layoutManager = [[NSLayoutManager alloc] init];
    textContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
    textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedString];

    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    
    textContainer.lineFragmentPadding = 0.0;
    textContainer.lineBreakMode = self.linkToUsLabel.lineBreakMode;
    textContainer.maximumNumberOfLines = self.linkToUsLabel.numberOfLines;
}

- (void)handleTapOnLabel:(UITapGestureRecognizer *)tapGesture {
    CGPoint locationOfTouchInLabel = [tapGesture locationInView:tapGesture.view];
    CGSize labelSize = tapGesture.view.bounds.size;
    CGRect textBoundingBox = [layoutManager usedRectForTextContainer:textContainer];
    CGPoint textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                              (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
    CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                         locationOfTouchInLabel.y - textContainerOffset.y);
    NSInteger indexOfCharacter = [layoutManager characterIndexForPoint:locationOfTouchInTextContainer
                                                       inTextContainer:textContainer
                              fractionOfDistanceBetweenInsertionPoints:nil];
    if (NSLocationInRange(indexOfCharacter, linkRange)){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://streamloan.io/"]];
    }
}

@end
