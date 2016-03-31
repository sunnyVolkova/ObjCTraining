//
//  ContactUsViewController.h
//  ObjCTraining
//
//  Created by Sunny on 30/03/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkToUsLabel;


@end
