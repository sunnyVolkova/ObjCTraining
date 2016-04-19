//
//  SteppedSlider.h
//  ObjCTraining
//
//  Created by WeezLabs on 15/04/16.
//  Copyright © 2016 RWuser. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface SteppedSlider : UIView

//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;
//@property (weak, nonatomic) IBOutlet UIButton *decreaseButton;
//@property (weak, nonatomic) IBOutlet UIButton *increaseButton;
//@property (weak, nonatomic) IBOutlet UIImageView *trackImageView;
@property (nonatomic, assign) IBInspectable float minimumValue;
@property (nonatomic, assign) IBInspectable float maximumValue;
@property (nonatomic, assign) IBInspectable float deltaValue;
@property (nonatomic, assign) IBInspectable float value;
@property (nonatomic, assign) IBInspectable float scalePointsNumber;
@property (nonatomic, assign) IBInspectable NSString* title;
@property (nonatomic, assign) IBInspectable Boolean isMinStrict;
@property (nonatomic, assign) IBInspectable Boolean isMaxStrict;
@property (nonatomic) IBInspectable NSNumberFormatter *currentValueFormatter;
@end
